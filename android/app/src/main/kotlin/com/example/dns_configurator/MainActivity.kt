package com.example.dns_configurator


import android.content.BroadcastReceiver
import android.content.Context
import io.flutter.embedding.android.FlutterActivity


import android.util.Log
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.PersistableBundle
import android.widget.Toast
import androidx.annotation.RequiresApi

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import java.io.FileInputStream
import java.io.IOException
import java.io.OutputStream
import java.net.DatagramSocket
import java.net.InetSocketAddress
import java.net.Socket
import java.net.SocketAddress
import java.nio.ByteBuffer
import java.nio.channels.DatagramChannel
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets


class MainActivity: FlutterActivity(){
    private val CHANNEL="dns.configurator/channel"
    private  val METHOD_NAME="modify_dns"
    private  val STOP_METHOD="STOP"
    private  var mreceiver:BroadcastReceiver?=null
    private val VPN_CODE=100



    override fun onCreate(savedInstanceState: Bundle?) {

        // create reciver for to communicate with my service
      mreceiver=object :BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
       if(intent?.action=="recive_data_from_client"){
           val data=intent.getStringExtra("data")
           Log.println(Log.INFO,"Tag","data from vpn $data")
       }
    }
}      // register the reciver
        registerReceiver(mreceiver, IntentFilter("recive_data_from_client"))
        super.onCreate(savedInstanceState)
    }

    override fun onStop() {

        // unregister the reciver when stop
        unregisterReceiver(mreceiver)
        super.onStop()
    }
    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler { call, result->


            if(call.method==METHOD_NAME){
                val  dns=call.argument<String>("dns")
                startVpn(dns!!)
                result.success("service start....")


            }
            else if(call.method==STOP_METHOD){
                stopVpnService()
                result.success("service stop")

            }

            else
            {
                result.notImplemented()
            }

        }
    }



    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private fun startVpn(dns:String){
        val intent=VpnService.prepare(this)
        if(intent!=null){
            startActivityForResult(intent,VPN_CODE)
        }else{
            startVpnService(dns)
        }
    }
    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private  fun startVpnService(dns:String){
        val inten=Intent(this,MyVpnServices::class.java)
        inten.putExtra("dns",dns)
        startService(inten)
    }
    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private  fun stopVpnService(){
        val inten=Intent(this,MyVpnServices::class.java)
        stopService(inten)
    }

}

@RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
public class MyVpnServices() : VpnService() {
    private val  TAG:String ="Vpn Service"
    public  val my_action:String= "recive_data_from_client"
    private var isRunnig:Boolean=false


    private var ServerIp:String ="10.0.2.15"
    private  var SetverPort:Int =0

    private  val  _handler:Handler= Handler(Looper.getMainLooper());
    private var vpnInterface: ParcelFileDescriptor? = null

    private  var dnsJob:Job?=null


    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val dns=intent?.getStringExtra("dns")
        if(!(dns.isNullOrEmpty())){
            startVpn(dns)
        }
        return  START_STICKY
    }
    @RequiresApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    fun startVpn(dnsAddress: String) {
  if(  establishConnection(dnsAddress)){
     CoroutineScope(Dispatchers.IO).launch {
         readDataFromInterface()
     }
  }



    }

    private fun establishConnection(dnsAddress:String):Boolean {
       if(vpnInterface==null){
           val builder = Builder()
           builder.setSession("MyDNSVpnService")
           builder.addAddress(ServerIp, 24) // Example local VPN address
           builder.addDnsServer(dnsAddress) // Set your custom DNS server

           builder.addRoute("0.0.0.0", 0)   // Route all traffic
           vpnInterface = builder.establish()

           return  vpnInterface!=null;
       }else
       {
           _handler.post(Runnable { Toast.makeText(this,"Connection Already establish",Toast.LENGTH_SHORT) })

       }
        return  true
    }

  private  fun readDataFromInterface(){
      isRunnig=true
      val bytes:ByteBuffer= ByteBuffer.allocate(1024)
      val channel:DatagramChannel=DatagramChannel.open();
      channel.socket().bind(InetSocketAddress(ServerIp,SetverPort))
      while (isRunnig){

          try {

         val file:FileInputStream =FileInputStream(vpnInterface!!.fileDescriptor)
         val  size:Int=file.read(bytes.array())

              if(size>0){
                  bytes.clear()
                  val recivedData= String(bytes.array(),0,size)
                  val intent:Intent=Intent(my_action)
                  intent.putExtra("data",recivedData)
                  sendBroadcast(intent)//
                  // convert recived data into byte array


                  val buffer=ByteBuffer.wrap(recivedData.toByteArray())
                  val clientAddress=channel.receive(buffer)
                  buffer.flip()
                  writeToNetwork(buffer,size,channel,clientAddress)

              }

          }catch (e:IOException){
              Log.e(TAG,"error during reading data "+e.message)
          }
      }


  }

    private  fun writeToNetwork(bytes:ByteBuffer,size:Int,channel: DatagramChannel,clientAddress:SocketAddress){
      try {
          // get the data in format of string so i can get exact size of packet data
          val data:String=String(bytes.array(),0, size)
          // create socket

          // encode data into utf_8 format and convert it into byteArray
          val bytesArray:ByteArray=data.toByteArray(Charsets.UTF_8)
          val buffer=ByteBuffer.wrap(bytesArray)
          // get output stream from socket to write the data into socket

         channel.send(buffer,clientAddress)
      }catch (e:IOException){
          Log.e(TAG,"Error while write to network "+e.message)

      }
    }
    override fun onDestroy() {
        isRunnig=false
        vpnInterface?.close()
        vpnInterface=null
        super.onDestroy()

    }}



class  LocalBroadCastManger: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        TODO("Not yet implemented")
    }


}
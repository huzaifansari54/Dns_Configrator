package com.example.dns_configurator

import android.util.Log
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.IOException


class MainActivity: FlutterActivity(){
    private val CHANNEL="dns.configurator/channel"
    private  val METHOD_NAME="modify_dns"
    private  val STOP_METHOD="STOP"

    private val VPN_CODE=100
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



     private fun startVpn(dns:String){
         val intent=VpnService.prepare(this)
         if(intent!=null){
             startActivityForResult(intent,VPN_CODE)
         }else{
             startVpnService(dns)
         }
     }
  private  fun startVpnService(dns:String){
      val inten=Intent(this,MyVpnServices::class.java)
      inten.putExtra("dns",dns)
      startService(inten)
  }
    private  fun stopVpnService(){
        val inten=Intent(this,MyVpnServices::class.java)
       stopService(inten)
    }

}

class MyVpnServices() : VpnService() {

    private var vpnInterface: ParcelFileDescriptor? = null


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
       val dns=intent?.getStringExtra("dns")
        if(!(dns.isNullOrEmpty())){
            startVpn(dns)
        }
        return  START_STICKY
    }
    fun startVpn(dnsAddress: String) {
        val builder = Builder()
        builder.setSession("MyDNSVpnService")
        builder.addAddress("10.0.2.15", 24) // Example local VPN address
        builder.addDnsServer(dnsAddress) // Set your custom DNS server
        builder.addRoute("0.0.0.0", 0)   // Route all traffic

        vpnInterface = builder.establish()


    }




    override fun onDestroy() {
        vpnInterface?.close()
        vpnInterface=null
        super.onDestroy()

    }



}
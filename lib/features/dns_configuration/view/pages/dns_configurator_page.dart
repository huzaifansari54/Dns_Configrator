import 'package:dns_configurator/core/extensions/types.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_impl.dart';
import 'package:dns_configurator/features/dns_configuration/state_controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';

class DnsConfiguratorPage extends ConsumerStatefulWidget {
  @override
  _DnsConfiguratorPageState createState() => _DnsConfiguratorPageState();
}

class _DnsConfiguratorPageState extends ConsumerState<DnsConfiguratorPage> {
  final _dnsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _updateDNS() async {
    if (_formKey.currentState!.validate()) {
      final dnsAddress = _dnsController.text;
      ref.onUpdateDns(context);

      // Platform-specific code to update DNS will be placed here
      // For now, we simulate success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updating DNS to $dnsAddress...')),
      );

      // Clear the input field
      _dnsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dnsState = ref.watch(stateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DNS Configurator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !dnsState.isNetwork
                    ? AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(seconds: 1),
                        width: double.maxFinite,
                        color: Colors.red,
                        child: const Text("No Network"),
                      )
                    : const SizedBox(),
                TextFormField(
                  onChanged: ref.onDnsChanged,
                  controller: _dnsController,
                  decoration: const InputDecoration(
                    labelText: 'Enter DNS IP address',
                    hintText: 'e.g., 8.8.8.8',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a DNS IP address';
                    }
                    // Validate the IP address format
                    if (!dnsState.validDns()) {
                      return 'Invalid IP address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                dnsState.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: _updateDNS,
                          child: const Text('Update DNS'),
                        ),
                      ),
                ...dnsState.logs.map((e) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("DNS: ${e.dsaAddress}"),
                                  Text("Time ${e.timesTamps}"),
                                ],
                              ),
                              Switch(
                                  value: ref.isActive(e.dsaAddress),
                                  onChanged: (val) =>
                                      ref.onIsActivityChanged(e.dsaAddress))
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

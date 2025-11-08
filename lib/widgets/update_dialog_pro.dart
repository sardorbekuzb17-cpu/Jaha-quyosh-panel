import 'package:flutter/material.dart';
import '../services/update_service.dart';

class UpdateDialogPro extends StatefulWidget {
  final UpdateInfo updateInfo;
  
  const UpdateDialogPro({Key? key, required this.updateInfo}) : super(key: key);
  
  @override
  _UpdateDialogProState createState() => _UpdateDialogProState();
}

class _UpdateDialogProState extends State<UpdateDialogPro> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _statusText = '';
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.updateInfo.isForced,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.system_update, color: Colors.green, size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '🎉 Yangilanish mavjud',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Versiya ma'lumoti
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.new_releases, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Yangi versiya: ${widget.updateInfo.version}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Majburiy yangilanish ogohlantirishi
            if (widget.updateInfo.isForced)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Bu yangilanish majburiy!',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            
            if (widget.updateInfo.isForced) const SizedBox(height: 16),
            
            // O'zgarishlar ro'yxati
            const Text(
              'Yangi xususiyatlar:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.updateInfo.changelog.map((change) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          Expanded(child: Text(change, style: const TextStyle(fontSize: 13))),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ),
            
            // Yuklanish jarayoni
            if (_isDownloading) ...[
              const SizedBox(height: 20),
              const Text('Yuklab olinmoqda...', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _downloadProgress,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_statusText, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('${(_downloadProgress * 100).toInt()}%', 
                       style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ],
        ),
        actions: _isDownloading ? [] : [
          // Keyin tugmasi (faqat majburiy bo'lmasa)
          if (!widget.updateInfo.isForced)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Keyin', style: TextStyle(color: Colors.grey)),
            ),
          
          // Yangilash tugmasi
          ElevatedButton.icon(
            onPressed: _downloadAndInstall,
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Yangilash'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _downloadAndInstall() async {
    setState(() {
      _isDownloading = true;
      _statusText = 'Tayyorlanmoqda...';
    });
    
    try {
      final filePath = await UpdateService.downloadApk(
        widget.updateInfo.downloadUrl,
        (progress) {
          setState(() {
            _downloadProgress = progress;
            _statusText = 'Yuklab olinmoqda...';
          });
        },
      );
      
      if (filePath != null) {
        setState(() {
          _statusText = 'O\'rnatilmoqda...';
        });
        
        await UpdateService.installApk(filePath);
        
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        _showError('Yuklab olishda xato yuz berdi');
      }
    } catch (e) {
      _showError('Xato: $e');
    }
  }
  
  void _showError(String message) {
    setState(() {
      _isDownloading = false;
      _downloadProgress = 0.0;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Qayta urinish',
          textColor: Colors.white,
          onPressed: _downloadAndInstall,
        ),
      ),
    );
  }
}
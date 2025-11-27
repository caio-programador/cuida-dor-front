# Configuração de Notificações - CuidaDor

## 📱 Sistema de Notificações Implementado

O app agora possui um sistema inteligente de notificações que lembra o usuário de registrar sua dor.

### 🎯 Funcionalidades

1. **Intervalo Variável**: Notificações são agendadas entre 4 a 6 horas após a última sessão (não é exato, tem variação aleatória)
2. **Horário Permitido**: Notificações só são enviadas entre 7h e 22h
3. **Ajuste Automático**: Se a notificação for agendada fora do horário permitido, é automaticamente reagendada para 7h
4. **Mensagens Variadas**: 5 mensagens diferentes são exibidas aleatoriamente

### 🔧 Configurações Necessárias

#### Android (android/app/src/main/AndroidManifest.xml)

Adicione as seguintes permissões dentro da tag `<manifest>`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permissões para notificações -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
    <uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    
    <application
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Adicione este receiver para notificações -->
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
        
        <!-- Resto da configuração -->
    </application>
</manifest>
```

#### iOS (ios/Runner/AppDelegate.swift)

Para iOS, adicione no arquivo AppDelegate.swift:

```swift
import UIKit
import Flutter
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 📊 Como Funciona

1. **Inicialização**: O serviço é inicializado no `main.dart` quando o app inicia
2. **Atualização de Sessão**: Sempre que o usuário abre a home, a sessão é atualizada
3. **Registro de Dor**: Ao registrar uma dor, a sessão é atualizada e uma nova notificação é agendada
4. **Agendamento Inteligente**: 
   - Calcula tempo desde última sessão
   - Adiciona variação aleatória (4-6 horas)
   - Ajusta horário se necessário (evita 22h-7h)
   - Agenda notificação

### 🎨 Personalização

Você pode personalizar as mensagens em `notification_service.dart`:

```dart
final messages = [
  'Como está sua dor hoje? Registre no CuidaDor! 💙',
  'Hora de registrar seu bem-estar no CuidaDor 📊',
  // Adicione mais mensagens aqui
];
```

### 🐛 Debugging

Para testar as notificações, você pode:

1. Verificar se estão habilitadas:
```dart
final enabled = await NotificationService.areNotificationsEnabled();
print('Notificações habilitadas: $enabled');
```

2. Forçar uma notificação imediata (para testes):
   - Modifique temporariamente o tempo de 4 horas para 1 minuto no código

### 📝 Notas

- As notificações são persistentes mesmo se o app for fechado
- No Android 13+, o usuário precisa aceitar as permissões de notificação
- As mensagens variam para não ficar repetitivo
- O horário é respeitado para não incomodar o usuário durante a noite

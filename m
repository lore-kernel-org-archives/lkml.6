Return-Path: <ghane0@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522253278; cv=none;
        d=google.com; s=arc-20160816;
        b=0G/4b/ANPTpYx/WPKDZflQC5jm1nTusUKVTEJ0WSA5o/0cm4u7YJGVJ4ZBTGdUUVmS
         Y9a0tFVEM8nH5Jd539UfczzzMS1/JfnRBAgdkdL9RTgIqmcKjybVG+yQ3TgAts0L8O6J
         AN5Y6hr/MqzX8O+UbWH5bq59/+tC6qtYs/0kzyPcgrtUN0itS5Gi2PShlkGGJKhY/UWj
         nVU0QtX31CD/7+nIiAChUElnl1slXJQoA1Skt/eJ0qdHRMS9dENJdAuxpdlxepfAZC6f
         fuTwC4MzUufkaQ6RNuXmPA7jWZ0MoK8g5mpna088L3ZA1k4dR2R9+cTu0Y8nnA9sjsDv
         vtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=ItM+uD+gVrAW3cprfTfFIBVA9gSw5HM/18HzoFvXwjk=;
        b=oIDNTfa0aw4c1eb7OzM1RB03FqZHrMuy+pMz7aZBdpuQzdyfoGvOG49WzQqYQQyscF
         zLJILKP+LDKgs8n9K30Y208s801MwpwGRz8EFFhGxc4R1x2czJCLNOH3u+9aW06WSlkU
         VPhHYndj66nolfCMf4QwJTbIhg61rVxIq63A+kcJqx9/UmoZDa3WqQLMUF9E2EMWgdAB
         sZsEpvvVBmBj7lWjE97l8SuTgaPtyUEcCdjmkwmoMqANMny3MT7z5l8AJ60lexgEtEsK
         Sot2aoEIv8H+c+vd+TtSa+bBzeGH3N/csF856YisY+qZhsL+6g/ACh/3fb80YGiSKYNh
         wUQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SKDPTclk;
       spf=pass (google.com: domain of ghane0@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghane0@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SKDPTclk;
       spf=pass (google.com: domain of ghane0@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghane0@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49BZpSAYgy1OIhDYEZqISCgIjwziQXcOFr1q9S8sCdmUToSgn5+tCVvjeMdlduFLTLj7wQMew==
From: Sanjeev Gupta <ghane0@gmail.com>
To: corbet@lwn.net,
	gregkh@linuxfoundation.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/usb: Fix dead links and convert others to https
Date: Thu, 29 Mar 2018 00:07:52 +0800
Message-Id: <20180328160752.17840-1-ghane0@gmail.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596198252944820308?=
X-GMAIL-MSGID: =?utf-8?q?1596198252944820308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All links checked, for those dead, I have replaced with copies on
archive.org.  For some, https is not supported, http has been
kept.

The git log says this was last done by Justin P. Mattock in 2010.
Hi, Justin!

Signed-off-by: Sanjeev Gupta <ghane0@gmail.com>
---
 Documentation/usb/usb-serial.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
index 349f3104fa4f..1c5c1da4f54e 100644
--- a/Documentation/usb/usb-serial.txt
+++ b/Documentation/usb/usb-serial.txt
@@ -83,7 +83,7 @@ HandSpring Visor, Palm USB, and Clié USB driver
   parameters.  e.g. modprobe visor vendor=0x54c product=0x66
   
   There is a webpage and mailing lists for this portion of the driver at:
-  http://sourceforge.net/projects/usbvisor/
+  https://sourceforge.net/projects/usbvisor/
 
   For any questions or problems with this driver, please contact Greg
   Kroah-Hartman at greg@kroah.com
@@ -105,15 +105,16 @@ PocketPC PDA Driver
   kbytes/sec for download/upload to my iPAQ.
 
   This driver is only one of a set of components required to utilize
-  the USB connection. Please visit http://synce.sourceforge.net which
+  the USB connection. Please visit https://synce.sourceforge.net which
   contains the necessary packages and a simple step-by-step howto.
 
   Once connected, you can use Win CE programs like ftpView, Pocket Outlook
   from the PDA and xcerdisp, synce utilities from the Linux side.
 
   To use Pocket IE, follow the instructions given at
-  http://www.tekguru.co.uk/EM500/usbtonet.htm to achieve the same thing
-  on Win98. Omit the proxy server part; Linux is quite capable of forwarding
+  https://web.archive.org/web/20030415065014/http://www.tekguru.co.uk:80/EM500/usbtonet.htm
+  to achieve the same thing on Win98.
+  Omit the proxy server part; Linux is quite capable of forwarding
   packets unlike Win98. Another modification is required at least for the
   iPAQ - disable autosync by going to the Start/Settings/Connections menu
   and unchecking the "Automatically synchronize ..." box. Go to
@@ -184,7 +185,7 @@ Keyspan USA-series Serial Adapters
     functionality.
   
   More information is available at:
-        http://www.carnationsoftware.com/carnation/Keyspan.html
+        https://www.carnationsoftware.com/carnation/Keyspan.html
    
   For any questions or problems with this driver, please contact Hugh
   Blemings at hugh@misc.nu
@@ -436,7 +437,8 @@ Winchiphead CH341 Driver
   also implements an IEEE 1284 parallel port, I2C and SPI, but that is not
   supported by the driver. The protocol was analyzed from the behaviour
   of the Windows driver, no datasheet is available at present.
-  The manufacturer's website: http://www.winchiphead.com/.
+  The manufacturer's website:
+  https://web.archive.org/web/20170911133726/http://winchiphead.com/ .
   For any questions or problems with this driver, please contact
   frank@kingswood-consulting.co.uk.
 
-- 
2.15.1

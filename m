Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpDYglIBI3D01AYuDV1Boc5atBeJqD94WpVtYC8kdnAQRvY33luuq5+rCc8N31kwq90R69
ARC-Seal: i=1; a=rsa-sha256; t=1527156198; cv=none;
        d=google.com; s=arc-20160816;
        b=jJGkyqzFtmN88NSw56mGmmw6kmsbEkZvfx5eBNqySdu7xeBCz+wEJefJ6exv1Bap/z
         zXozwknB2uc34m6OXf3uCukGhDy/2611GjYZjm/65EFf8a3fDVYMAL9XIk5zDN5iV25T
         ju5D6qUtZGj+Hot59KR4AWvASSoMedQHjRA6Gq0rPpprkTAQRlHJV5dlVPyP2ma4MRKO
         583iSAIJNOZoYWoE2/9plEOuD7BXLm/d+f/4+v3jK8cFfCZI2kHI/Aaj+Ts9yKEm1mPI
         nTB7A6Ny7UntlfFIqXrQ7mF7/DjKwRTEUYLiotR4ag422z6g6bwVdOVFmM1NJJZqYmWv
         sKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=M0/4u0cfTqaReopLuymWK2Gl1YH7CMfXhgdUUAUfHao=;
        b=Ev/66WfbWHJcTO6u9P0H4pgzA6J6ioTxjA75kB6ELj8eI1GdZmKvohSEMRi9Z/EKks
         zeL5Kch28CPVzDMweL81nzjgFclsGBXwLKgvrUMbOzVuCCczvpizdhtPM1Ga65S48E85
         ODAuua0cCMt0kRG5ag29V4qR4ZiyHQhDwEhICEOIYs50mQPpIUn12X1gySySAmH4YOxO
         Xz3UPp5PioUNQqz2v71iI6UjT7tTG3BP8TtLdgPdaAzQZLtIZLTtClaxhL9nHB4big2j
         VGqWtTTqYogJcMTeMNxT+oHIu7XdUldkb6jrf+WXe/HKJsEYw/gZb2df2NHm6k1JTy2Q
         Rv3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m3AvPlVi;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m3AvPlVi;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vicente Bergas <vicencb@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 066/161] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB
Date: Thu, 24 May 2018 11:38:11 +0200
Message-Id: <20180524093026.395831529@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338389720784307?=
X-GMAIL-MSGID: =?utf-8?q?1601339338094874560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicente Bergas <vicencb@gmail.com>

[ Upstream commit a41e0796396eeceff673af4a38feaee149c6ff86 ]

This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.

Product information:
https://wikidevi.com/wiki/Edimax_EW-7611ULB

>From /sys/kernel/debug/usb/devices
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=a611 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Edimax Wi-Fi N150 Bluetooth4.0 USB Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 6 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8723bu
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=500us
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -367,6 +367,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3494), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8723BU Bluetooth devices */
+	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },

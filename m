Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GD6XpEc65/8el7UUsZD9qH+Xnep8Xi2IBOQ1IhRQ3+bZzFUtpBY8oMRJtFHNzR8IcIWA0
ARC-Seal: i=1; a=rsa-sha256; t=1523021753; cv=none;
        d=google.com; s=arc-20160816;
        b=V3HGxhRG0ajqSE3n3Gs9I2ygDfqqQdZBdeLThT1WlNxIqVnyYqUmw//b0JuPxVYhge
         23W4SyDO23YQhH5eoNut446inT1iyoBIWGjc2tVQuPIFJ7Hp8YUjOczDdPHiYYaveyKq
         YGU6w0VyJf9qQgS7j+fbTec0XiPEvVt2rcKgvX10jlWlAK02AUcQdpHghvk7CEGvbqaa
         11svuE2C8i9EzgHFD6n1ywuiOhvLZqN+MIIvJQ1AcTVk0NwSYMuCuNwbz6J2xFs68hTI
         rizVvLpkosTRqct5QPwnnqToz5FxNnjTFXPsl2zKP79mPIBl7KN4hfGnCO8tBrb4Qe/j
         DWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IsUysHCRvrffD/BkGM8m3I8NzppmlYKhax28NETrizI=;
        b=jzeo2O/0FM56LAsWiCVAFNDQaO5nH+KyChv+EcCX2bUgC4JNaEaxES3Hv0VOfqG1pP
         15vN/A2OlkaoelRiTCAfnJbYkqR6nK697IWtH5rCCO1B8sS+oAj4OLEWo0WJC4y0HiGb
         z0QI8JtwbSps/txE1e82p8g1F2hOp8t2YVAk6khZ2rgDBuY60h0L5rIDAN5QDrAgPZ4W
         CBIOfwZYgD7MKGpKWP/Tb7zuRIlKemilnxGbru8rtOgU6fSbNguTfPlyGRBGyEPSmpDL
         ea7RvNNR5oVrpLW9B87pvCxL7j/EeaSi2fFH67X0xlAM/ujWhlK0nIYzvKfqWkALP/Hp
         /tKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Jansen <nattelip@hotmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 079/102] USB: serial: cp210x: add ELDAT Easywave RX09 id
Date: Fri,  6 Apr 2018 15:24:00 +0200
Message-Id: <20180406084342.664162841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003577185601362?=
X-GMAIL-MSGID: =?utf-8?q?1597004058098145630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 1f1e82f74c0947e40144688c9e36abe4b3999f49 upstream.

Add device id for ELDAT Easywave RX09 tranceiver.

Reported-by: Jan Jansen <nattelip@hotmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -152,6 +152,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automation Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Interface */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */

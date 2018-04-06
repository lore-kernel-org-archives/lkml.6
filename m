Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48KSxtNOcIHZpf7gQ30rL634oV84seCBzXmtoLTKdAGiBS4jJLPzqB7OfFYd73zIq3wHUE/
ARC-Seal: i=1; a=rsa-sha256; t=1523021294; cv=none;
        d=google.com; s=arc-20160816;
        b=t68wxiEEufOY/bJe+DjtGUI+Gj0ftY/WXqY5cyDZW1gzbDsj2ziS8pzucIEei0yx4L
         8lAU70ZsivRHVA8veGW9WGBBqa6zbhiN/BKQf8uguO0sHtdETlbzg7tSe4deiP8O+eFD
         E626l2TdtaJXvc38ySsXgI1NN7Yw9kc8K5JDPsKWcHQG+ZLeOwbM7aIVDPoVA98Fm+ui
         6JCMkKw772P9DpvFyfsjBziugDsNAWTN1u2T4nLk6yVCbzkABxfTVbuyDGknGhmiEZkD
         R9/hk6/NJZ6S6nMvUOcAX1aDL34Vh3cVjVqTbuxbJ2ZEE1C5tYWH0cM/34NReocx5cl3
         9b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jzm1MMkhC9G5Lq88jzm8vP/hv8Zr1TZiBMZ4Wu2Lw5c=;
        b=tlcTfMSsgBkGhZvnwksX8ZU5v0Tj2Z6/KU1XrxTIaW6FFQbm5V2RR5vJXD01m4TEYH
         0d4pMLBLYh7We4X8Uq41pIp7Nmm3lnJAi6Do/OUM9lt+OjlHKgB2s2U7KZJfFzhcUpff
         Ww3qP7ozZbSe/iciseJ0ylpBsithJ4mqAFwJcpts6omY6NB0QyFm/Lw5Y3Lu1dWch9NH
         ZDG5yHJ6m3rBU6ZeVH8Xw13LB/p8mgHXxI6nEUIbdzeSTdngkAoX452ezDZoBRcI5ue4
         oEjWU8CbqMbIsxFdsyTdeYakMt8r90J5P3C+0qacd7wW69bXhRqteGT6ykLG4EMF3tkT
         0CIQ==
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
Subject: [PATCH 3.18 77/93] USB: serial: cp210x: add ELDAT Easywave RX09 id
Date: Fri,  6 Apr 2018 15:23:46 +0200
Message-Id: <20180406084228.444375726@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003577185601362?=
X-GMAIL-MSGID: =?utf-8?q?1597003577185601362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -149,6 +149,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automation Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Interface */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */

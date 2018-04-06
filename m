Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+M54mm0bPH4VY5pqc9KQmYasWHyCVb0zN2PtC8hPoQiA5jIQ5e8+1mPsemCMBm/ynVerpJ
ARC-Seal: i=1; a=rsa-sha256; t=1523022145; cv=none;
        d=google.com; s=arc-20160816;
        b=ayqTLMwDG368YKq9pCfaBJmbvLM91oaJLXODMB8wKScWXc1tbKxTVA3iMjngYUGBIr
         mVrvUTk0aQIAdpV6zHmn/B6B5D7W2FYdCTOXhX/dCDp10QojZEvN2bf/UpMx6wjL+EVm
         +O1Wqjr72jL8Dc3t3JQCuhyROGffKN9ovFL2LbnGI3hkGBFXXfg5cgzcB3SlHSklPE3/
         AKv16p3wqdnhgry/LwPZyB8PGyYO8Ogj62acbq5t+iKn9LbRFMvDNNYwsUxzQImS7e8/
         blGAT5UPJFY7YxODbR/Kw1Dkbm6747UMVdD8Bgjn2eGLvZMBgkSYwoAr6RBAGpKcncVU
         ///A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nG3RjXtd7rZuvynquEf8K9iKKKwdpFnQ/fgNPflAYX4=;
        b=xicVCZIvvMhUTr1at9MHLQNVhwfy4RRcEL9fvAfM6EPjdijlcZuVdR3FlejtjqzbZT
         I7307WRRAvtCD1+QVyREu0qGiskA700KDS0Mx1hRCdilOPH4Mz8GGPnpiYacF7t27OX5
         xUZCdbEOiaNxzqF5ejRQIFKMJhVXdVMB/w8fj2hhgY1GY8DGskSWHrqEdRB3PPBYu7AR
         S3yCGlapcgF4vLG0UJ/fNocxk4elZKC8IRYvsnqjIaX1CWX72nmie6d6Bk7O1Hqm2giw
         oTl3+7j34fputc4nYAMMZiJ3ZKvBg8dwaSwfGUofZoZrOWH0YziZeFj1YZyfN3wvMvMe
         wPhA==
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
Subject: [PATCH 4.15 43/72] USB: serial: cp210x: add ELDAT Easywave RX09 id
Date: Fri,  6 Apr 2018 15:24:18 +0200
Message-Id: <20180406084352.633331443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003577185601362?=
X-GMAIL-MSGID: =?utf-8?q?1597004468803077972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -155,6 +155,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automation Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Interface */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48WSf+Y8By5cHfVs+JZSIQcKOKMqYvLpjXChy9Y5/oU8NNIauqWvVmPf89LjSbKxxb8uyym
ARC-Seal: i=1; a=rsa-sha256; t=1523022034; cv=none;
        d=google.com; s=arc-20160816;
        b=gho4NBBKSiVFKfa0F5cAeGOWd5L/vqwocNz1QOrqoXtS60/MaGoxzzWcvjYswbMIdv
         aYG6THlasjLsvYpYulonL2ZA3SnreCXYSQw49LMzULd1Nfg7xkgyQYsj+Dd1/xbR5gK+
         K/jdssMJfTjy/Uq/fbqKBvqTp79w3C04SnFW9AUmrc4Q0Scn+5E3UR32ibZoJWp4AJ5D
         GtyAnOLnjtJHQL6M+B1seHzWLAux+l7I3/eDb9KRjlv8txlIZz60sR8Q+JkiFLnmGLIS
         Dq0h/GcRTsmpsezqgJRouVkDEXWrim6tCQUP8ct/cCjDM6BK9XMQiT2+0bPN4WXV+Rou
         X2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fU+i2YSI8fyYGQUvhP1t94ljbzIuDi8ou6kd9T3QdMk=;
        b=h2BgWuy1XP1XWiyqhijnlWAFWYO3T4tLn/QM41hJnvHuG/sCjbPJr2+L8HG2OiuUB3
         59z82k6jM3ADS0DKGgbvnkbMv1gBBibp5Ykc+x8bSx0hdnnFoYcM1VEs6g0vfnzRg6/g
         oQQ2sDGMz6hN5elGQAQHrCQV8QyDBJI+eKhsB2Pt/iqJ8t4luy9nemS5hCUA9d7mh7IH
         5O7cnuHCt/ihepK46EU2h3rYdHOCene6+RWzwGKyM/9lXHy1n+BwONraK1CN8wbDCzS8
         m1ugpSPaiiyIMU2NEEqrY3JLYMzdEQH7rYFadV0YGkOCC14SP4szlkykESQDEGAQtab5
         IATw==
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
Subject: [PATCH 4.14 40/67] USB: serial: cp210x: add ELDAT Easywave RX09 id
Date: Fri,  6 Apr 2018 15:24:10 +0200
Message-Id: <20180406084346.883555658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003577185601362?=
X-GMAIL-MSGID: =?utf-8?q?1597004352305183715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -158,6 +158,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automation Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Interface */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */

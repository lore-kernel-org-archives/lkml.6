Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpECBln7fBvNaWzJfDGfgZHsnFrEg1v4/J5WMSdXb2W22BfC8fqB/hxzHZqi00Lnmkx+d8k
ARC-Seal: i=1; a=rsa-sha256; t=1525116367; cv=none;
        d=google.com; s=arc-20160816;
        b=Fwg9xdwYbsVqjf1LR9hUtwr8FHR9797X8jEzcqR/67IvFU0xLsXY4M9vy4la8+fbuE
         ggnnpOHBEIzh05s6who7/5KX6HOP7KfXmKndIU4wTtCahPmwYHatkYPY3usENxl3siPk
         cS6TIXT/scmDKTAm1/9+aSTsNqTsBW9ZyNKiqB3ZqCvtiHcxQ6yF/5PrfIST5Ga5VLxR
         lRViaCt3jR9HnYXA2weVWK55zAyxEE/4quLzbU8+OHQfjkHKLMXk3Lf+GplP+8Oku/z9
         Rraw3kclVY4zyjogr7jcYcg79iMHLyJjliAVWER91fi0PdSFpsRExPI1RZKo2mdFLXxn
         P8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=U684LyANKGYpIcUo1fs2d2o8h+gfrWRClYjijKOwkvk=;
        b=cTVhDOBEjWFILFgPBs9FcEbKhy5jhatzm3O7eCU/+hIVeDku9v1sEhBAt8QxAfNNaa
         jyGlNftCCpuJpkfyfz2IFgJaUFsjBdg3O75RrufW/7UhBCZTcYsy0gKKsa2DULuX6B1o
         pHOaT7h6T/jZqZKg3svqg6j9U4hF8cMHesWrG0xkuYosm12j3cPgLmRv3pGti/ClqJ30
         dO/nDxdwy564AinDBnzyOfXeBpqK/TdF6K3UmxaRIU/NOVPApLTRMywnfXJGgFQZciA1
         PzwKfBGkA86Lqp/TTUdGal0U0Q9QyEX+lRFc7waEvM8cRa+N4Hw0RYCROlT4pOASY7UR
         F9sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF4C22DC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Romain Izard <romain.izard.pro@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 4.4 43/44] serial: mctrl_gpio: Add missing module license
Date: Mon, 30 Apr 2018 12:24:54 -0700
Message-Id: <20180430190948.046565745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200420468321322?=
X-GMAIL-MSGID: =?utf-8?q?1599200420468321322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Izard <romain.izard.pro@gmail.com>

commit 82a3f87f6e80e0bf7978152021eb8938976721cb upstream.

As the mctrl_gpio driver can be built as a module, it needs to have its
license specified with MODULE_LICENSE. Otherwise, it cannot access
required symbols exported through EXPORT_SYMBOL_GPL.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Wagner <wagi@monom.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_mctrl_gpio.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -20,6 +20,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/termios.h>
 #include <linux/serial_core.h>
+#include <linux/module.h>
 
 #include "serial_mctrl_gpio.h"
 
@@ -249,3 +250,5 @@ void mctrl_gpio_disable_ms(struct mctrl_
 	}
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
+
+MODULE_LICENSE("GPL");

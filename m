Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242ZvA+l+czhI0byJiMKWFk0p9iQOlW2/ptQ0yvuhStQEbctTyx8ZUBmxG8mOdhqYGOSMDX
ARC-Seal: i=1; a=rsa-sha256; t=1519218293; cv=none;
        d=google.com; s=arc-20160816;
        b=nZ0Df7uxSSxUbAo+8oDhj8jEsG3bia2s2EF76h7AXe+RYZ56Ah0aq3Z9bfJjb5pDL2
         t2m5bVU+T3JYu35H78NBcbOGubOHWFTTWa3fK1D1xhGjAjhF3sKM2iy1V1HnkL/zbLy/
         cWraaobFTjizqB6oA7HYuwxr7q81WNdet22ogwz+VUhlPEL+GUmhjj2CKVyuCeasTxeV
         6ZbbfazijK8Subxdf0h3vQgG/UITgoVuEzg8azxbNzIkxfqqNxmHODYsv+mH0QCsnpHn
         8woMcabBa7sYV1xVQB4QnmvzobZ8yVRHmvPNMm5HUiHOY8KzSzGVhEwSRLgXSNHyWXsJ
         +g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6lwOPgsBjJXDnxqrPnxHevSsvjxCj54XwOHL6nPUOTY=;
        b=rVGucUZaeo+x3DIhVLXQQSsvbFqFSE5vigb4K1OapLNlNEgjUXoiLlcGeCkWZc8Mcu
         5/ajJ+mYIS55lkYO3fnEjEOtcqnnQjyxKaBaluULTdybnAGsNPtLAaASiQD8s7UZmOrO
         VfOkq9r/IcV9NxEnTyoIUm5nDDILaE2WBXoinFk+UjvTHWEe/aL9EBsDpiDREfTgzge1
         7Q952wGXpH09Mx4aMsRi16jEcoSjG8xyizmj66DvqOAf2zMXmMS7CKrpHVxK6ONbTLQP
         oB/SKg4m1WxaKKg9gmzioxwRIW4gt0cUF2BkAjrUHp5JlGdEmR5xcZanAPScwGnGOsiF
         /7QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 156/167] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
Date: Wed, 21 Feb 2018 13:49:27 +0100
Message-Id: <20180221124533.390086212@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014694992294145?=
X-GMAIL-MSGID: =?utf-8?q?1593015840542902447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3343647813fdf0f2409fbf5816ee3e0622168079 upstream.

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

For completeness, I'm also adding author and description fields.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-pxa/tosa-bt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,3 +132,7 @@ static struct platform_driver tosa_bt_dr
 	},
 };
 module_platform_driver(tosa_bt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dmitry Baryshkov");
+MODULE_DESCRIPTION("Bluetooth built-in chip control");

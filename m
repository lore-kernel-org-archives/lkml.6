Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rvtNJ2NOG2Wb85rq7OVqZilNkcaJnXqFt9qY5LuUXZP54sQ2K1gfiC2q/CCjAwCPSYIE9
ARC-Seal: i=1; a=rsa-sha256; t=1519217831; cv=none;
        d=google.com; s=arc-20160816;
        b=X5sr37wRzeCtzpEgv7GJVLdI+utCXLEHSb9hNa801py2OUFWZwicSy4uyQeOLo0N7Y
         htRwcZ/HdnYB1u/f9lcSOyvWK3PaKPIn5kxyXgT/QIVQkfA+bv1EpHHmooEfi2kCMZXS
         8OkD6441vTnwDek5IFP1PQw1vF8zloLOLsUE+MOecarZlKiv9e1/f7IrF+Fm61heFVW5
         t3z9K/FvJiogwpDP7riT2a6K+eREJm8GH8DZS7ReB4zTqe7yuAdX88JzI0Tu3tibnA0P
         XFeqJkLg3ViuR2CH6tfvrnFWpcTvAV7/YM3gA6ctVY6dYyxBHfMs9SrpanOZlmAP7X/6
         wpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1jqkuUz9OuzchbsyjiTpRFCxX/Y9tA5ewAun51uInYI=;
        b=vj30eJ7H/pJCe8/u8VhvRvdpquTqKlgGANA6scNhdKlko095MVMzRVPvrEVEKAHfPt
         Vp0S9jmbt+G9W1wzgFrr5GFEnZMgP0FapFY0MurASoNBUdYJUh0r6DDUSpdP5xhULc+1
         3mYQ+k+8e+jKNLhto8bnXQk2am1cEX/vkGAUgBDOeYzlNzMVtAr3HAVrOwrxM7bnTFdp
         SGKvRyi4X1rYuse6WEWu4fNBD/w+qgrbq18Zjegk6QcU/d7d0aFwaCKlNbsUiqDI7Ztw
         ILuHY7Zj2fX+UAtOCGKIuBkiRyIET1jxzKZw4IbWCm0ixQcTD63zAjur8lG+9j1n36hO
         tW0Q==
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
Subject: [PATCH 4.9 70/77] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
Date: Wed, 21 Feb 2018 13:49:19 +0100
Message-Id: <20180221124435.149356995@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014694992294145?=
X-GMAIL-MSGID: =?utf-8?q?1593015356369319895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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

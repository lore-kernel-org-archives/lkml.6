Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224N+AypW+hGcYJr8Gj2kxm2JKGW9J05wtAJVFd5dhMG3lZNolSc//S0ROauHQEratQUdaE4
ARC-Seal: i=1; a=rsa-sha256; t=1518184010; cv=none;
        d=google.com; s=arc-20160816;
        b=x9xu6AwXIfIOiLTEhGVj55oCzxI/XIVF1U2G36txQB0ZWb0MDM4EOuI7urjBO40OMl
         F2Lvkhz1tzzsLWH1WgOfnRWNHVHmGqoxkxn33u7e6qdMh/ribYMjN7oi3RLI7N18KErW
         nsNhso682+yjD3gy0u2LRX9StqCflAk8YmJ0syQcTUdkVy1vQrlUNWAItoSW9NNLPz59
         ZIwVflIBLVr5tzko95Iuk4pzUo/8WaSNyv1HoK4PYgRicK1my6pXg1nN9QOoB0t+WHym
         +y70TSMHth1lY2F7ysB0T8en3tsWgE9zdL2Uyq0iOktLVROy4d72Ra319F9EvKEavwaD
         GobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vBNPFTMD9BgEoMbqGFVf6TJCISEvbx17VTxnkYG44Hg=;
        b=zQMcBk4S5wIMEBu21tidlc22TlEF99ixahhdI9VRV7t1OgBhZxgcPrAcpHLVFwP/ml
         ukOSPLf9ZhShhEDINKjRclx5bo5eqPbt63Rvvzkq1TphMivG3QNZoIHWYSTablLq67W9
         WxHMKJOAD07c2Ya2A5YCgEokU8Pd9FcV67xSAFH0ghIcwXiGzCZUmw6VxP96KMnuGKyG
         aSH0sdC9DKO0us4cGLYSyFiz3DFM4QBdaDMsxBPDvfObCXzuUuQ3dMTjt5H5LY0zucHN
         Yild7e/8dCv70soaDY4qrasM0l/q2abDb0esnqq1nT8nO8rGDJU7lFZZnvC3fzM18nE5
         zTBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 22/23] gpio: uniphier: fix mismatch between license text and MODULE_LICENSE
Date: Fri,  9 Feb 2018 14:40:20 +0100
Message-Id: <20180209133939.403116567@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931317533525410?=
X-GMAIL-MSGID: =?utf-8?q?1591931317533525410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 13f9d59cef91a027bb338fc79b564fafa7680cd8 upstream.

The comment block of this file indicates GPL-2.0 "only", while the
MODULE_LICENSE is GPL-2.0 "or later", as include/linux/module.h
describes as follows:

  "GPL"                           [GNU Public License v2 or later]
  "GPL v2"                        [GNU Public License v2]

I am the author of this driver, and my intention is GPL-2.0 "only".

Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-uniphier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -505,4 +505,4 @@ module_platform_driver(uniphier_gpio_dri
 
 MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
 MODULE_DESCRIPTION("UniPhier GPIO driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tsmRLEGnGlsgGAAAmS7hNA
	; Fri, 08 Jun 2018 15:57:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B7AD7607DC; Fri,  8 Jun 2018 15:57:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AoF3chY3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 034CA601B4;
	Fri,  8 Jun 2018 15:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 034CA601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeFHP5J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:57:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54411 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeFHP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:57:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180608155704euoutp021e7c81fd58f02c9df1bed14a163eb263~2Onspohen2143521435euoutp02T;
        Fri,  8 Jun 2018 15:57:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180608155704euoutp021e7c81fd58f02c9df1bed14a163eb263~2Onspohen2143521435euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528473424;
        bh=gcTGhf1sEBt9bdJngOePyb2RwMAXjs91lMXDusYqv0c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AoF3chY3+0p2yqFX8Gl4QcCQnrhWwjSWzUPOJb+9bGPJQiputCA3iuUidFF6AtPvg
         TpfUqTbrEsGgXIRWYVC2La9Rffz89xtqm9FC0WhZUR5p232W1dG6DCjueHzGn3a5vv
         GKT7lJ3YEFqq04wGESHErn6D/SWGFOo804hMHjsA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180608155703eucas1p1a44508eeef5e73c0271ed521f34d7dfd~2OnrrJnTy2757627576eucas1p1p;
        Fri,  8 Jun 2018 15:57:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.56.17380.E47AA1B5; Fri,  8
        Jun 2018 16:57:02 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180608155701eucas1p1ecfd4b722d96b63681336d509d73c38f~2OnqU0JEE3012330123eucas1p1u;
        Fri,  8 Jun 2018 15:57:01 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-d6-5b1aa74e1886
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.36.04183.D47AA1B5; Fri,  8
        Jun 2018 16:57:01 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PA000LVSHN1SA00@eusync1.samsung.com>; Fri, 08 Jun
        2018 16:57:01 +0100 (BST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Imre Deak <imre.deak@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video/omap: add module license tags
Date: Fri, 08 Jun 2018 17:57 +0200
Message-id: <7804713.l6SSBF4zTq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180528154704.2568184-1-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOV2/5VLRBm/Xalr8nXSM3eLK1/ds
        FpcvnWKyOH9+A7vFib4PrBaXd81hs5i9pJ/FYv38W2wWK0/MYnbg9Pj9axKjx+I9L5k8Nq3q
        ZPO4332cyePkqScsHsdvbGfy+LxJLoA9issmJTUnsyy1SN8ugSuj+9dnpoIZqhWXVgg1MF5R
        6GLk5JAQMJHYueI2axcjF4eQwApGiYOPljJCOJ8ZJb4tu8oEU/V2x2s2EFtIYBmjxIItvhBF
        vxklGjcfZQdJsAlYSUxsX8UIYosIKEpMffGMGaSIWWASk8TNC8/AJgkLWEgsW9PNDGKzCChJ
        fPjUDDaVV0BT4uW/IywgtqiAl8SWfe1g9ZwCphI32z+wQ9QISvyYfA+shllAXmLf/qmsELaO
        xNlj68DOlhC4zibReuIlK8TZLhKnlj9ngbCFJV4d38IOYctIXJ7czQLRMJ1R4s2vpVDOekaJ
        NWeOQT1tLXH4+EWoFXwSk7ZNBzqbAyjOK9HRJgRR4iHxZ8tCFkhYdDBKNDydwDSBUWYWkmtn
        Ibl2FpJrFzAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMHaf/Hf+yg3HXn6RDjAIc
        jEo8vA1NUtFCrIllxZW5hxglOJiVRHifKQGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJ
        CaQnlqRmp6YWpBbBZJk4OKUaGBt0maz2LVjmayZ58Myug9xnXVlCD6xz+pSbIvpKdXfAumu3
        XxqVZ+537Uov3a9SeipswXuRw57pn1l3JLUqafR8uK0T9ODk4hUnOBb8s5TZyKDxPfzS3tXm
        7ccWqpyTfTaB2WXRg8g8A51kpStfq6cYaFj9vhP65+O12KLoJVM5ds3rC57zabMSS3FGoqEW
        c1FxIgD5K8HEGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xy7q+y6WiDTr38lr8nXSM3eLK1/ds
        FpcvnWKyOH9+A7vFib4PrBaXd81hs5i9pJ/FYv38W2wWK0/MYnbg9Pj9axKjx+I9L5k8Nq3q
        ZPO4332cyePkqScsHsdvbGfy+LxJLoA9issmJTUnsyy1SN8ugSuj+9dnpoIZqhWXVgg1MF5R
        6GLk5JAQMJF4u+M1WxcjF4eQwBJGiRn/ZrCBJIQE/jJKfO01ArHZBKwkJravYgSxRQQUJaa+
        eMYM0sAsMIlJYvPts6wgCWEBC4lla7qZQWwWASWJD5+awQbxCmhKvPx3hAXEFhXwktiyr50J
        xOYUMJW42f6BHWJZF6PExf+qEPWCEj8m3wOrZxaQl9i3fyorhK0lsX7ncaYJjPyzkJTNQlI2
        C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEhv+3Yzy07GLveBR9iFOBgVOLhbWiS
        ihZiTSwrrsw9xCjBwawkwvtMCSjEm5JYWZValB9fVJqTWnyIUZqDRUmc97xBZZSQQHpiSWp2
        ampBahFMlomDU6qBkf27il/RI5NL1e/+CMcV7hO1tnuZ/tukgdG2+9xZU6/ru9sy/D/PWMld
        vFNYL+slT2ZRltSPizu69ZUb1y19douhopgr4tLRxrVpn/987PJd9Eb3wdWPbYbXPvf9Ob/0
        +rYHLG4WlvOU7A6tvTwpxM+yZ8W5uvVsc1c8mszcFv7z6OpcrxkRS5RYijMSDbWYi4oTAUYE
        Xsl1AgAA
X-CMS-MailID: 20180608155701eucas1p1ecfd4b722d96b63681336d509d73c38f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528154724epcas4p2a7e53a8a3ee382375f23328f9b8bd823
References: <CGME20180528154724epcas4p2a7e53a8a3ee382375f23328f9b8bd823@epcas4p2.samsung.com>
        <20180528154704.2568184-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 28, 2018 05:46:19 PM Arnd Bergmann wrote:
> I got a bunch of warnings in a randconfig build:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_ams_delta.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_inn1510.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmte.o
> WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmtt.o
> 
> These come from an earlier patch of mine that turned all display drivers
> into separate modules. The fix is to add a MODULE_LICENSE tag. Since I'm
> doing that, adding a description and author field also makes sense. I
> went by the authors listed in the comment at the top of each file, but
> removed Imre's Nokia email address that I assume is not valid any more,
> since Imre is working at Intel these days.
> 
> Fixes: 81c44c2b2ce3 ("video/omap: fix modular build")
> Cc: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.18 (with minor fixups, interdiff below), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


diff -u b/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
--- b/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c	2018-06-08 17:39:29.739986550 +0200
@@ -197,6 +197,7 @@
 };
 
 module_platform_driver(ams_delta_panel_driver);
+
 MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
 MODULE_DESCRIPTION("LCD panel support for the Amstrad E3 (Delta) videophone");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
--- b/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c	2018-06-08 17:39:41.323986842 +0200
@@ -89,6 +89,7 @@
 };
 
 module_platform_driver(h3_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP H3 board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
--- b/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c	2018-06-08 17:40:29.055988044 +0200
@@ -73,6 +73,7 @@
 };
 
 module_platform_driver(innovator1510_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP1510 Innovator board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
--- b/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c	2018-06-08 17:40:40.851988341 +0200
@@ -106,6 +106,7 @@
 };
 
 module_platform_driver(innovator1610_panel_driver);
+
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP1610 Innovator board");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
--- b/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c	2018-06-08 17:40:55.163988701 +0200
@@ -97,3 +97,3 @@
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Imre Deak");
 MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
+MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
--- b/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c	2018-06-08 17:41:13.839989172 +0200
@@ -60,5 +60,5 @@
 
 module_platform_driver(palmte_panel_driver);
-MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>");
+MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>, Laurent Gonzalez <palmte.linux@free.fr>");
 MODULE_DESCRIPTION("LCD panel support for the Palm Tungsten E");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
--- b/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c	2018-06-08 17:42:30.855991111 +0200
@@ -72,6 +72,7 @@
 };
 
 module_platform_driver(palmtt_panel_driver);
+
 MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
 MODULE_DESCRIPTION("LCD panel support for Palm Tungsten|T");
 MODULE_LICENSE("GPL");
diff -u b/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
--- b/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c	2018-06-08 17:43:16.543992262 +0200
@@ -67,5 +67,5 @@
 
 module_platform_driver(palmz71_panel_driver);
-MODULE_AUTHOR("Marek Vasut");
+MODULE_AUTHOR("Romain Goyet, Laurent Gonzalez, Marek Vasut");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LCD panel support for the Palm Zire71");

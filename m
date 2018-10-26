Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F14C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6261520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6261520824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJZOxM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:53:12 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64394 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:53:11 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 10:53:11 EDT
X-AuditID: c0a8fbf4-7efff70000000f67-b9-5bd2adf44ad1
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 3B.20.03943.4FDA2DB5; Fri, 26 Oct 2018 08:02:28 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0415.000; Fri, 26 Oct 2018 08:02:27 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [PATCH] regulator: bd71837: add <linux/of.h> to fix build errors
Thread-Topic: [PATCH] regulator: bd71837: add <linux/of.h> to fix build
 errors
Thread-Index: AQHUbLTkle0EFyn3PUyf6Rib/6G5SqUxB9t7
Date:   Fri, 26 Oct 2018 06:02:26 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4066F1CF4C@WILL-MAIL001.REu.RohmEu.com>
References: <cf89bc2f-f7c0-0ed6-38d8-0c47a05ed706@infradead.org>
In-Reply-To: <cf89bc2f-f7c0-0ed6-38d8-0c47a05ed706@infradead.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVyYMXvjbpf1l6KNrhz1dBi6sMnbBbfrnQw
        WVzeNYfN4u2d6SwOLB47Z91l99i8Qstj06pONo/Pm+QCWKK4bZISS8qCM9Pz9O0SuDOmXb3K
        UvCOo2LOoY/MDYy32bsYOTkkBEwkHn79wdzFyMUhJHCNUaLvzmNGCOcEo0Tz22VMXYwcHGwC
        NhJdN9lB4iICUxklHl34yQzSLSzgK3Hx2SKwSSICARI9104xQ9hGEuteXmUEsVkEVCVO733I
        BGLzCgRJLOl+yQZiCwk4SOw9+gzM5hRwlFi1rYsFxGYUkJXobHgHVs8sIC5x68l8JohLBSSW
        7DnPDGGLSrx8/I8VwlaS2PvzIQtEvY7Egt2f2CBsbYllC18zQ+wVlDg58wnLBEaRWUjGzkLS
        MgtJyywkLQsYWVYxSuQmZuakJ5akGuoVpZbqFeVn5AKp5PzcTYyQ6Pmyg/H/Ic9DjAIcjEo8
        vHcnXYoWYk0sK67MPcQoycGkJMqbmHIxWogvKT+lMiOxOCO+qDQntfgQowQHs5IIb91MoHLe
        lMTKqtSifJiUNAeLkjhv1PlfUUICIJuzU1MLUotgsjIcHEoSvJ/XADUKFqWmp1akZeaUIKSZ
        ODhBhnNJiRSn5qWkFiWWlmTEg9JCfDEwMYCkeID2ngVp5y0uSMwFikK0nmKUlBLndQQmNSEB
        kERGaR7c2FeM4kDfCfNygGR5gOkTrusV0EAmoIEzFC6ADCxJREhJNTC2+3OwrpN4ylX48toR
        hutlMw+rW9nPmvGhRzuY2S3onkOPfvnH2V4aSuVHf0j5Ct9mOD5/e39Q/pewv8+SNu37veOa
        /7xIvp27s68+lnmZx7TLfpdO9rwJthnfIlirriYst1hauCBYwcHg0yZRwY3bPgovE2q0Cy5a
        /KDl6eEbMVNXfvl9eJOGEktxRqKhFnNRcSIA+Ccyl1wDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

From: Randy Dunlap <rdunlap@infradead.org>

> Fix build error due to missing header file:
>
> drivers/regulator/bd71837-regulator.c:242:3: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
>
> Fixes: ba08799e90b5 ("regulator: bd71837: BD71837 PMIC regulator driver")

//snip

> --- lnx-419.orig/drivers/regulator/bd71837-regulator.c
> +++ lnx-419/drivers/regulator/bd71837-regulator.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/rohm-bd718x7.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>

Not sure if this is relevant but if I am not mistaken this should already be fixed by: 
df43519eb706edfe951284a825642ce2e1d38d09 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df43519eb706edfe951284a825642ce2e1d38d09


Br,
    Matti Vaittinen

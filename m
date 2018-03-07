Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeCGLvv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:51:51 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:48543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:51:49 -0500
Date: Wed, 7 Mar 2018 12:51:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: linus.walleij@linaro.org, Matheus Castello <matheus@castello.eng.br>
Cc: eric@anholt.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <2117034393.275403.1520423489002@email.1und1.de>
In-Reply-To: <1520216960-19880-2-git-send-email-matheus@castello.eng.br>
References: <431699005.307231.1520086916739@email.1und1.de>
 <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
 <1520216960-19880-2-git-send-email-matheus@castello.eng.br>
Subject: Re: [PATCH v2 1/3] pinctrl: bcm2835: switch to GENERIC_PINCONF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:c3TuJzWbd3UqZd5tStdjUvkG3Mzn/+RLMyI9U2BijO1EUe1Ilfe
 ihATl5CrMvb4yVjqQy+QtMdeG9TaUDvVIIZ8rMSZm27U039eTD0cteqMj5T6CoJJda4xjrv
 8MBwXjtjDrcd5LS0pXNCqNnT7WF26XOTO62892qpJbeROBDw9sa3570P7Lhh7ZNH08CNRjy
 7QWwO/LI2SyogEIPIXvDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9l+rWgEFNLQ=:+gNOY7ZaRC3LM1Usrb+VhJ
 JrcStLlSrc92PQEhser6Wi9bCORiphTtYWLaF1eCg71i6idsJ0hPikJZjTTeYw9vP0xi6Xzl1
 8rKm/FcQtMlrJdTZeHgrnoFyCbqE0KvA3oLvoloWwdK/Uf52k1jFqXyAVIH6hWJz2TioswYZr
 9qtU916sil0owwWcfbHQjUozpw9Nkq4L87ntR24WskoQuzBN1F4rkr+cDbGMtJSHdF/ACUceF
 RmqTS+x0tEjSDG5fXlXJQ6L8NiSWwGV0RTeTcjUSfi8rXdd9zRBluapvVrnPYJGn4rPOZZ+yt
 aiUofPzYGHxU5sjq7V4NrxMb43iSbxab+6c7OMgUWLYRCWWnJaBxBXk1oAkQ7pwXsoh6YuODV
 ngesG9DHJskWucd/Ywu0bocKAu24gWAVUJEZwzFvemg6DncyOiwkV7LAX6JZ6eXRntA57Qlbs
 abLNvPBaYoJvaPnnmRm6Hqez+vzcE9xoUDWrAudRW8SJ+3kT2iFi1hM0JgRgkgdPWyXyEKc53
 gYN1vSnZLqgYZEyEvraverRsKAdK5o/e/KIRT8l9pIZ0K5Ff/0FYDlSnhmm335wz9DxB6qORd
 WC/DZyNTVPTr9JOlzCrq66D3XWi+44epeQGYoM7POvoQQfV/BP+0/WwsVFo5GAcNY2AnxG6oB
 HaoZxvNTnc/dXI6Y/f12G/FN3CAgGDmb34aSzkWvWwob3KFnX6hXTLGQSLKchmTCThJLsu2eA
 YuLGTGJJOrS2uhFMUYYQQzLCeBuWak2S/Ko8cpazN4m3jeuyw4wxSuKdPWs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

> Matheus Castello <matheus@castello.eng.br> hat am 5. März 2018 um 03:29 geschrieben:
> 
> 
> To enable support for generic binding in the pinctrl-bcm2835 and use pinctrl
> generic to parse properties the GENERIC_PINCONF have to be selected.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/pinctrl/bcm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
> index e8c4e4f..0f38d51 100644
> --- a/drivers/pinctrl/bcm/Kconfig
> +++ b/drivers/pinctrl/bcm/Kconfig
> @@ -20,6 +20,7 @@ config PINCTRL_BCM2835
>  	bool
>  	select PINMUX
>  	select PINCONF
> +	select GENERIC_PINCONF
>  	select GPIOLIB_IRQCHIP
> 
>  config PINCTRL_IPROC_GPIO

i think it's okay to fold this change into patch #2.

> --
> 2.7.4
>

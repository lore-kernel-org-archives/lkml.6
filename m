Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeCQMgg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 08:36:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCQMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 08:36:34 -0400
Date: Sat, 17 Mar 2018 13:35:44 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: robh+dt@kernel.org, fabio.estevam@nxp.com, mark.rutland@arm.com,
        yibin.gong@nxp.com, linux@armlinux.org.uk,
        Anson Huang <Anson.Huang@nxp.com>, lgirdwood@gmail.com,
        shawnguo@kernel.org, kernel@pengutronix.de, broonie@kernel.org
Cc: Linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <1937778373.476574.1521290144753@email.1und1.de>
In-Reply-To: <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:1TSaaqsTu7oTgTo/4NQxFEmVNJn1iGmU/eMNQyDDfvlD5H24IWZ
 NS1kQug6z/AfPzjk/4hR3Nhqkaatomqmp4j/W9Rxe9gg+N7KWmFeHyiY+wtvDnQkGh2maar
 jl47K0Gx70RCUb6bG4xkFemPp/TWyPO8hEBWNQuCafUMxFx2DFeV5raDtTiEaX61MnDsKmY
 QdRVYUgpGqqqlEv/LpVdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7uIxBWnAvYc=:P1rwMn1XqX/PuQsX/BHaqO
 mHCBMNn2ts9kT/cGtkBmbfhQlRG2HlepiTmh8vFKZy5gQQSKryuM8G3oZt23Q7DRfmPWvZEtT
 LtlgpXZ/jvOyzwbsDn2JWFS6/kD+vAAFcY2lYt+kQYpOYtbET41b/QrkXsh2WGD8Jm2ik6pJz
 ZO2FORYDLdsgPzTSa0sZEdGqEHHk3Wf6RglsNeu8PRDrqfnErGxj6k6I+69jXa1iEIM9TvQRI
 9xI7CpI3cImXOj5mXUkEne66+AyDUcnFoR+AjBOY66alMTIby7WoU8RgmagLazFgjdXtM4vsX
 SO1cF/TNIUI3aIMI9/IQhen6p/NwKJumnqJlZZg4VwNLDRhlKmTox3k3h5HL+bB/WZcrCTb5D
 iogMFMK20TVFNGFwAZmaYX2cERwY2oxgwbRknM6OW/W7dfVXY4nOI2hRWmIe79RKEYI7q6OeB
 Pp9l7M2aOGf58gAOQs6QhilAN0aAJpUsXajaIP4wt5XjqsF/f63FITO9tNXmbsYf3kMCLk6P7
 POTflWBOAru6V9/g20abUgcORK2ayD/pfMaCMmTIMp/uLgBzKCto/LQTWBWyab8jWXxFrLjPQ
 9btjeOQAT5LJjZYdvdx56dwNghCdGGDMz2OF6WDOXlHBHr6JBQEB53KGLJ0fhHXV0A5J5Ujta
 1G+5X4THwuvwlR3N0bKqIH0QenGLkxkcZeK+rvX8VYD9jGaB9o9g2y1/6bLjxrtKr1jr3wwXr
 TOZUlPL48CWRgoQuBYHwLi5zqwydO76FETthFnA76H/e2vqP9/wIy4wlgsY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

> Anson Huang <Anson.Huang@nxp.com> hat am 17. März 2018 um 07:57 geschrieben:
> 
> 
> Latest pfuze3000 datasheet from:
> 
> http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1

this link goes to Rev. 7.0, 9/2016, which isn't the latest one.

I guess Rev. 9.0, 8/2017 is the latest.

Regards
Stefan

> 
> updates sw1a's voltage range, the settings for 1.450V and 1.475V
> are replaced with 1.8V and 3.3V:
> 
> 5b'11110 1.450 (SW1B), 1.8 (SW1A/SW1AB)
> 5b'11111 1.475 (SW1B), 3.3 (SW1A/SW1AB)
> 
> the voltage calculation using steps is NOT available for sw1a now,
> use voltage table instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/regulator/pfuze100-regulator.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
> index 63922a2..680f076 100644
> --- a/drivers/regulator/pfuze100-regulator.c
> +++ b/drivers/regulator/pfuze100-regulator.c
> @@ -86,6 +86,13 @@ static const int pfuze100_coin[] = {
>  	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
>  };
>  
> +static const int pfuze3000_sw1a[] = {
> +	700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000,
> +	900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000,
> +	1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000,
> +	1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1800000, 3300000,
> +};
> +
>  static const int pfuze3000_sw2lo[] = {
>  	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000,
>  };
> @@ -343,7 +350,7 @@ static struct pfuze_regulator pfuze200_regulators[] = {
>  };
>  
>  static struct pfuze_regulator pfuze3000_regulators[] = {
> -	PFUZE100_SW_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 700000, 1475000, 25000),
> +	PFUZE100_SWB_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
>  	PFUZE100_SW_REG(PFUZE3000, SW1B, PFUZE100_SW1CVOL, 700000, 1475000, 25000),
>  	PFUZE100_SWB_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
>  	PFUZE3000_SW3_REG(PFUZE3000, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

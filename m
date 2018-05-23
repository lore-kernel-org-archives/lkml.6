Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeEWEah (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:30:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44916 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbeEWEaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:30:35 -0400
X-Google-Smtp-Source: AB8JxZqtOq8WUW24qgPEp++LBVfB67dHPVoGRM2sIzhEt8AVuKQaihSeUTfbOodxkVZNzC+OEpWvKg==
Date: Wed, 23 May 2018 10:00:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski
        <sebastien.szymanski@armadeus.com>
Cc: linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: imx6ull-colibri-wifi: remove operating
 points
Message-ID: <20180523043032.2htohlypynnvpiye@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180522062853.24799-3-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522062853.24799-3-sebastien.szymanski@armadeus.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 08:28, Sébastien Szymanski wrote:
> Operating points are now defined in the imx6ull.dtsi file so remove
> them from board device trees.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> index 3dffbcd50bf6..183193e8580d 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> @@ -20,20 +20,6 @@
>  
>  &cpu0 {
>  	clock-frequency = <792000000>;
> -	operating-points = <
> -		/* kHz	uV */
> -		792000  1225000
> -		528000	1175000
> -		396000	1025000
> -		198000	950000
> -	>;
> -	fsl,soc-operating-points = <
> -		/* KHz	uV */
> -		792000  1175000
> -		528000	1175000
> -		396000	1175000
> -		198000	1175000
> -	>;
>  };
>  
>  &iomuxc {

Maybe you should merge this with the previous patch itself.

-- 
viresh

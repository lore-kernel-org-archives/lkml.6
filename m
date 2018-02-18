Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeBRSDb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 13:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:35895 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbeBRSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 13:03:29 -0500
Subject: Re: [PATCH v1 2/2] ARM: dts: tegra30: Add video decoder node
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1518973069.git.digetx@gmail.com>
 <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <4cf77dcd-0921-dec2-e5cd-ed8b5dc2fb7c@suse.de>
Date: Sun, 18 Feb 2018 19:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.02.2018 um 18:01 schrieb Dmitry Osipenko:
> Add device tree node for the Video Decoder Engine found on Tegra30 SoC's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 1fb0c421a9d8..8ae72ffe0048 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -17,6 +17,11 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0x40000000 0x40000>;
> +
> +		vde_pool: vde {
> +			reg = <0x400 0x3fc00>;

vde@400 then, to avoid dtc warnings.

> +			pool;
> +		};
>  	};
>  
>  	pcie@3000 {

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)

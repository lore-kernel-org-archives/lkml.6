Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeCGOhx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754564AbeCGOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:37:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2C02172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=dinguyen@kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: stratix10: remove 'num-slots' property
 for dwmmc
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, will.deacon@arm.com, xuwei5@hisilicon.com
References: <20180223064138.18401-1-jh80.chung@samsung.com>
 <CGME20180223064140epcas2p3804fe3b7d63e4b7975d94a178e94dffb@epcas2p3.samsung.com>
 <20180223064138.18401-4-jh80.chung@samsung.com>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <94cf9226-27f2-1550-e1c1-2f7dbb873bd1@kernel.org>
Date: Wed, 7 Mar 2018 08:37:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223064138.18401-4-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 12:41 AM, Jaehoon Chung wrote:
> Since 'num-slots' had already deprecated, remove the property in
> device-tree file.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index a37c46112876..4e146b4e6487 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -88,7 +88,6 @@
>  
>  &mmc {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	broken-cd;
>  	bus-width = <4>;
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

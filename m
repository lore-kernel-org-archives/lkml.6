Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933086AbeBMBNH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:13:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44462 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbeBMBNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:13:05 -0500
X-Google-Smtp-Source: AH8x226kf9HibKj2c4+56UqRuf7sKll1+DZlkd+IFR/Es1aO4oVKk5N/xfU888BpOLVPoargFtvT2w==
Date: Mon, 12 Feb 2018 17:13:02 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>, Wei Xu <xuwei5@hisilicon.com>,
        Alex Elder <elder@linaro.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable the APCS IPC driver on Qualcomm
 platforms
Message-ID: <20180213011302.GZ7250@minitux>
References: <6ab84c75aadc152fdd7c63282ee6690096b8b704.1518415510.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab84c75aadc152fdd7c63282ee6690096b8b704.1518415510.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Feb 03:03 PST 2018, Amit Kucheria wrote:

> The APCS block is present on several Qualcomm SoCs e.g. 8916, 8996.  On the
> 8916 it is needed to enable the clock controller that in turn enables
> cpufreq on the platform while on the 8996 it is needed for communication
> with RPM.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..96a8ed8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -525,6 +525,7 @@ CONFIG_ARM_MHU=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
>  CONFIG_HI6220_MBOX=y
> +CONFIG_QCOM_APCS_IPC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_ARM_SMMU=y
>  CONFIG_ARM_SMMU_V3=y
> -- 
> 2.7.4
> 

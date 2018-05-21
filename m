Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeEULg3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:36:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39742 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeEULgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:36:22 -0400
X-Google-Smtp-Source: AB8JxZqad1wMIZW4cp/iPQ4O0WrssPZkmX36l2LRBT6iGboFsr4iiV/y2yQwHQMu0IX7jJhEIrPKQnnwK9EWsDDJRnk=
MIME-Version: 1.0
In-Reply-To: <1525805210-15246-3-git-send-email-lsun@mellanox.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525805210-15246-1-git-send-email-lsun@mellanox.com> <1525805210-15246-3-git-send-email-lsun@mellanox.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 21 May 2018 13:36:21 +0200
Message-ID: <CAPDyKFqBqTjjjFSkRBLKECmdn-b01hv51LOtqSSSTseWYL=Ykw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] arm64: defconfig: Enable dw_mmc-bluefield driver
To: Liming Sun <lsun@mellanox.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2018 at 20:46, Liming Sun <lsun@mellanox.com> wrote:
> This patch updates arm64 defconfig to enable dw_mmc-bluefield,
> which is a driver extension of Synopsys Designware MMC for the
> Mellanox BlueField Soc.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> Reviewed-by: David Woods <dwoods@mellanox.com>

I have applied the other parts in the series, but not this one as it's
probably better it goes via arm soc.

I can take it, but then I need an ack from arm64 folkz...

Kind regards
Uffe

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ecf6137..43464ab 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -487,6 +487,7 @@ CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_MMC_DW_K3=y
>  CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_DW_BLUEFIELD=y
>  CONFIG_MMC_SUNXI=y
>  CONFIG_MMC_BCM2835=y
>  CONFIG_MMC_SDHCI_XENON=y
> --
> 1.8.3.1
>

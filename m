Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeEBIRE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:17:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42966 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeEBIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:16:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180502081658epoutp03f85732e3318306110232dd40af11e3a2~qxeal1FEZ2345923459epoutp03H
X-AuditID: b6c32a38-70fff7000000105c-e7-5ae973f7d641
Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
To: Liming Sun <lsun@mellanox.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <90076dd0-1e6a-3678-5357-98f84a03a46a@samsung.com>
Date: Wed, 2 May 2018 17:16:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525198787-46403-1-git-send-email-lsun@mellanox.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d1t16u1+jXNDkZlFwsyX3dzeXssoqQGSQhFxWStm942abtb
        u1OyoFaY2TIsCiqzMqiYsqgkyyJ76GwVrveLXlCYTe1p5f60zTvJv36fc873yznnx6FkKh+Z
        QpUKLt4pcFaaTJBf6ZiVkxkWew05O90Z7I9zNYg95X+oYJ9drydZ/1AtYhuG+gj27KsnBLu7
        zR/HDjx6TLKB82vY3l/35IsS9L6TPqRvbtpL6t+9vEHqe450EPrfzVMLFQZ+gYXnSnhnKi8U
        20tKBbOOXr7StMSknZPDZDJz2Tw6VeBsvI7OLyjMXFpqjQxFp5Zz1rJIqpATRTp74QKnvczF
        p1rsoktHFzGMOovJyctSqyOvxjhPrY1I1vOWF8EHcY6mtC1B9yByo+dTPCieApwLry/2kR6U
        QKlwK4JrlRcVUjCA4IGvNRYMIvAE78hGLFW7dpFRVuE2BL4WpSTqRxAKXSOihUS8DCo7QkS0
        kIQ/Irjyri3ioCgZtsJdT3JUQ+IMuDoYGNYr8ULY3+KNi7Icp8Glsw3D+Yl4NTS+fRLTTID7
        x7rlUY7Hi+HAma7hvAxPgjfdp2I8Da5+q5dF+wIOk/DrQyOSps6Hyv7nMU6EvsDlOIlToLe2
        KsZ7EASPJ0rmwwi8R/cRUkEDPac9hLTALLhwPTuKgHXg70yX+o6D739rFFJaCdVVKsmYBk/7
        e4mRTu+7hxQS66HJ/xsdQHTdqM3qRm1TN2qbuv99G5C8CSXzDtFm5kXGkZslcjaxTDBnFdtt
        zWj4UtPZVnTjYUE7whSixyqrHSGDSsGVixW2dgSUjE5SNlb3GFTKEq5iK++0m5xlVl5sR9rI
        xx+UpUwstkfuXnCZGK1ao9GwucwcLcPQk5SfC7oMKmzmXPwmnnfwzhEfQcWnuJFFQLdmtn4p
        CmVvbDE+m7/m7c21SvW+RPcLR35gxuTxhzbbZ4c9PzaV/hXM1as6kx1bkzJWeI3lU7tVVtv7
        jOV/Dp7vX/dq4NKOsd4K3bi+P0UXNpyoct3O69pI1+DaN2Fj8KZ/lYkzNsC2zsvy6Z9WBLbv
        2FY072th2GuumTHm009aLlo4Jl3mFLl/6+iTpb8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO734pdRBi1LhS3eL+thtJh/5Byr
        xeVdc9gsjvzvZ7RY8P8Vk8XS6xeZLFr3HmG3+HT+ApvF8bXhFi8/nmBx4PJYM28No8emVZ1s
        Hneu7WHzeDb9MJPH501yAaxRXDYpqTmZZalF+nYJXBlXz55iL1ilUnG24RtjA+MV2S5GTg4J
        AROJtqYmti5GLg4hgd2MEjN37WCCSEhJfH46FSjBAWQLSxw+XAwSFhJ4ySjx+4MIiC0s4C7R
        cvgFE0iviMBDRom1Oz4zgySYBXIkGp/uZIUY+phRYu6tqywgCTYBHYnt346DLeAVsJPo3bqC
        HcRmEVCR2Lh0AVhcVCBM4urZOWwQNYISJ2c+AevlFHCSmLDkDBPEAnWJP/MuQS0Tl7j1ZD5U
        XF5i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P
        3cQIjiktrR2MJ07EH2IU4GBU4uHtKHgRJcSaWFZcmXuIUYKDWUmEd2XHsygh3pTEyqrUovz4
        otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjPXSj1Pqdsjv0Wk6Gpj1w/LD
        dJWriZPfbrdi7wlUXhxc9vWJfOXeg9MN5/x8y3ts7bxVtgHJW04wNzZluIUrfLZLm/LG/5m/
        TO29z99+MXLrt39wSPrydSHzm9LMd+t2V56+yrHNrrZ22bTXm2uii9s0dyt1CHhe9/AXtr9r
        Jd2y6Aa7pvrXICWW4oxEQy3mouJEAElY4sWlAgAA
X-CMS-MailID: 20180502081655epcas1p2dc383996f815eece9f8b63f7f3c12e78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180502081655epcas1p2dc383996f815eece9f8b63f7f3c12e78
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180501182919epcas2p368101c944e8e4bcdb19a1863fc8d469d
X-RootMTR: 20180501182919epcas2p368101c944e8e4bcdb19a1863fc8d469d
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
        <CGME20180501182919epcas2p368101c944e8e4bcdb19a1863fc8d469d@epcas2p3.samsung.com>
        <1525198787-46403-1-git-send-email-lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/02/2018 03:19 AM, Liming Sun wrote:
> This commit adds extension to the dw_mmc driver for Mellanox BlueField
> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> this SoC.

Could you heck Shawn's comments? And add the minor comment.

> 
> Cc: stable@kernel.org
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> ---
>  drivers/mmc/host/Kconfig            |  9 +++++
>  drivers/mmc/host/Makefile           |  1 +
>  drivers/mmc/host/dw_mmc-bluefield.c | 72 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9589f9c..26ac6b5 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -717,6 +717,15 @@ config MMC_DW_K3
>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
>  	  for platforms based on Hisilicon K3 SoC's.
>  
> +config MMC_DW_BLUEFIELD
> +	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
> +	depends on MMC_DW
> +	select MMC_DW_PLTFM
> +	help
> +	  This selects support for Mellanox BlueField SoC specific extensions to
> +	  the Synopsys DesignWare Memory Card Interface driver. Select this
> +	  option for platforms based on Mellanox BlueField SoC's.
> +
>  config MMC_DW_PCI
>  	tristate "Synopsys Designware MCI support on PCI bus"
>  	depends on MMC_DW && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6aead24..267b3f1 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
>  obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
> +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> new file mode 100644
> index 0000000..12067b1
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Mellanox Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/of.h>
> +
> +#include "dw_mmc.h"
> +#include "dw_mmc-pltfm.h"
> +
> +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	u32 regs;
> +
> +	/* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT. */
> +	regs = mci_readl(host, UHS_REG_EXT);
> +	regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);

I want to use the macro. Not (4 << 23)..

> +	mci_writel(host, UHS_REG_EXT, regs);
> +}
> +
> +static const struct dw_mci_drv_data bluefield_drv_data = {
> +	.set_ios		= dw_mci_bluefield_set_ios
> +};
> +
> +static const struct of_device_id dw_mci_bluefield_match[] = {
> +	{ .compatible = "mellanox,bluefield-dw-mshc",
> +		.data = &bluefield_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> +
> +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> +{
> +	const struct dw_mci_drv_data *drv_data = NULL;
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match = of_match_node(dw_mci_bluefield_match,
> +				      pdev->dev.of_node);
> +		drv_data = match->data;
> +	}
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> +	.probe		= dw_mci_bluefield_probe,
> +	.remove		= dw_mci_pltfm_remove,
> +	.driver		= {
> +		.name		= "dwmmc_bluefield",
> +		.of_match_table	= dw_mci_bluefield_match,
> +		.pm		= &dw_mci_pltfm_pmops,
> +	},
> +};
> +
> +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> +
> +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL v2");
> 

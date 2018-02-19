Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeBSJeg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:34:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:60997 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbeBSJee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:34:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="29074276"
Subject: Re: [PATCH v2 15/16] mmc: sdhci-omap: Add SPDX identifier
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-16-kishon@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2011736b-9c4c-41e2-2dd7-a3ec86d3b180@intel.com>
Date: Mon, 19 Feb 2018 11:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205125029.21570-16-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
> The SPDX identifier is a legally binding shorthand, which can be used
> instead of the full boiler plate text. Update sdhci-omap driver with the
> correct SPDX license identifier.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 863f6736c2fe..d44918172197 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1,21 +1,7 @@
> -/**
> - * SDHCI Controller driver for TI's OMAP SoCs
> - *
> - * Copyright (C) 2017 Texas Instruments
> - * Author: Kishon Vijay Abraham I <kishon@ti.com>
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 of
> - * the License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Texas Instruments
> +// SDHCI Controller driver for TI's OMAP SoCs
> +// Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  #include <linux/delay.h>
>  #include <linux/mmc/slot-gpio.h>
> 

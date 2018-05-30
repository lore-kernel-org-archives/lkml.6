Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeE3VSL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:18:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeE3VSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:18:09 -0400
Subject: Re: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc: rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
 <1527713725-1086-11-git-send-email-jollys@xilinx.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
Date: Wed, 30 May 2018 14:17:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527713725-1086-11-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 01:55 PM, Jolly Shah wrote:
> From: Jolly Shah <jolly.shah@xilinx.com>


> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> new file mode 100644
> index 0000000..fe815f7
> --- /dev/null
> +++ b/drivers/clk/zynqmp/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COMMON_CLK_ZYNQMP
> +	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
> +	depends on OF
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on ZYNQMP_FIRMWARE
> +	help
> +	  Support for the Zynqmp Ultrascale clock controller.
> +	  It has a dependency on the PMU firmware.
> +	  Say Y if you want to support clock support

	  Say Y if you want to include clock support.


-- 
~Randy

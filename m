Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034414AbeCBQkl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:40:41 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44393 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbeCBQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:40:38 -0500
X-Google-Smtp-Source: AG47ELsy+17atk7J8IRxIZ2ESC7A0AI2o+6yN/cT/a4j/h1PTpMQUmNPapuhtcHzc4T++Bl91+JpAg==
Date: Fri, 2 Mar 2018 10:40:37 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
Message-ID: <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:40:24PM +0100, Michal Simek wrote:
> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
> port and usbs.
> Board is using fixed clocks because clock driver hasn't been merged yet.

Please get rid of the separate clocks dts file when it is merged.

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Use i2c-mux instead of i2cswitch
> - Remove i2c mw u-boot commands
> - Use 96boards labels for i2cs and spis
> - Fix pmic and wifi node
> - Record compatible string to xilinx.txt
> - Remove Nathalie's email (she left Xilinx already)
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   6 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        | 213 ++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 292 ++++++++++++++++++++++
>  4 files changed, 512 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts

Reviewed-by: Rob Herring <robh@kernel.org> 

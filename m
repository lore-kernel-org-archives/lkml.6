Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbeCGUeR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:34:17 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44313 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbeCGUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:34:13 -0500
X-Google-Smtp-Source: AG47ELu3L11ztGrRiefPBCLEhw7lI7WkS5zUoKuclK1ofNu5BbNjKZN+pe9bEzeA6WHu1MBGlOvuAw==
Date: Wed, 7 Mar 2018 14:34:11 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] arm: zynq: Add support for Xilinx zc770 xm010 dc1
 board
Message-ID: <20180307203411.63wvldylpwt6o54o@rob-hp-laptop>
References: <cover.1520018484.git.michal.simek@xilinx.com>
 <44eba6a11ccc653a07b8c44640cecb78e711a2be.1520018484.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44eba6a11ccc653a07b8c44640cecb78e711a2be.1520018484.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 08:21:34PM +0100, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains ethernet port, can, i2c, sd, qspi, spi, uart and usb.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Fix partition for flash
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  3 +
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm010.dts           | 95 ++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts

Reviewed-by: Rob Herring <robh@kernel.org>

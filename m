Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947491AbeCBSvs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:51:48 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34859 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422764AbeCBSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:51:46 -0500
X-Google-Smtp-Source: AG47ELsnHXITkQ7jaI8EMd878OWXglF9jVSUlRJKgOknpxHibLIeDenWx3tqF5cJHR173JMmJBwPBg==
Date: Fri, 2 Mar 2018 12:51:45 -0600
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
Subject: Re: [PATCH v2 4/5] arm: zynq: Add support for Xilinx zc770 xm012 dc3
 board
Message-ID: <20180302185144.zslujqf53umsyryb@rob-hp-laptop>
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <05bf43a5ecf7d31af17d6e3d9b89ae75f112c9f5.1519398009.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bf43a5ecf7d31af17d6e3d9b89ae75f112c9f5.1519398009.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:00:22PM +0100, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains can, 2x i2c, nor flash, spi and uart.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm012.dts           | 64 ++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts

Reviewed-by: Rob Herring <robh@kernel.org>

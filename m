Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947588AbeCBSxZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:53:25 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38346 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947573AbeCBSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:53:22 -0500
X-Google-Smtp-Source: AG47ELsZtNIAvVDqHWLvXAtYZJnXCpXy88/aA6d31vWzsjHHOhYszJliOR+Ix22gkgd7RIWE1MyNrA==
Date: Fri, 2 Mar 2018 12:53:20 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5]  arm: zynq: Add support for Xilinx zc770 xm013
 dc4 board
Message-ID: <20180302185320.bc2qcqkfs5c2oatw@rob-hp-laptop>
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <7e29c4841930c4e4189a167934574fcf987b9f02.1519398009.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e29c4841930c4e4189a167934574fcf987b9f02.1519398009.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:00:23PM +0100, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains can, ethernet, i2c, qspi, spi and uart.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - use eeprom as node name instead of at25
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm013.dts           | 78 ++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426624AbeCBSHD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:07:03 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37185 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423832AbeCBSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:06:59 -0500
X-Google-Smtp-Source: AG47ELs7dK1kMGD53+/MBcqmzkbQ7Jknws8IpIpDaKanKKgcQE4fDV3wPzlh6IOhXXOiFcZrNVhwvQ==
Date: Fri, 2 Mar 2018 12:06:58 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] arm64: zynqmp: Add support for Xilinx zc12XX
 boards
Message-ID: <20180302180658.26qjuqeiucvam4yk@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <10883c083dfe48fe5349292f78e47143d87c0a15.1519396753.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10883c083dfe48fe5349292f78e47143d87c0a15.1519396753.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:40:29PM +0100, Michal Simek wrote:
> These 3 boards requires minimal support to get Linux up and running.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |  9 ++++
>  arch/arm64/boot/dts/xilinx/Makefile               |  3 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 54 +++++++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 42 ++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts | 42 ++++++++++++++++++
>  5 files changed, 150 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts

Reviewed-by: Rob Herring <robh@kernel.org>

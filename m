Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964834AbeCGUdF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:33:05 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44198 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbeCGUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:33:03 -0500
X-Google-Smtp-Source: AG47ELs4VN2EzreNture+Zkp35BEr8ZK08yBM55UUw4cMh8jOWn4Tr/KRoX7mXBE0K6WFlMazOhv4Q==
Date: Wed, 7 Mar 2018 14:33:01 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/8] arm64: zynqmp: Add support for Xilinx zc1751
Message-ID: <20180307203301.kufwtfsnxtks2gps@rob-hp-laptop>
References: <cover.1520017397.git.michal.simek@xilinx.com>
 <9f84bb43ee3e57b1635250a59e7b588831374649.1520017397.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f84bb43ee3e57b1635250a59e7b588831374649.1520017397.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 08:04:34PM +0100, Michal Simek wrote:
> Xilinx zc1751 boards is used for silicon validation. Board can be
> extended with 5 FMCs/DCs cards to connect various IPs. Describe all
> these combinations.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Remove aliases for can, usb, gpio
> - dc2 fix spi_flashes and partitions
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt   |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile                |   5 +
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 131 +++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 168 +++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 150 +++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 178 +++++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 125 +++++++++++++++
>  7 files changed, 760 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts

Reviewed-by: Rob Herring <robh@kernel.org>

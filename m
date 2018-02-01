Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeBAXO3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:14:29 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45404 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAXOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:14:23 -0500
X-Google-Smtp-Source: AH8x22738EZc1CAt1VJOpkkIFNe7pCnyzvEmVzP1wTk91KSBd+8jSKE3YnLKSudo+MRRrEJWFODemTccrAEetkxLDRc=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 00:14:22 +0100
X-Google-Sender-Auth: DuwPz9RPDFcrrm768wq4KTXNn3M
Message-ID: <CAK8P3a0vdWvPq-r9dRi2tJJ+Us=uZJ-hXZvNx8GuKPYnf8YT1w@mail.gmail.com>
Subject: [GIT PULL 0/3] ARM: SoC branches
To: Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm-soc tree for this merge window contains the usual stuff,
and is probably slightly smaller than usual. Only one new SoC
gets added this time, and it's a minor variation of an existing one.

A clear majority of the changes keep getting done for 32-bit SoCs.
This appears to be the result of some 32-bit SoC families being
particularly popular: omap, at91, aspeed and imx so far are only
available with 32-bit cores, though the 64-bit i.MX8 has finally
seen the light of day and will likely get added in the next merge
window. The other popular platforms (renesas, marvell, samsung,
amlogic, allwinner, and others) tend to have both 32-bit and 64-bit
implementations with a comparable amount of patches going into
either side.

Overall, we pulled 89 branches containing 864 non-merge
changesets. 994 files were touched in some form, with 32303 lines
added and 11679 removed, the latter mostly due to some device tree
files getting reorganized, but also from continued cleanup of the
platform code leading to a net code reduction in the soc branch.

dt: 49 pulls, 692 patches, 577 files, 23197 insertions, 7952 deletions
soc: 22 pull, 84 patches, 320 files, 2058 insertions, 3055 deletions
drivers: 18 pulls, 88 patches, 98 files, 7095 insertions, 737 deletions

The top contributors by number of patches are:

     55 Tero Kristo
     45 Alexandre Belloni
     43 Fabio Estevam
     41 Simon Horman
     32 Russell King
     30 Magnus Damm
     28 Biju Das
     27 Fabrizio Castro
     22 Thierry Reding
     21 Geert Uytterhoeven
     21 Arnd Bergmann
     17 Joel Stanley
     16 Krzysztof Kozlowski
     15 Marek Szyprowski
     14 Tony Lindgren
     13 Dave Gerlach
     12 Volodymyr Babchuk
     11 Lucas Stach
     10 Stefan Agner
     10 Neil Armstrong
     10 Linus Walleij

This is the dirstat of all changes. As usual, device tree files
dominate the contents. The drivers/clk/ti/ is from a branch that
is shared with the clk maintainer and should already be merged
at this point:

   0.9% Documentation/devicetree/bindings/
  42.4% arch/arm/boot/dts/
   0.4% arch/arm/mach-ep93xx/
   0.4% arch/arm/mach-exynos/
   2.3% arch/arm/mach-omap2/
   0.4% arch/arm/mach-pxa/
   4.2% arch/arm/mach-s3c24xx/
   1.7% arch/arm/mach-s3c64xx/
   0.6% arch/arm/plat-samsung/include/plat/
   0.7% arch/arm/plat-samsung/
   1.4% arch/arm/
   0.4% arch/arm64/boot/dts/allwinner/
   1.0% arch/arm64/boot/dts/amlogic/
   0.6% arch/arm64/boot/dts/exynos/
   3.8% arch/arm64/boot/dts/marvell/
   0.6% arch/arm64/boot/dts/mediatek/
   1.0% arch/arm64/boot/dts/nvidia/
   0.4% arch/arm64/boot/dts/qcom/
   2.9% arch/arm64/boot/dts/renesas/
   1.4% arch/arm64/boot/dts/
   1.0% drivers/bus/
  10.7% drivers/clk/ti/
   1.0% drivers/memory/tegra/
   2.0% drivers/memory/
   0.4% drivers/soc/bcm/brcmstb/
   3.8% drivers/soc/qcom/
   1.1% drivers/soc/tegra/
   1.5% drivers/soc/xilinx/
   1.0% drivers/soc/
   2.4% drivers/tee/optee/
   1.0% drivers/tee/
   2.5% include/dt-bindings/clock/
   0.7% include/dt-bindings/
   0.6% include/linux/soc/qcom/
   0.9% include/linux/

       Arnd

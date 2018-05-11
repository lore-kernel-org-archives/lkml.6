Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeEKQkX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:40:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42085 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:40:20 -0400
X-Google-Smtp-Source: AB8JxZoUToE+UGZH5oMFGqMNLz+e/lZPRDJLE3rHkdzkiLTTP51V2DCiJGn1nNAd2Fhq8dF9CCV5HA==
Subject: Re: [PATCH v2 00/12] refactor dts and add support for more boards
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1523434757.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <df482bb2-df7c-3e65-fc0a-f20c81c2dac3@gmail.com>
Date: Fri, 11 May 2018 18:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2018 10:53 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v1:
> - Dropped several patches which have been merged.
> - Rebased to linux-next-20180410 where those dependent patches including
>   [1] and [2] all have been got merged.
> - Revised according to suggestions and comments on v1, where the major work is
>   to put board-specific nodes into DTS files and to leave the common nodes
>   among boards in DTSI files as done in patch 7,9,10,11 and 12.
> - Merged Ryder Lee's patch for update audio nodes reflecting the latest
>   bindings.
> - Revised commit message.
> 
> The series is to refactor current .dts for allowing more boards can properly
> join and reuse almost the same device node definitions.
> 
> Before we're doing that, some works about enhancements and fixups are being
> made on the dt-binding document and .dts files. In addition, the series has to
> depend on the patch [1][2]. Otherwise, certain build failure would have an
> occurrence.
> 
> [1] arm: dts: mt7623: add PCIe related nodes
> http://lists.infradead.org/pipermail/linux-mediatek/2018-February/012053.html
> 
> [2] dt-bindings: soc: add header files required for MT7623A SCPSYS dt-binding
> http://lists.infradead.org/pipermail/linux-mediatek/2018-February/011930.html
> 
> Ryder Lee (1):
>   arm: dts: mediatek: modify audio related nodes for both MT2701 and
>     MT7623
> 
> Sean Wang (11):
>   dt-bindings: cpufreq: mediatek: use - instead of _ in examples
>   arm: dts: mediatek: converted to using SPDX identifiers
>   arm: dts: mt7623: fix invalid memory node being generated
>   arm: dts: mt7623: fix available memory size on bananapi-r2
>   arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
>   arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
>   arm: dts: mt6323: move node mt6323 leds to mt6323.dtsi
>   arm: dts: mt7623: extend common file reused by all boards with MT7623
>     SoCs
>   arm: dts: mt7623: add MT7623A SoC level DTS
>   arm: dts: mt7623: add MT7623A reference boards
>   arm: dts: mt7623: add MT7623N reference board with eMMC
> 

I merged all but 1/12 which needs to go through rafaels tree and 8/12 which was
already applied from a different series.

You can find them in v4.17-next/soc on git.kernel.org

Regards,
Matthias


>  .../bindings/cpufreq/cpufreq-mediatek.txt          |   6 +-
>  arch/arm/boot/dts/Makefile                         |   3 +
>  arch/arm/boot/dts/mt2701-evb.dts                   |   9 +-
>  arch/arm/boot/dts/mt2701.dtsi                      | 197 ++++----
>  arch/arm/boot/dts/mt6323.dtsi                      |  17 +-
>  arch/arm/boot/dts/mt6580-evbp1.dts                 |   9 +-
>  arch/arm/boot/dts/mt6580.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt6589-aquaris5.dts              |  10 +-
>  arch/arm/boot/dts/mt6589.dtsi                      |  12 +-
>  arch/arm/boot/dts/mt6592-evb.dts                   |   9 +-
>  arch/arm/boot/dts/mt6592.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt7623.dtsi                      | 537 ++++++++++++++++-----
>  arch/arm/boot/dts/mt7623a-rfb-emmc.dts             | 291 +++++++++++
>  arch/arm/boot/dts/mt7623a-rfb-nand.dts             | 337 +++++++++++++
>  arch/arm/boot/dts/mt7623a.dtsi                     |  44 ++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 279 ++---------
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts             | 326 +++++++++++++
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts             |  40 +-
>  arch/arm/boot/dts/mt7623n-rfb.dtsi                 |  12 +-
>  arch/arm/boot/dts/mt8127-moose.dts                 |   9 +-
>  arch/arm/boot/dts/mt8127.dtsi                      |   9 +-
>  arch/arm/boot/dts/mt8135-evbp1.dts                 |   9 +-
>  arch/arm/boot/dts/mt8135.dtsi                      |   9 +-
>  23 files changed, 1576 insertions(+), 616 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
>  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
>  create mode 100644 arch/arm/boot/dts/mt7623a.dtsi
>  create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeBVLjv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:39:51 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37358 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932065AbeBVLjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:39:48 -0500
X-Google-Smtp-Source: AH8x227etkjsSnthVWy9dzqt+mU/y8xiVIxR68eIKAB/nUuFKm4kQDOppJW4A6P9beTAoYC3pQrpP4YgqbCAOqUvNT8=
MIME-Version: 1.0
In-Reply-To: <20180221171504.dac7yikrqfnjiiog@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com> <20180221171504.dac7yikrqfnjiiog@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 12:39:46 +0100
X-Google-Sender-Auth: F2SGiiFkvgXGkHaCMZrFQhnRP0M
Message-ID: <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:15 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 20, 2018 at 04:46:23PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> > Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>> >
>> > Based on original work from:
>> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> > Magnus Damm <damm+renesas@opensource.se>
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, applied with prefix updated to
>
> "arm64: dts: renesas:"
>
> There was some fuzz applying this patch, the result is as follows.
>
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Subject: [PATCH] arm64: dts: renesas: Add R-Car Salvator-x M3-N support
>
> Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>
> Based on original work from:
> Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Magnus Damm <damm+renesas@opensource.se>
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Something went wrong with this patch, I suspect it's missing some prerequisites
that fill in a few more device nodes to avoid these warnings in linux-next:

arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/ethernet@e6800000/ethernet-phy@0
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e6510000/codec@10 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e6510000/clk_multiplier@4f
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e66d8000/gpio@20 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e66d8000/adc@7c has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e66d8000/adc@7f has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e66d8000/clock-generator@6a
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/i2c@e60b0000/pmic@30 has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display@feb00000/ports/port@0 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display@feb00000/ports/port@1 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(reg_format): "reg" property in /soc/display@feb00000/ports/port@2 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/ethernet@e6800000/ethernet-phy@0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/ethernet@e6800000/ethernet-phy@0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e6510000/codec@10
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e6510000/codec@10
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e6510000/clk_multiplier@4f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e6510000/clk_multiplier@4f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e66d8000/gpio@20
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e66d8000/gpio@20
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e66d8000/adc@7c
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e66d8000/adc@7c
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e66d8000/adc@7f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e66d8000/adc@7f
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e66d8000/clock-generator@6a
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e66d8000/clock-generator@6a
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/i2c@e60b0000/pmic@30
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/i2c@e60b0000/pmic@30
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display@feb00000/ports/port@0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display@feb00000/ports/port@0
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display@feb00000/ports/port@1
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display@feb00000/ports/port@1
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/soc/display@feb00000/ports/port@2
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(avoid_default_addr_size): Relying on default #size-cells value for
/soc/display@feb00000/ports/port@2
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(phys_property): Missing property '#phy-cells' in node
/soc/usb-phy@e65ee000 or bad phandle (referred from
/soc/usb@ee020000:phys[0])
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(pwms_property): Missing property '#pwm-cells' in node
/soc/pwm@e6e31000 or bad phandle (referred from /backlight:pwms[0])
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(interrupts_property): Missing interrupt-controller or interrupt-map
property in /soc/interrupt-controller@e61c0000
arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
(interrupts_property): Missing #interrupt-cells in interrupt-parent
/soc/interrupt-controller@e61c0000

Maybe just take out the patch adding the .dts file for the time being until
the important nodes are all in place?

        Arnd

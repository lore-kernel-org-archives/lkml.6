Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeCSNpD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:45:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932989AbeCSNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:44:59 -0400
Date: Mon, 19 Mar 2018 14:44:56 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Initial Allwinner H6 support
Message-ID: <20180319134456.shebby73ngqavsnl@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180318201744.dw6hnm2vdybaunev@flea>
 <F40271A8-3782-4A69-8C40-3909EB296C66@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <F40271A8-3782-4A69-8C40-3909EB296C66@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 09:28:23AM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2018年3月19日 GMT+08:00 上午4:17:44, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
> >On Fri, Mar 16, 2018 at 10:02:06PM +0800, Icenowy Zheng wrote:
> >> This patchset adds initial support for the Allwinner H6 SoC.
> >> 
> >> It's quite different from earlier Allwinner SoCs. For example, the
> >> memory map is refactored, and the CCU is rearranged. It's also the
> >first
> >> Allwinner SoC with PCI Express interface (although the implementation
> >> of the PCI Express controller is broken), and the second one with USB
> >> 3.0 (the first one is A80).
> >> 
> >> This patchset adds the most basical support for it, including the
> >main pin
> >> controller, the main CCU and the basical device tree.
> >> 
> >> Icenowy Zheng (9):
> >>   pinctrl: sunxi: refactor irq related register function to have desc
> >>   pinctrl: sunxi: introduce IRQ bank conversion function
> >>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
> >>   pinctrl: sunxi: add support for the Allwinner H6 main pin
> >controller
> >>   clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
> >>   dt-bindings: add device tree binding for Allwinner H6 main CCU
> >>   clk: sunxi-ng: add support for the Allwinner H6 CCU
> >>   arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
> >>   arm64: allwinner: h6: add support for Pine H64 board
> >
> >Applied the !pinctrl patches.
> 
> Oops, one clock (CLK_HDMI_SLOW) is missing in the CCU
> driver, as Jernej pointed out.
> 
> Should I send a patch that fix it?

Yes, please.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeFDKUF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:20:05 -0400
Received: from gloria.sntech.de ([95.129.55.99]:45672 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeFDKUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:20:03 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org,
        Romain Perier <romain.perier@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huibin Hong <huibin.hong@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        William Wu <william.wu@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
        Pierre-Hugues Husson <phh@phh.me>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, linux-kernel@vger.kernel.org,
        Mark Yao <mark.yao@rock-chips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andy Yan <andy.yan@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 0/2] Use SPDX-License-Identifier for rockchip devicetree files
Date: Mon, 04 Jun 2018 12:19:39 +0200
Message-ID: <1700848.99AcjQORKy@phil>
In-Reply-To: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
References: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Dezember 2017, 12:44:25 CEST schrieb Klaus Goger:
> This patch series replaces all the license text in rockchip devicetree
> files text with a proper SPDX-License-Identifier.
> It follows the guidelines submitted[1] by Thomas Gleixner that are not
> yet merged.
> 
> These series also fixes the issue with contradicting statements in most
> licenses. The introduction text claims to be GPL or X11[2] but the
> following verbatim copy of the license is actually a MIT[3] license.
> The X11 license includes a advertise clause and trademark information
> related to the X Consortium. As these X Consortium specfic points are
> irrelevant for us we stick with the actuall license text.
> 
> [1] https://patchwork.kernel.org/patch/10091607/
> [2] https://spdx.org/licenses/X11.html
> [3] https://spdx.org/licenses/MIT.html
> 
> 
> Klaus Goger (2):
>   arm64: dts: rockchip: use SPDX-License-Identifier
>   ARM: dts: rockchip: use SPDX-License-Identifier

This had now 6 months for anybody concerned about this change to speak
up - with no NACKs received, so I've applied both patches for 4.19

Heiko

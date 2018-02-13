Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeBMLwW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:52:22 -0500
Received: from gloria.sntech.de ([95.129.55.99]:56994 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934456AbeBMLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:52:20 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Zhong <zyw@rock-chips.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add cdn-dp node for rk3399.
Date: Tue, 13 Feb 2018 12:52:06 +0100
Message-ID: <1953673.4ODsl89y1u@diego>
In-Reply-To: <CAFqH_52NtRib_nLrGnacdGK=cHOeh8Lfaa=38X1OA8gnu1r=hQ@mail.gmail.com>
References: <20180207163150.16332-1-enric.balletbo@collabora.com> <d8ec2613-b773-9bab-cb4c-1f58eb1c1356@collabora.com> <CAFqH_52NtRib_nLrGnacdGK=cHOeh8Lfaa=38X1OA8gnu1r=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Dienstag, 13. Februar 2018, 12:36:47 CET schrieb Enric Balletbo Serra:
> 2018-02-13 11:42 GMT+01:00 Enric Balletbo i Serra
> 
> <enric.balletbo@collabora.com>:
> > Hi Heiko,
> > 
> > On 10/02/18 17:16, Heiko Stuebner wrote:
> >> Hi Enric,
> >> 
> >> Am Mittwoch, 7. Februar 2018, 17:31:49 CET schrieb Enric Balletbo i 
Serra:
> >>> From: Chris Zhong <zyw@rock-chips.com>
> >>> 
> >>> Add a node for the cdn DP controller which is embedded in the rk3399
> >>> SoC.
> >>> 
> >>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> ---
> >>> 
> >>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50
> >>>  ++++++++++++++++++++++++++++++++>> 
> >> It looks like there is no binding document at all for cdn-dp? At least
> >> I couldn't find one and the original series also didn't seem to include
> >> one.
> >> 
> >> And while I don't see anything problematic right with the used properties
> >> right now, I'd think we should really have a binding and give
> >> dt-maintainers a chance to complain, before adding devicetree nodes
> >> based on it.
> >> 
> >> I'd guess a mostly usable binding doc should already sit in the chromeos
> >> tree, which you could base a v2 of this series on?
> > 
> > Sure, I'll send a v2 for this series. Thanks.
> > 
> >   Enric
> 
> So seems that the binding was already discussed and accepted here [1]
> but for some reason never landed. So I think that I'll send v2 just
> including the binding patch so all can land together. Sounds good?
> 
> [1] https://patchwork.kernel.org/patch/9278077/

Nice find and yep, just resending binding + your patches 2+3
is enough then :-)


Heiko

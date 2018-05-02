Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEBG10 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:27:26 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39537 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeEBG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:27:24 -0400
X-Google-Smtp-Source: AB8JxZrdsKOhlm8W724Ne0fZqX4co4LPDUSZOcRN4ZxKwGFylQVeMxLRtgEddkHgeoEfmhUHsQqtAc7kOLLNbLtaNJQ=
MIME-Version: 1.0
In-Reply-To: <20180501161909.GA1728@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-9-jagan@amarulasolutions.com> <20180501161909.GA1728@rob-hp-laptop>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 2 May 2018 11:57:22 +0530
Message-ID: <CAMty3ZBBo41Odbife0WtPG__3qWaHZtkqUfOLTmqhzc_of+iYw@mail.gmail.com>
Subject: Re: [PATCH 08/21] bindings: display: Add compatible for A64 HDMI PHY
To: Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, May 1, 2018 at 9:49 PM, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Apr 30, 2018 at 05:10:45PM +0530, Jagan Teki wrote:
> > HDMI PHY on Allwinner A64 has similar like H3/H5.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > index 9ea4353caadd..7dcd1d64dfe4 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -104,6 +104,7 @@ Required properties:
> >    - compatible: value must be one of:
> >      * allwinner,sun8i-a83t-hdmi-phy
> >      * allwinner,sun8i-h3-hdmi-phy
> > +    * allwinner,sun50i-a64-hdmi-phy
>
> This should be one valid combination per line. The dts shows that the h3
> string is a fallback which should be captured in the binding doc.

The fallback compatible "allwinner,sun8i-h3-hdmi-phy" is already
documented above, what we need to capture here? or did I miss anything
here?

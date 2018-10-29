Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59770ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268B72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeJ2Rs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:48:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54313 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2Rs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:48:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2644D207D4; Mon, 29 Oct 2018 10:01:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id E633C20791;
        Mon, 29 Oct 2018 10:00:59 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:01:00 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 13/15] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
Message-ID: <20181029090100.h2zzdchyb3ls2hxe@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-14-jagan@amarulasolutions.com>
 <20181024180927.ejt7odo23ebzjgfg@flea>
 <CAMty3ZC3jXKBVrrCSd0Un+ZNvNKPj4C0WpcpNOYJBK1=vehBQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="547tgbqlmpx6son6"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC3jXKBVrrCSd0Un+ZNvNKPj4C0WpcpNOYJBK1=vehBQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--547tgbqlmpx6son6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 06:22:51PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:39 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:33PM +0530, Jagan Teki wrote:
> > > The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> > > on the one on A31.
> > >
> > > Add A64 compatible and append A31 compatible as fallback.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - new patch
> > >
> > >  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-ds=
i.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > index 9fa6e7a758ad..704fb31962f2 100644
> > > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > @@ -36,7 +36,7 @@ D-PHY
> > >
> > >  Required properties:
> > >    - compatible: value must be one of:
> > > -    * allwinner,sun6i-a31-mipi-dphy
> > > +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dp=
hy"
> >
> > No. you need both. The A64 MIPI DPHY one needs to be always set with
> > the A31 fallback, but the A31 is also usable on its own.
>=20
> Why wouldn't be, because we don't have any difference dphy right?

That's not my point. You removed from the binding documentation that
allwinner,sun6i-a31-mipi-dphy was a valid option on its own. It's not
ok to do so.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--547tgbqlmpx6son6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bMTAAKCRDj7w1vZxhR
xRb2AQDYLqR5lKFMeJ4nQvP+h+MgqMF32jXgYvXBdc1B/9SEGgEA21tjd+t0QYtC
pyY+IEgmBefftVavZR66nPGWUisBTgA=
=JXh0
-----END PGP SIGNATURE-----

--547tgbqlmpx6son6--

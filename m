Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73602C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3544E20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbeGZNKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:10:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54761 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbeGZNKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:10:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D28DE2072B; Thu, 26 Jul 2018 13:54:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3CB14208FF;
        Thu, 26 Jul 2018 13:54:09 +0200 (CEST)
Date:   Thu, 26 Jul 2018 13:54:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
        wens@csie.org, robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
Message-ID: <20180726115409.7hqtvx4rdqcqdjrq@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-5-manu@freebsd.org>
 <20180724130004.ynaiabshexrrbvo4@flea>
 <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
 <20180724144218.jdvgrcqkz2kmohqx@flea>
 <20180724165501.d8f01bf20c7cc43e7ed7fc62@bidouilliste.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjtvngosb7tku6q5"
Content-Disposition: inline
In-Reply-To: <20180724165501.d8f01bf20c7cc43e7ed7fc62@bidouilliste.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjtvngosb7tku6q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 04:55:01PM +0200, Emmanuel Vadot wrote:
> On Tue, 24 Jul 2018 16:42:18 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > On Tue, Jul 24, 2018 at 03:34:32PM +0200, Emmanuel Vadot wrote:
> > > On Tue, 24 Jul 2018 15:00:04 +0200
> > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >=20
> > > > On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> > > > > The SID controller on H5 look the same as the one present in the =
A64.
> > > > > But in case we find some difference one day at a compatible string
> > > > > of it's own and a fallback to the A64 one.
> > > > >=20
> > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >=20
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > index 62d646baac3c..28183bf77164 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > @@ -129,3 +129,8 @@
> > > > >  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > > > >  	compatible =3D "allwinner,sun50i-h5-pinctrl";
> > > > >  };
> > > > > +
> > > > > +&sid {
> > > > > +	compatible =3D "allwinner,sun50i-h5-sid",
> > > > > +		     "allwinner,sun50i-a64-sid";
> > > > > +};
> > > >=20
> > > > This is still a bit pointless, please remove the common node.
> > >=20
> > >  You mean directly declare sid controller in the SoC dtsi and not
> > > have a common node in sunxi-h3-h5.dtsi ?
> >=20
> > Yep
>=20
>  The reason I've put it in the common file is because I'll send patches
> for the nvmem-cells needed for thermal, and those are common between
> the two. Other nvmem-cells are also common (like the chipid and
> probably other).

Then we'll see what we can have in common and what not when we'll have
something in common?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--pjtvngosb7tku6q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltZtlsACgkQ0rTAlCFN
r3Q/qA/9HOrfkea8UFkgMWosn6UhE3ur7yPZVRqNvx/wb62DWMwSWXsoVLoKE2ld
sq4zocer720ZIkZSCJjGuAq8+NqB47YO3VVrn6Y9RFY9TzfWR+7rQ2O6/GsYvPAo
pIJXRAkveUI5RIO9pisTTIa48JZ96gPYqxrEA4WX2CAaqXJLSbrTokc8LXFcnupa
f4w9rEP9msjZqWSkVP7ljgexgATRRUPm7tXJn4vW9t8SVWdnCtIlp3WMXjzbcjbw
zAOyOkfhfmSCtgAVxJIlmrw1AhlEAM3AIHc6PjGRyTAPwhfxikg86ELsq/UubO5p
wdhssLA9DF7qa1SVEQ8KayrmbAbV7cj+/+//E5CQFpCT3w4iNncf1utAUWT0496M
kYSKUUzw3Uv1WmcfrH26kSYp6kF0V+r5LJfNkyTkWTDKGlH/LIxTjivS4RiSZpbg
D/quIZHa7VTrUkMvCveS+06SGfd7d/p+Kb67CchbB0pTsVbL7nsD9FT4gKhHpuvN
bsHxA5fqj5LqX6dvb3u//7V2Zh19HfB5bpRCDkTVNbfCW1ScaM9Lb4IqcXAIiKjb
TSFOf06fNxXertmvXX0YSpKkc1/asQWuAphrp9yLK1yPp+GbecRON6MyZeQakyJu
VNE3PfNVlVIXwq8tEYrpYyfBQBCgktZXevvIdo69yiWg0KHszAU=
=X4Om
-----END PGP SIGNATURE-----

--pjtvngosb7tku6q5--

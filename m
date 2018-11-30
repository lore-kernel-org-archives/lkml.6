Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40127C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280A2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F280A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLAAfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:35:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53569 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:35:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59BC1207B0; Fri, 30 Nov 2018 14:26:35 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 00B1320711;
        Fri, 30 Nov 2018 14:26:34 +0100 (CET)
Message-ID: <82a1ef7ea170ba50f58f74e26dac6170ac87783f.camel@bootlin.com>
Subject: Re: [PATCH 07/15] arm64: dts: allwinner: h5: Add system-control
 node with SRAM C1
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 30 Nov 2018 14:26:34 +0100
In-Reply-To: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
         <20181115145013.3378-8-paul.kocialkowski@bootlin.com>
         <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
         <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GiwLARmS2nmhlZHes8Vi"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GiwLARmS2nmhlZHes8Vi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-30 at 11:38 +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 16, 2018 at 12:52 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Add the H5-specific system control node description to its device-tre=
e
> > > with support for the SRAM C1 section, that will be used by the video
> > > codec node later on.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++=
++
> > >  1 file changed, 22 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h5.dtsi
> > > index b41dc1aab67d..c2d14b22b8c1 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > @@ -94,6 +94,28 @@
> > >         };
> > >=20
> > >         soc {
> > > +               system-control@1c00000 {
> > > +                       compatible =3D "allwinner,sun50i-h5-system-co=
ntrol";
> > > +                       reg =3D <0x01c00000 0x1000>;
> > > +                       #address-cells =3D <1>;
> > > +                       #size-cells =3D <1>;
> > > +                       ranges;
> > > +
> > > +                       sram_c1: sram@1d00000 {
> > > +                               compatible =3D "mmio-sram";
> > > +                               reg =3D <0x01d00000 0x80000>;
> >=20
> > I'll try to check this one tomorrow.
> >=20
> > I did find something interesting on the H3: there also seems to be SRAM=
 at
> > 0x01dc0000 to 0x01dcfeff , again mapped by the same bits as SRAM C1.
> >=20
> > And on the A33, the SRAM C1 range is 0x01d00000 to 0x01d478ff.
> >=20
> > This was found by mapping the SRAM to the CPU, then using devmem to pok=
e
> > around the register range. If there's SRAM, the first read would typica=
lly
> > return random data, and a subsequent write to it would set some value t=
hat
> > would be read back correctly. If there's no SRAM, a read either returns=
 0x0
> > or some random data that can't be overwritten.
> >=20
> > You might want to check the other SoCs.
>=20
> This range seems to contain stuff other than SRAM, possibly fixed lookup
> tables. Since this is entirely unknown, lets just stick to the known full
> range instead.

Thanks for investigating all this!

I also conducted some tests and found that the H5 has its SRAM C1
(marked as SRAM C in the manual) at 0x18000. However for the A64, SRAM
C1 gets mapped to 0x1D00000. There is also SRAM C at 0x18000 but this
one seems unrelated to the VPU and only used by DE2 (as already
described in the A64 dt).

I share your conclusion that there seems to be more than SRAM in there.
Testing with devmem write/read on the start address was reliable as a
test, but some chunks in the range did not behave like SRAM (not the
same value read).

I agree that we should keep the known full range as there are lots of
unknowns here.

Cheers,

Paul

> ChenYu
>=20
> > > +                               #address-cells =3D <1>;
> > > +                               #size-cells =3D <1>;
> > > +                               ranges =3D <0 0x01d00000 0x80000>;
> > > +
> > > +                               ve_sram: sram-section@0 {
> > > +                                       compatible =3D "allwinner,sun=
50i-h5-sram-c1",
> > > +                                                    "allwinner,sun4i=
-a10-sram-c1";
> > > +                                       reg =3D <0x000000 0x80000>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                 mali: gpu@1e80000 {
> > >                         compatible =3D "allwinner,sun50i-h5-mali", "a=
rm,mali-450";
> > >                         reg =3D <0x01e80000 0x30000>;
> > > --
> > > 2.19.1
> > >=20
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-GiwLARmS2nmhlZHes8Vi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlwBOooACgkQ3cLmz3+f
v9H5cAf/Y4PYNTtU8z80K7NkG2UKbqz1WClI50UXcS49VGXlbAN+Q4scGjd2bzML
JMgd3lpH5sCqmMR0B3sZBe1H7qPuTQQwZ6h94h8aULW7BppqjT3X2FGuaOr5TT5l
0OL4Rlsj1RzKB8vFn3prDtwOlDanSjq1Akrf8F1pNs6CH4wmtVhEOtQq6Pzgb6RY
KQZrD9Ahyh01YQd2eWvmCEEwQKMbS61uFRWSKbi6PPqCn9NjkyzYYB5MhDOQ2Rl5
OtLiDpcTMR3GwpbfNczbUsy3C/Ad8Yo0iZvVMoqKgZpLbqyXkT4r5qIcNc80uY8u
LEep4QqRU2g3pCM3AY0wvpAfzidZgg==
=LKPm
-----END PGP SIGNATURE-----

--=-GiwLARmS2nmhlZHes8Vi--


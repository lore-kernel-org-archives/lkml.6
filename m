Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0824CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeGXS2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:28:05 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:49808 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbeGXS2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:28:05 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 76B7DC0149;
        Tue, 24 Jul 2018 19:20:33 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 84E50C0F1B; Tue, 24 Jul 2018 19:20:31 +0200 (CEST)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id DDBC7C0F14;
        Tue, 24 Jul 2018 19:19:55 +0200 (CEST)
Message-ID: <39b1eef01c2ed32f09ef30439c4f4297de009898.camel@paulk.fr>
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable
 H3 sid controller
From:   Paul Kocialkowski <contact@paulk.fr>
To:     embed3d@gmail.com, Kyle Evans <kevans@freebsd.org>, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, quentin.schulz@free-electrons.com,
        edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Date:   Tue, 24 Jul 2018 19:19:54 +0200
In-Reply-To: <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
         <20180128232919.12639-15-embed3d@gmail.com>
         <20180129095200.attg7cgvpifpchtn@flea.lan>
         <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
         <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
         <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
         <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
         <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xzR/LJPMHBlmHKrlL/gR"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xzR/LJPMHBlmHKrlL/gR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 20 avril 2018 =C3=A0 11:35 +0200, Philipp Rossak a =C3=A9crit :
> Hi Kyle,
>=20
> I'm already working on a Version 3 of this patch series. Right now this=
=20
> slowed down since I'm very busy and the ToDo-List is still very long.
>=20
> My plan is to send out a version during this release cycle.
>=20
> If you need it right now feel free to submit patches!

I just came around this patch while testing SID support for H3, that is
not enabled in the dts at this point despite driver support.

Maxime, would it make sense to merge this patch as-is, without support
for the thermal calibration section, since the two aspects seem rather
independent (and some other SoCs also have a SID node without linkage
for thermal support anyway)?

Cheers,

Paul

> Philipp
>=20
> On 19.04.2018 17:19, Kyle Evans wrote:
> > On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wrote=
:
> > >=20
> > >=20
> > > =E4=BA=8E 2018=E5=B9=B44=E6=9C=8819=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=8811:11:22, Kyle Evans <kevans@freebsd.org> =E5=86=99=E5=88=B0:
> > > > On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com>
> > > > wrote:
> > > > >=20
> > > > >=20
> > > > > On 29.01.2018 10:52, Maxime Ripard wrote:
> > > > > >=20
> > > > > > On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
> > > > > > >=20
> > > > > > > This patch enables the the sid controller in the H3. It can b=
e used
> > > > > > > for thermal calibration data.
> > > > > > >=20
> > > > > > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > > > > > ---
> > > > > > >    arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> > > > > > >    1 file changed, 7 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > index 3f83f6a27c74..9bb5cc29fec5 100644
> > > > > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > @@ -72,6 +72,13 @@
> > > > > > >                  };
> > > > > > >          };
> > > > > > >    +     soc {
> > > > > > > +               sid: eeprom@1c14000 {
> > > > > > > +                       compatible =3D "allwinner,sun8i-h3-si=
d";
> > > > > > > +                       reg =3D <0x01c14000 0x400>;
> > > > > > > +               };
> > > > > > > +       };
> > > > > > > +
> > > > > >=20
> > > > > >=20
> > > > > > Shouldn't you also use a nvmem-cells property to the THS node?
> > > > > >=20
> > > > > > Maxime
> > > > > >=20
> > > > >=20
> > > > > Oh seems like I forgot that.
> > > > > As related to the wiki [1] this should be 64 bit wide at the addr=
ess
> > > >=20
> > > > 0x34. I
> > > > > will add that in the next version.
> > > > >=20
> > > > >=20
> > > > > [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
> > > > >=20
> > > > > Thanks,
> > > > > Philipp
> > > > >=20
> > > >=20
> > > > Hi,
> > > >=20
> > > > Any chance this will see a v3 soon? I'm kind of interested in sid n=
ode
> > > > for h3. =3D)
> > >=20
> > > This patch is independent and can be easily sent out
> > > by its own.
> > >=20
> >=20
> > Right- I had considered doing so, but wanted to make sure I wasn't
> > going to collide with this series if a v3 is imminent.
> >=20
>=20
>=20
--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-xzR/LJPMHBlmHKrlL/gR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAltXX7oACgkQhP3B6o/u
lQzvTQ/+K8cvJP3xINJvqaxmiYerl69XPraXfIGCKUX8Ecj3UbSgBfZmMJMBtps0
D4R7Rs9QYJUiiQaUmWm3yAMGXtohrB88ydSonAHGBrpUOsnPkN2DAE1Q/lohrE4I
f6F52Y/KTSwa1qoGKcGcJsQrjkn5PSLN/8WLOk8ION3b3BYY7EKiNKP7w+DQeNrf
/uR5IW7JMTDgKpFc1KFguQOb7vXrRg7aGWKIfS9J0Bx6Scozu2eVoqeS4f50LOZu
vOdaobhnof3KMk8h2k0/B1kN5fGCILQIKD+9lQM0B11cUvSQ2pS6XFMTuJpBpLFY
gwKTQN6E2YyK7mYzGvcd39ap/+iUJhaPk4tF23qjXWjN0lIhGz3gtqQaVjs6Pxoy
mvqRjuA/Xm6sok/1YnabAc56wJH0rTJ4L4VVKra3yDKCWTVhBIoAcRgFCKHnepYH
iuJ3jDlpW+qNoQ7KKQKnrOr2JgjpVte1hsXLZLuwtq+L1v0jMQcpkXWHBdYtoG0E
QYF7lGtJ62TpJ8xVbODlJP3c+kbgI1rA+rsDLPR04AC9Gr0mNCC/AMoGQlem05I6
gjbS72fl+cKbQhu05AdgANNHI/WDixbL+UnDu+eY1So+sEwzs8TRBEvS+xfnB5HX
T0LqdRpFikWcUlvkdDilJRim3QWIfUFPH4F8XHNkegEq+xiCisw=
=NWb7
-----END PGP SIGNATURE-----

--=-xzR/LJPMHBlmHKrlL/gR--


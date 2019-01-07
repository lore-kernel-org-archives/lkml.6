Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3019CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06229206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfAGStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:49:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49173 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfAGStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:49:46 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 87ED0809D7; Mon,  7 Jan 2019 19:49:39 +0100 (CET)
Date:   Mon, 7 Jan 2019 19:49:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        trivial@kernel.org
Cc:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@savoirfairelinux.com" 
        <vivien.didelot@savoirfairelinux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "buytenh@marvell.com" <buytenh@marvell.com>,
        "buytenh@wantstofly.org" <buytenh@wantstofly.org>,
        "nico@marvell.com" <nico@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dsa device tree bindings: fix typo and wrong example
Message-ID: <20190107184944.GA17979@amd>
References: <20181115195111.GA9946@amd>
 <20181206130051.GA22343@amd>
 <20181206130513.GE22343@amd>
 <819595ee-9f3e-b7a2-6139-1ba265137f62@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <819595ee-9f3e-b7a2-6139-1ba265137f62@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-06 13:28:56, Vok=C3=A1=C4=8D Michal wrote:
> On 6.12.2018 14:05, Pavel Machek wrote:
> >     =20
> > Fix typo and fix compatible value that is not actually permitted by the
> > description in the example.
>=20
> Ahoj Pavle, I think the subject should be more like:
>=20
> 	"dt-bindings: net: dsa: ..."

Ahoj!

Well, retrying with different subject only makes sense if someone is
interested. Rob, Andrew -- can you take the patch?

Do you want me to edit the subject or can you just edit the subject
while applying?

Thanks,
								Pavel

> BR, Michal
>=20
> >    =20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Do=
cumentation/devicetree/bindings/net/dsa/marvell.txt
> > index feb007af13cb..abf1be036ac5 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
> > +++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
> > @@ -41,7 +41,7 @@ Optional properties:
> >   - mdio			: Container of PHY and devices on the switches MDIO
> >   			  bus.
> >   - mdio?		: Container of PHYs and devices on the external MDIO
> > -			  bus. The node must contains a compatible string of
> > +			  bus. The node must contain a compatible string of
> >   			  "marvell,mv88e6xxx-mdio-external"
> >  =20
> >   Example:
> > @@ -80,7 +80,7 @@ Example:
> >   		#interrupt-cells =3D <2>;
> >  =20
> >   		switch0: switch@0 {
> > -			compatible =3D "marvell,mv88e6390";
> > +			compatible =3D "marvell,mv88e6190";
> >   			reg =3D <0>;
> >   			reset-gpios =3D <&gpio5 1 GPIO_ACTIVE_LOW>;
> >  =20
> >=20
> >=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzn0gACgkQMOfwapXb+vLdZQCfe7+ILyxxuTHSPAvxxrrhvXXr
nHEAnjs7VuAlSiTCHmTvPp5YZ5zNVz5d
=KMKg
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

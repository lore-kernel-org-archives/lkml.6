Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeCEQ3a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:29:30 -0500
Received: from sauhun.de ([88.99.104.3]:40267 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753036AbeCEQ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:29:28 -0500
Date: Mon, 5 Mar 2018 17:29:26 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: verify the device id of the
 pca984x chips
Message-ID: <20180305162926.qp5iy3uzojhwoz4m@ninjato>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-3-peda@axentia.se>
 <20180305155303.i4zut6wtwckdes7z@ninjato>
 <eb97edc2-3a16-2931-2f19-a80a5ab4d88b@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m572mugpsfjanghb"
Content-Disposition: inline
In-Reply-To: <eb97edc2-3a16-2931-2f19-a80a5ab4d88b@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m572mugpsfjanghb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 04:55:56PM +0100, Peter Rosin wrote:
> On 2018-03-05 16:53, Wolfram Sang wrote:
> >=20
> >> @@ -97,59 +98,83 @@ static const struct chip_desc chips[] =3D {
> >>  		.nchans =3D 2,
> >>  		.enable =3D 0x4,
> >>  		.muxtype =3D pca954x_ismux,
> >> +		.id =3D { .manufacturer_id =3D I2C_DEVICE_ID_NONE },
> >=20
> > Can't we just leave this empty and add a NULL pointer check below when
> > testing for the device id?
>=20
> Nope, it's not a pointer. I didn't think it should be, but maybe it
> should?

Nope, you are right. Thanks for the heads up!


--m572mugpsfjanghb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdcGYACgkQFA3kzBSg
KbZwNQ//Z2rGhec6viCWyfVBnm7ZxT79+G2rLda+OE5j3cnOvjPUWdE+PiF6CKAo
z+x1Mf6YmuQYW/p+IIavDmC1lx4YPqD/vkMIe9WdepXocm6eDp9JM50txitrrKS1
T3MqEK31un0mNQgrsCWzEC37MSBoo0VAN0cZspXJYePKEp/XLljos5ViavsGMAHD
gDGyypuMukngBzhfmjM1P9tIlQ2pARjqBt6pFaTlgfbrX9ybSKDNEL6BnUNjVh/o
4uWr5x/uL60WYJ3oaiTDHtZgkpDLsC2G7cYVxDCBYOe199rIAFmNtbkifOo93xnl
q8WHX0kgX4yyAgyEbh3Rt38j3/KAEUpjoxUevwf30jVFQIv8fL3UMZYPJ2d3zIqt
K1Hu/bO6qYDQ/Z5BtjOAwcuEEazUf7DnXviVtMvC1z7h4qv+uQLJnUqf3JdFwSzi
CiXpIPhPSg7MAErcchI6qWqkV1jRq2NF0ZnJr5tZfgFAVnQ/xFNQq1zMP1uo4Rtk
w8zGeowR2sw5JjRclJCi9XvRa/L3BnIZg99Ucp6MKzdsJb+RQU6+BSqBeqfhMVMO
GfxwtjxCRVPh4JAIRjFndaJSd+inGmZtaqyIaVttT8wmdZqkBoJswcXbZw92csox
W6VRivr0egpj4gc65vovJaMFUEFxVd70CvG+9itQB06vqKZvkHo=
=tj38
-----END PGP SIGNATURE-----

--m572mugpsfjanghb--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033021AbeBON6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:58:52 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54312 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBON6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:58:51 -0500
Date: Thu, 15 Feb 2018 14:58:40 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: sun7i: dt: Add Mali node
Message-ID: <20180215135840.vt4ujoecvirpidbr@flea.lan>
References: <1518702362-115625-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olxufokcp5gvic37"
Content-Disposition: inline
In-Reply-To: <1518702362-115625-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olxufokcp5gvic37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 02:46:02PM +0100, Giulio Benetti wrote:
> The A20 has an ARM Mali 400 GPU, so add binding to our DT.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

The prefix should have been ARM: dts: sun7i. Fixed and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--olxufokcp5gvic37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqFkg8ACgkQ0rTAlCFN
r3T8Iw/+JrhdaVqLBs/Ljs8woZIhUNmvlnEu4wxpF0309JF8uFHNqOgS2oSXBCaP
ms3fRRIRYyRanzw7A7oWfDU5nRXTfA1kiojHwV+gLFNts+AUHTPKOhqjQRn88LL/
JFv/daYPrmQ8DgQXDZQKh1lftbVnak30zPE3681QkBYWOyv8N8SbhaRZOkxYjWfJ
dqaTeVtm5yp/2GrewVSRm2MmJEHijy6xQNdCLFf9WuJm5TqYR+G/LYc1CPjRM6Sm
c1wPcdymbjLLOQUch/zLvD7XAPIaWJClBmKAKSeBcLzeC5Ofx1VvSvvHurvtG8hp
gZFx/8alOprlODuPe5W5imqO33PNAbmM0l/MhWddGrP3hDwM/Yw3R/8tJwIpgGk8
9W0+ok01tzSiI5CT1mwZ8bNDXTHQudVXw9kIzF7h89znWAU3ixzwjyoN/cNbnzCE
XhW1n5HXDIlD12Lp7PzCO2WhZZK262rnPcM8M8XG25inP7ygrCNRtawa1bb9M5m6
jyroHBocjZ0VR3YGIiHDeM8jNrw5n61cmynN+2GxLdhCbK4SIwzse1Xww4zCUo8b
rxdTexJGRmlC4/0iJrVb2EtmP3dnpW9xg5hZ4Lx1xAbiBrCLqxBNC75cItR6SOsO
bPNatz/v9jYgVr7Ch7Ao4VFv54sXXSciWSKH3HPdVOVSlliB7Ws=
=6ei6
-----END PGP SIGNATURE-----

--olxufokcp5gvic37--

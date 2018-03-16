Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeCPGrp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:47:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57201 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPGrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:47:43 -0400
Date: Fri, 16 Mar 2018 07:47:31 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
Message-ID: <20180316064731.muiw5yumhmfnwxg2@flea>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55qzmh7lq24dy5mx"
Content-Disposition: inline
In-Reply-To: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55qzmh7lq24dy5mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Giulio,

On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
> for the needed pins.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Like we discussed last time, we only merge this kind of patches if
there's an immediate user.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--55qzmh7lq24dy5mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqraIIACgkQ0rTAlCFN
r3TsTQ//aVAtfYmdxajp7kPWYUnUM183XdCsZdfdMaXpRxePj/8hrX+c8ajc2wlh
7MCqz4hwX2neJHIzgD407cJPgk8lgmG7I82rKxiMyahtrTrRCtd9cvCxcJiYU7Zz
d2udNrvS7VQVME+A1Kr+W5MNCfPHJ4rJ9hexidojEIswVmJ1w05ZjleHy3T/QpFw
jis8tvPSamLstNfW9WaKPqXA6HMM+NEqFXCI1EYXRHLkJo6htkkIbyn38JPg4OSl
KcVwUT6+h6Qh9WKeQ3lDdwLijJEmXfFINwL6aBU7ITyGXOjj7lKdO6cRZpEonbpz
GU6NT37JnQb2Iu0vynECw5i26SMfcxg3Lj4kBObU3FBhDTUM99W0HgLnnSbRYnua
xeRpQ34pQGmq/SSjL6PiumWMy8a41CGoB1TrX4Xtzx5vIS1aj3YKgiGZubfrRxNT
YPjhJ3Ly9Nq1EFO8Xyv4Vmee1U1xW9SSNqazLxZ7ZR09E4SjTkIOlS4JdT2UsBKe
IHdCVt9RmhzU4E1Ry/mpPsIbvqUp//rVFe6uj8Jm6I4flV4kwT3SfNZ9QBTAAVJf
BLcGc731NZZF0jAX4duRqUokWQaOKk65TI/OZC9Ro9yiOqg6vNpPlq+JYZw0xx65
W0UVN5ZBI8bSbEDN+D7vFhpD5DnQkmChoViWWaW2mFD1s5aN0BM=
=zACC
-----END PGP SIGNATURE-----

--55qzmh7lq24dy5mx--

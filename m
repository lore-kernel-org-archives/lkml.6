Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEBNSN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:18:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbeEBNSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:18:09 -0400
Date: Wed, 2 May 2018 15:18:06 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Simon Horman <horms@verge.net.au>
Cc: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, geert@linux-m68k.org,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] ARM: shmobile: Convert file to use cntvoff
Message-ID: <20180502131806.5aybrfzll7wdoybv@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-13-mylene.josserand@bootlin.com>
 <20180502063639.qa7bzqxzrejd4kh2@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xs6p73yn657oz5w"
Content-Disposition: inline
In-Reply-To: <20180502063639.qa7bzqxzrejd4kh2@verge.net.au>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xs6p73yn657oz5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Wed, May 02, 2018 at 08:36:39AM +0200, Simon Horman wrote:
> On Tue, May 01, 2018 at 02:31:31PM +0200, Myl=E8ne Josserand wrote:
> > Now that a common function is available for CNTVOFF's
> > initialization, let's convert shmobile-apmu code to use
> > this function.
> >=20
> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

For the sake of bisectability (and to ease the merge), is it ok if we
take it through the sunxi (and then arm-soc) tree?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4xs6p73yn657oz5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpuo0ACgkQ0rTAlCFN
r3RLxRAAiejDwvQhxN6ZNXNcWXeZNjXK6qY5g0tdhuHV1m2aKLSubfFaKevK3+QD
CnVkkZJDRY59PY+HIOwedNEQcuKpP/aSH6ZmuKj/oHR0F8RSGqyw8iiDZQnf+EHm
PJ2x6PnNIym8Y0EWFAMDLk9LIOm0/hbXdQ4+Bvm3zoclmSJfHpwdjiYItRQqi/he
jqAiG0v/nWMdGiq2UCzOTCcQYof404bga917zlGd3SUckPysAbqX8I6fv/JcO9pF
je6pWHhDYPIUVUOFIRuHei15amPiVh2CoFEfGn5x6S6weso2K1jh2CxDUSHHojA6
iNIbKesq1YTpbvUThfNRVOlh0BNEkaYRKSMhMU1dLVxcwcF1VdhASf5veRw07yTL
orjBadmCDOA1AUf49luDkJi7O/T+oJhF7dwIp/5sb4YzSIXCVbM/81b8V/b5lEzr
McUKH8iO2Me96t3Z18FxFx3sJoajP4wtEWQaSuiKEkCYRvx7MRBUyrWbV7tC0UdG
Vg+ei3bjYwB/VipVbA4+tDEwXKVKFJqeYFO9k20scgw387r1I+lIGazh9w9j2zzr
38lMJytJgl3pQs7XbUR7msZFAz0Y8AeWE8C8BwaZJL3ucj/GdHFGX6fg8KcjdHrs
nTgZNKJco23MyzRSn+OSd/NcdsoyDou8NoDtPwS4eJ5vuYWgImI=
=djhr
-----END PGP SIGNATURE-----

--4xs6p73yn657oz5w--

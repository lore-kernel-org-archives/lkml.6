Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeCES23 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:28:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeCES21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:28:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBA721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 5 Mar 2018 18:28:21 +0000
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 7/8] MIPS: qi_lb60: Enable the jz4740-wdt driver
Message-ID: <20180305182821.GH4197@saruman>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20171230135108.6834-7-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 02:51:07PM +0100, Paul Cercueil wrote:
> The watchdog is an useful piece of hardware, so there's no reason not to
> enable it.

Presumably this is important for restart to work after the change in the
next patch? Probably worth mentioning that too if thats the case.

>=20
> This commit enables the Kconfig option in the qi_lb60 defconfig.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

The change looks good to me though

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James
=20

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdjEQACgkQbAtpk944
dnpRnxAAoEQxrhZDUqJpdLEym/nqSZ24dEWfXloChiM4PcKwSpxyNIgCPr0Xj7aT
Ec9v6SxIR9ChLkqtDxa0nkt+XM6vubmCsFlCpp57yFwobg8C6jOl+A/c4MtICsj0
p3ec9IB5Uh/Od5zrXYLo62OQauO7h7oUC6pHXsNyND8LMhxoXlHIQ5L6OujNSMZs
ZV8zR+fo46iaj+zGdSVTaZynGh8oW2VxMzzwu47Zntv3YYYa00OqDvuaQGF89WNJ
WZme4o2tCVcqZk6E4z4Ax3L0eU46c0W4ZAknRto7pfoi4UmghMqEJ7sGj1syriwS
OQsLzwzIV2+OGyPQd5EKdZhJxEQ1BUZXAoovF9AieImvsn+l59VmYtpxcm6mT8JO
fJJDkazoKJMsbX64k/dYFsRSfCqUo0jUX3ZJoBUSsCaWJTxwYeWwVUHUYpBoGdU4
lSjLgEWtgKEy9JtjQZl34QXMmcqvPar8pnMF/egWK8vKi7HVa6YxJg8eJ5zezBRk
QgpXFxa1YpybVi/00Z9vuFUFg2TXXoNd3vOZnSoX/Mr40Fg5K04yvHZEiaJn/3/Q
SIUfpYHU3h+IXZDftAC+TD3k9iJetNyUZ5S8I2L5dtf4fmYzIGLmJVfHIW/dqduf
6pkqTEkLgaLx5LRRTZwk0cgtFuK00rQ/9RJndl5qSLiKTq+8FZI=
=Fr2u
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--

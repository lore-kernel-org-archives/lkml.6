Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161390AbeCATic (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:38:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161262AbeCATib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:38:31 -0500
Date: Thu, 1 Mar 2018 19:38:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 0/7] Add coupled regulators mechanism
Message-ID: <20180301193827.GK12864@sirena.org.uk>
References: <CGME20180122143019eucas1p213b852c98cde3fb8a77b96ab0d372ee6@eucas1p2.samsung.com>
 <1516631412-17542-1-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <1516631412-17542-1-git-send-email-m.purski@samsung.com>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 03:30:05PM +0100, Maciej Purski wrote:
> Hi all,
>=20
> this patchset adds a new mechanism to the framework - regulators' couplin=
g.

I've had another go through this and way about to apply but I've
realized that it needs a rebase against the latest regulator tree, the
changes for suspend states collide with the voltage change code.  Can
you rebase against my current -next please?  It's just the last patch
that has merge issues.  Sorry for the delay, this got buried as everyone
seems to have decided to send me 20+ patch serieses all of a sudden.

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYVrMACgkQJNaLcl1U
h9CcBwf/Z7EpuEA/Et4z2goZyhB8nlgaSQ4qIED45nkW06N2qVUq854R+00XjcML
brSfzHHbgMGxg/eVbyhSBY2J1gnGmqCcXoNpnkKCou5DwhyJMXsf3V0lr4hnvwP5
x1/pr6pXSB3YQvUIu/7gdmf90bwJo9Siert+4X9TvUqSF3Q4mZR/TSRC+9ai/ZYJ
9J21H9o75/VAAOvMTDGW85m8X7Yn4e2UzgC4TFfouvSKmTxd5WNn0xw1V+rYzN+U
2N2fed1FNV82I4cDa03lwD+FLsbs5L+9BKHtfsiHLonhXjezSLqwXzp1wp7QNo7R
aXymxXE469/h9RsJ3/jRgrfJv+CrBQ==
=7j7a
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032084AbeBNQEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:04:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41704 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032073AbeBNQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:04:29 -0500
Date: Wed, 14 Feb 2018 16:04:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Trent Piepho <tpiepho@impinj.com>
Cc: linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
Message-ID: <20180214160424.GF12658@sirena.org.uk>
References: <1518463905.25398.281.camel@impinj.com>
 <20180212193814.17644-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20180212193814.17644-1-tpiepho@impinj.com>
X-Cookie: Who is John Galt?
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 11:38:14AM -0800, Trent Piepho wrote:
> We want to check for xfers that are over 30 microseconds.  Rather than
> find how many =B5s a xfer will take, instead find how many bytes can be
> transferred in 30 =B5s.  The latter must be less than 32 bits (since our
> clock speed is limited to 32 bits), while the former involves 64 bit
> quantities and more arithmetic operations.

Please don't bury patches in the middle of existing threads, it makes it
much harder to find them.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEXgcACgkQJNaLcl1U
h9AOaAf+M3iRgU/R7ovC6LI/9ir/WLDZkKGuAvajlFBuGUihZ+ycSDmOA75Hg/EO
bV4LJvtMYwXU5Hrpx1p4ACm9LUDY1WmuL0ZKOZbkbBn5d2gvytdioQ3jUE2bAmmb
1/qh3WCqNl04rLMyO6ZPE+9EjqSzvNTYXPtc9Azxrl8WoZcLtf2A1v9GkG1rbgrW
UB0HakZw3cRTu7RfbEyPYTMb33PCLiGYRFHTpHjTejDeUe5LbBZpAc5dCLdL6gA0
/pm9JTtfpkZwIrzDdjktzk9MLnyXS79QwbY3IRPXA3vcqtRn9kX73Omx5QEJmqOk
jYOcUaId7GtwKPvTsHayOzuEPF8m9w==
=RJmP
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--

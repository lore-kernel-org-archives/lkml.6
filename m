Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCNQSB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:18:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCNQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:17:59 -0400
Date: Wed, 14 Mar 2018 09:17:53 -0700
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 34/47] spi: remove blackfin related host drivers
Message-ID: <20180314161753.GT2186@sirena.org.uk>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-35-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-35-arnd@arndb.de>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 04:35:47PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so these
> won't be needed any more.

Acked-by: Mark Brown <broonie@kernel.org>

(or if you resend something directly applicable I can do that)

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpSzAACgkQJNaLcl1U
h9Dm9wf/dhNzPHEVAxztXFolS6JT9Sw4qUXvJRw0lXsHYBUSiYWWlKPdeCgXAWRS
Y9mnmUYQdGVGuSAIHzjNk5UCFfIpW50UIu/0IjaJAcmGy2M4jMuX3SDfbhLJx2mt
7142piElsmG/gotQuzUnc4qkC8SDtoZH1hi8p8PKD00WdJVlulGL6aJEsDnpc3DJ
BkUYxQanSIP1dWjoy8U2nz1hDyYvLh6QGKCMymQm5VDfLQSBMEZu8i6TcodNWs8U
vPHNATqITYoeUKpbPa2wnDOwSjol0M0LhLdT9dDVbdV+e0folEhexbzzG9ZiePKX
2owZNoQW7LiUw5wmaeuasHAH9KaS3g==
=BrBX
-----END PGP SIGNATURE-----

--WQ40utMgiyDduspJ--

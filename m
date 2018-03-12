Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeCLSfa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:35:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCLSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:35:29 -0400
Date: Mon, 12 Mar 2018 11:35:21 -0700
From: Mark Brown <broonie@kernel.org>
To: codekipper@gmail.com
Cc: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support for loopback
Message-ID: <20180312183521.GP2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmVHo2jXx4bdYlgS"
Content-Disposition: inline
In-Reply-To: <20180312155753.9478-7-codekipper@gmail.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmVHo2jXx4bdYlgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2018 at 04:57:53PM +0100, codekipper@gmail.com wrote:

> +- loopback:	if this property is present then the dai is configured in
> +		loopback mode where the output fifo is redirected to the input
> +		fifo.

This really doesn't seem like something that ought to go into the DT
and hence ABI given that there's obviously no reason to use this in
production.  Just make it be a #define in the code or something.

--cmVHo2jXx4bdYlgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmyGgACgkQJNaLcl1U
h9DKGwf/fEsKyLWh7qHH1FKS9OOo2Lr6CBEU/7DAHjMAkQvpRKPEKH0pEgS99uuW
moEpDFHrScp6A+vgQsZMKO/rk5bgqOeoz+9gFHIfR5bGz17QPNjuA5T8Uvw7PBHk
kGpaKcLk0T7dkPng1igOlc9pQrwokaldDJRj38ixBEcRybfooNF2wFq07a66z5NI
qK0hOGzIMbetpG2Spits83X0N3K/P4/gG72V+UlCR65K31dnhX0U+iSAtYY5srYC
ZQMzLLXzAwjjCrJYFsYWUkTgUKdk2t27y+Z7ZebKAWXiij1zzmOX0cC/MRo2fist
Sd51QiGaluqqNiqwrooyxghGBhlZ2A==
=KOfl
-----END PGP SIGNATURE-----

--cmVHo2jXx4bdYlgS--

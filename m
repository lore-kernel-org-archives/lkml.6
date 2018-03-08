Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755767AbeCHLOK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:14:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeCHLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:14:09 -0500
Date: Thu, 8 Mar 2018 11:13:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Message-ID: <20180308111348.GB6019@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <20180302124050.GF6255@sirena.org.uk>
 <26212674.B0xcQEiVyd@jernej-laptop>
 <1832733.mujlD9skaR@jernej-laptop>
 <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
X-Cookie: Given my druthers, I'd druther not.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2018 at 01:21:02AM +0000, Kuninori Morimoto wrote:

> Ahh.. indeed. Good catch !
> How about to add such flag ?
> This is just idea. No tested, No compiled, but can help you ?

I think this makes sense as a patch.  We might want to disallow
allocating components as part of a bigger struct so everything is more
consistent but that's a bigger thing.

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqhGuwACgkQJNaLcl1U
h9AUAgf+MJiAYUpRZy23aEevSZgmNgAduCG2s0RlN9hiuqqD8OEbMFcqo71h6m7j
7PohlRTqyKiwx9yAkbHaga8dzm+0sizBz8chgUEp/tbWCsVwfkx/Gd8xek4/ygFC
yGmlvUFhNLM7G+wQLYaz7U8lzFXH5Mr2DvAkVRW7HD7rdsm0QAmOqhLpm9yU5547
PuhXVEMXt88zaXldwgMeQ5KAIn0sRqIIPHMAP0vaEAyy8fBLX8pBSDrrF9zzVYUY
zaflBqqwzKcMXEvTyIFaaK4jRHG4xL6H7JGIAq5H8Szz5c291GJfiTl17l8ER7KA
jSIiCgNGWckHqyX+VAzkNudAkpkJwQ==
=HqiJ
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

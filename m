Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCIMmi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:42:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeCIMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:42:37 -0500
Date: Fri, 9 Mar 2018 12:42:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
Message-ID: <20180309124234.GC5252@sirena.org.uk>
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
 <1520598128-11768-1-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2018 at 01:22:02PM +0100, Maciej Purski wrote:

> I would like to kindly ask Fabio Estevam and Tony Lindgren to test the patch
> series on their boards.

That'd be great, yeah - I can run some tests with kernelci as well,
though the latency is relatively high there.

Is it possible to respin this in terms of the test/coupled branch in my
git tree?  There were a bunch of build fixes that got sent and I don't
want to loose any of those.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqigTkACgkQJNaLcl1U
h9CL9Af/SO8aYa4hV6zxy2AGQUrHuWKvSDEPFpFI506yASjEYeVhlMS3U0+4zPlu
nJZwWtpH/9EDh7rsDzxecTXtsZr+3cLbc+ORvqvW+LhE+RXIqsd3U2UkQYU0gxTF
7HytmysBN6j92YoZIQN3TjC+uRwzweCAkCujSoB4xWjXb2dWFldxkrcw+wK1Oi6y
S9l3fjxH3BtAxHNqUY5NJoglC4L8aP0x4yXRQk5HLos9vzs/hv3JAfZGNryzwV5Y
cmpiq8fgPXliumF+Anwud3Wdg7fcF8LDOdMNYH12BaEb7/JUb7tfgnYsb+aNAeLR
D2MVHikqyUsfxxhr87dyIt4qOB2Vdw==
=OJsv
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

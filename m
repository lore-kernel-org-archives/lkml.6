Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967912AbeBOLwI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:52:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967814AbeBOLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:52:07 -0500
Date: Thu, 15 Feb 2018 11:52:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Harald Geyer <harald@ccbib.org>, Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Applied "regulator: dt: regulator-name is required property" to
 the regulator tree
Message-ID: <20180215115202.GC8374@sirena.org.uk>
References: <1518532988-10990-1-git-send-email-harald@ccbib.org>
 <E1elzv3-0005l2-MP@debutante>
 <CAMuHMdVLO4Y-NzS6bLp2dUy1oSqmEthC_yD5jCe_R9H4vWBwMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVLO4Y-NzS6bLp2dUy1oSqmEthC_yD5jCe_R9H4vWBwMA@mail.gmail.com>
X-Cookie: Stay on the trail.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 10:39:41AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 14, 2018 at 5:28 PM, Mark Brown <broonie@kernel.org> wrote:

> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Mark Brown <broonie@kernel.org>

> What about using the DT node name instead, as is done for single-output
> clocks?

Yup, that'd work too.

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFdGEACgkQJNaLcl1U
h9Apagf/RG/WwNdJgKfW2k7PCdeziFugNavoXpQWwF3MLJzEbbh8uFN2vZ3LwSPY
OH2xKQXSiVLAXVXiFmk+sbs2yaxHiy04hDrNgnzqnNnnJgELHmJalX3kQC1AqoNx
I/Y8747o3hBXVH1LjQRZ9pa24AxmeiIMdmnRAMYsR3j/AF9x+oIoGwjUPt1E+TCu
9ER5Aw7PfRIrfJB3aM1tyeQXCFooMwei/wmunyas5j4Bl+a9m18D7b1yM26+Q7f8
CGfkDrp0+dpu1RcjtI/PvxqJJNCchs8Qj7XgTVQitazpVhMRcIbOfg8HnBwd+0dK
Mwzq0hCJx6/FRgTRC47k2pG1jxvXHg==
=t1+4
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

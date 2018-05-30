Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeE3LRt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:17:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbeE3LRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:17:20 -0400
Date: Wed, 30 May 2018 12:17:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: Applied "regulator: bd71837: BD71837 PMIC regulator driver" to
 the regulator tree
Message-ID: <20180530111714.GJ6920@sirena.org.uk>
References: <72e644d9855621ea8cfd7ec555e2da02403f21f6.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <E1fNysa-0006jU-41@debutante>
 <20180530111425.GD13528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline
In-Reply-To: <20180530111425.GD13528@localhost.localdomain>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 02:14:25PM +0300, Matti Vaittinen wrote:

> Does this mean this single patch was applied? I am sorry if I did not
> follow correct policy/way of informing the dependencies - but there is a
> dependency. The patch 1/6 contains the header file
> include/linux/mfd/bd71837.h with bunch of definitions this patch is
> requiring.

Your driver won't actually get built until the MFD parts end up in the
same tree since the regulator driver depends on the MFD so there's no
problem, the code will just sit there and not cause any problems.

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOiDoACgkQJNaLcl1U
h9C0Uwf9FffLG3KwDPEbrDy2gWR4EXdFCpKw9k3uQal6TZNRpKxPZ1m10XDfpCKv
f80INeTZW0mnU7TPsFhnWs4czsdpUL4M5DZHVC8X7MDTlTE2TsbJ9mGjPiziFrpN
6dCebSH14VVIH0/BVoqOzI1L+pCbVXBe5OQo69o1Gu2gTWj8s1GPYQ3yl/g1Wa9d
daw6eG0sNVGhmu54HuLW1dxtDC97ENuLAdt8+bG2cWC1UljH+1S1zTQzXtiQsP8f
ePg8xwhqeP6z7cssLUMl5uCAi3kdhectNgR3nx/ILrCDNUA9YcwmE82/zi1JmHVX
IQUJc2UpuVVJ4mgDfZw0gd7jHLYJ0A==
=Yxz3
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--

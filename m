Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeECXQ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:16:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:16:25 -0400
Date: Fri, 4 May 2018 08:16:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
Message-ID: <20180503231604.GD13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20180503213645.20694-4-yixun.lan@amlogic.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
> From: Sunny Luo <sunny.luo@amlogic.com>
>=20
> The SPICC controller in Meson-AXG SoC is capable of using
> a linear clock divider to reach a much fine tuned range of clocks,
> while the old controller only use a power of two clock divider,
> result at a more coarse clock range.
>=20
> Also convert the clock registeration into Common Clock Framework.

This would be better split into two patches - one adding the new linear
clock divider and the other one doing the CCF conversion.  Splitting
things out like that makes them much easier to review as each change is
only doing one thing.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrmDQACgkQJNaLcl1U
h9CV8wf/c7YMCGTuS+T4MV8e2xZibjN4BIJGs2dGOW9o4vu/Mehk82SJ0h2gbNFu
UhlnojgCn3fw5hCx7B3TaV6pkOnTD2T840zqLFiSIfXuhknlT537boO4xxn/pRwA
AY/wPmS093AixMpFGcbtS385tNpU6S+UIR0oXOGPZ+tm4S+ghvr8lVCRWaKKmeoc
spDwkXVuAHDPftg1O7uBa7ieZ/4Kg5ksQvXBL0Hp8OshAYJIZlpfz6zhrioqHzmo
bbOdAdR8vflr8GUGv5f1NpCoKPOVoaOc9+B4UcXUYYQfxLKjVLJZJqtCiwEADZAs
drP1ih0KRGzM9WClDdbvmH/ceNm7Hw==
=iR+3
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

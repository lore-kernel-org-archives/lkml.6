Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeE3Plk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:41:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeE3Pli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:41:38 -0400
Date: Wed, 30 May 2018 16:41:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180530154133.GP6920@sirena.org.uk>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180530090512.GC13528@localhost.localdomain>
 <20180530110000.GI6920@sirena.org.uk>
 <20180530125634.GE13528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Content-Disposition: inline
In-Reply-To: <20180530125634.GE13528@localhost.localdomain>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 03:56:34PM +0300, Matti Vaittinen wrote:
> On Wed, May 30, 2018 at 12:00:00PM +0100, Mark Brown wrote:

> > The tradeoff with forced PWM mode is that the quality of regulation will
> > be a lot better, especially if the load changes suddenly (as things like
> > CPUs often do).  Most hardware that's at all current is able respond to
> > changes in load and switch modes automatically when it's appropriate,
> > except possibly in some very low power modes.

> Yes. The mode switching is automatic. But there is this control bit for
> disabling automatic mode switching and forcing the PWM. Problem with
> these 4 last bucks is just that if regulator is in PFM (and it may be
> if not forced to PWM - due to this automatic switching) then the voltage
> change is not behaving well.

That sounds like the mode switching just isn't very good and needs a bit
of help so forcing the mode is probably going to do the right thing.

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOxiwACgkQJNaLcl1U
h9DYswf9GhespdXdjovv3j9DD9wgImmLpLB7cFVie8Mls+Q5qYCisULfQ8RnqKuo
XWBvT3Y/MUHvihjjZ+bDmuz9o2UvikmotCTROd/OE5Rn9E32iOn2F7MIKKjoJcbk
Gs8VlJBTzjmCqbBRGGE7R/28X2onqeqzJl0ARtC/UB1qd4nw0L5OKy+IrYWmlkEY
XTSX3H5Kgbs/71gGClNJ5ZPc4R0vwperFsKmJ3xQxEmgbgUb42ficiaYQqW7WrLH
5rmN+7az3K+XJyN8zPQ8g00ABAwJm3RlLN3i0ZqKoSOazLn4pJhmtcbdatDrRY9g
14agyXOkxwqNkVxTe1u2g8C3J/LpDQ==
=95b5
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--

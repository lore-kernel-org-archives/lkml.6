Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDSNmv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:42:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35989 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbeDSNmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:42:23 -0400
Date: Thu, 19 Apr 2018 15:42:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: sunxi-ng: replace lib-y with obj-y
Message-ID: <20180419134221.ufsc462fw7j7so6q@flea>
References: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
 <152409404578.51482.16644171573677016161@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="itrnzyqajswcthfu"
Content-Disposition: inline
In-Reply-To: <152409404578.51482.16644171573677016161@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itrnzyqajswcthfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 04:27:25PM -0700, Stephen Boyd wrote:
> Quoting Masahiro Yamada (2018-04-18 04:52:31)
> > We had commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a
> > library") and commit 799c43415442 ("kbuild: thin archives make default
> > for all archs") in the same development cycle, from different trees.
> >=20
> > With migration to the thin archive, the entire drivers/clk/sunxi-ng/lib=
=2Ea
> > is linked to the vmlinux.  This does not break build, but we do not get
> > any size saving.
> >=20
> > However, we do not need to go back to the individual Kconfig options.
> > The default configuration pulls in all (or most) of the CCU parts anywa=
y.
> > Also, once we enable CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, we can simply
> > list all files with obj-y, and the linker will drop all unused functions
> > by itself.
> >=20
> > After the long discussion [1], people there agreed to fix this, but
> > nobody sent a patch after all.  I am doing it now.
> >=20
> > I lifted up CONFIG_SUNXI_CCU to drivers/clk/Makefile because everything
> > in drivers/clk/sunxi-ng/ depends on SUNXI_CCU.
> >=20
> > [1] https://patchwork.kernel.org/patch/9796521/
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>=20
> Thanks for remembering to take care of this. I forgot about it all.
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>
>=20
> Or I can pick this up directly. Let me know.

We'll probably have our usual round of patches that might generate
some conflicts on the Makefile. I've picked it up with your A-b, and
will send you a PR with it, as usual.

Thanks !
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--itrnzyqajswcthfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrYnLwACgkQ0rTAlCFN
r3QKMRAAhWMtTHozTEcgveboPc1vDRrzjyW3FIsD/XLqE2y13uOUbfYTvilRIcc6
goBQLZLJNw6335iR2RuBtqQ3PXUcCx0VaasAQ1aKBZHNHXV9QDX9+6stcfSHIyuI
/Oyj5Ua5J8BZY666oDE7CRqQ13kS5YLv2G8+A2/hq3XULHsaEdDtCchnaKlzuYYK
YPCtqbg0uufYw1mfCvloqLnjTevnJ1LLb/fftBjCSswfnaFXL7J2hU6dDG6FZBXu
MeeM2E/mSvu8e1At/LLirExCKQDuFLp50SsqvXKYpXvLrZmtiOmwHmGXJu9et+Eb
fDN5IRlDSxfCoCvQ8bbptjPAgqAVnlYpxI8dRFBx5s0RSCHsfdkt+LDZpOBnGZlU
JKSH66Z561eAJh+vV31Ro9b4Fc2ifYKjuRxwq3BDWLTCeuxQP8/4jzdW3TXCwKFE
bMBW178vOWhjwliCRTmrPVNAslm/fTJvGnr4WA3sUNxo5SUhhJ7zstibEKs07v3S
NlrfvZVmgPGnAAvBCAt/jvspzTMoOruQXr9qrrf74kVP6Cw7mcr81VpFjoiOlRgT
Au5FT1Gjp0G7pIBOjsxZkyfuAG9aADhz9uiFhKtGyKvYiSMIqdEgESr8TkixLwoR
pQTrji6cnE8QBAKfwIPAok8Hji+dNMxR2SCJS1Ym6e0RGHnRpKc=
=ywQA
-----END PGP SIGNATURE-----

--itrnzyqajswcthfu--

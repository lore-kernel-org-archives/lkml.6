Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934105AbeBMKa3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:30:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48230 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933849AbeBMKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:30:25 -0500
Date: Tue, 13 Feb 2018 11:30:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Emmanuel Vadot <manu@bidouilliste.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Revert "ARM: dts: sunxi: Add regulators for Sinovoip
 BPI-M2"
Message-ID: <20180213103013.37q3pg6cedxur4qp@flea.lan>
References: <20180203112353.13497-1-icenowy@aosc.io>
 <20180205095558.2e713c24cdb7c3232943db52@bidouilliste.com>
 <207CD143-6535-42C9-BEF3-9D2614336482@aosc.io>
 <c59ee4bd3246172ec62705967bb8f751@megadrive.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2xxceggx65qjt7l"
Content-Disposition: inline
In-Reply-To: <c59ee4bd3246172ec62705967bb8f751@megadrive.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2xxceggx65qjt7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 10:20:57PM +0100, Emmanuel Vadot wrote:
> > P.S. a proper device tree with AXP shouldn't use
> > reg_vcc3v0/3v3/1v8/etc. They're dummy
> > regulator nodes for
> > not implemented or not controllable regulators.
> >=20
> > >=20
> > > > This indicates that this patch should be not tested at all.
> > >=20
> > > This have indeed not been tested with linux.
> > > I think that this commit should not be reverted, I'll send a proper
> > > patch tonight or tomorow night max.
> >=20
> > Please test patches sent to Linux on Linux :-)
>=20
>  If my patches adhere to the bindings I don't see why.

Adhering to a binding and being functional is a completely different
story.

And the latter is the most important.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--l2xxceggx65qjt7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqCvjUACgkQ0rTAlCFN
r3QPFA/9EwFyLoY4+ks0VnxdLjJ8BGmrVcNhGFgv4aG+JzsAKIg+qnln9X/sN98D
ZnqaEmOJ84OKyh+NvkZ1vUEU64wVU+oy8Dgovw3St8iAXwR4zkCZq9eEiBKHuqF9
ERWjTk/Yn+HaFrxn8zpEVtqBo7fjGiYsaT2pxz2gB2+zTVyXNDUcI2no4o5UzERn
/WI15mpEnvT2Wm8/BBiRE9WzLyjMnFoB2wKSsQz+9aWaMQfmFzhagEuGsMOU83Ke
cJbke8GqyET3ih0AGWzG/vuxy8KOK6vfFTZeGv/B+8W+uxKeLKUnzU0p89GBSNIt
tTNm4SqdjKGpb/xwLq1TlvK3sUSK0h9Z8qeFQsL2g781c50M+e7x5I3BHa5Ejn90
miiYFbqD9GYwMqFlCA2at9P2SjXbYjYkkD7XIcoHaeYvbW36jv+tJMpshDon7ULh
kpLWp3ksH3z82/neg9FqnVCaVeRpAc1Solo4+0KmySn5e9y89bkrgDyCdE1e3pi8
+e7qU55u5RYzFC5tmBS3zFid1vB1ZzIcwGPIBp4tooVyXGu8Dl4nXOtyJWEbPBDA
2OH/jwmBfqMzGKU8wz0z++0GnRguptvf/fS6NOFL4QCoI1clnRmDFovwAuTCTQOF
l2dpCMxw86TMP6E2huAsMljLyRClmOLiqAm/sOizDDuADBBeQSQ=
=exSS
-----END PGP SIGNATURE-----

--l2xxceggx65qjt7l--

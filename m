Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeBSRNu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:13:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbeBSRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:13:48 -0500
Date: Mon, 19 Feb 2018 17:13:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "pombredanne@nexb.com" <pombredanne@nexb.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Message-ID: <20180219171343.GL32761@sirena.org.uk>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
 <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
 <20180216121445.GH5886@sirena.org.uk>
 <1518784101.9517.21.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <1518784101.9517.21.camel@nxp.com>
X-Cookie: You enjoy the company of other people.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 12:28:21PM +0000, Daniel Baluta wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Are you willing to take patches fixing the SPDX identifier for the rest o=
f the codecs in sounc/soc/codecs?
>=20
> I've got a bunch of students looking for cleanup patches in their applica=
tion for Google Summer of Code :).

I guess, though as I keep saying what would be really useful would be
some tooling and automation around this - having to try to keep this
stuff in line manually is very noisy and especially given the divergence
=66rom well established mechanisms for doing things it's not surprising
that people aren't just naturally doing it.

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqLBcYACgkQJNaLcl1U
h9C2mwf+NNSESu9H8d0e54P0xVjSY6zoMiu4LMy6NeQBRyINvqlcMstsgD5zGMJ/
26woAzDIKedrbFvZonHG2tI3L06n4dMqW67+BpDnJOZObgEDBNn/0U5ffk5uT59C
IlKHwDuE6JiqveRAXW2m0W0/h/+wnr+ZElUtNxp+y4V0z/PjI2gbfcCVkSWkexmJ
n1TkUOAcRCswFfQ18o019LzJeEyLNFaUNswy5VMovZSmDrleNpikvgYQbz2SHwB+
V3QrP3gnNfIakbAVHfbqrWVEfBGTs5GmDCnygznyJUQmLBlxrcmjp45PYuJEyGLi
UEF+qq7HI9nQUJLVUxZqe+EaXARvug==
=MoIh
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--

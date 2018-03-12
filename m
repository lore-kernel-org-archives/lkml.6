Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeCLIv0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:51:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41947 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:51:24 -0400
X-Google-Smtp-Source: AG47ELvUe4OeAdiCyBHwK+E6MaFi+5KzBp1r2nF3LxBIyjnK/gWJx/CUCeTrWsfnN6Xj2Intt+lOrw==
Date: Mon, 12 Mar 2018 09:51:20 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 4/7] drm/panel: simple: Add support for KEO
 TX31D200VM0BAA
Message-ID: <20180312085120.GI23060@ulmo>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
 <1517766571-409-5-git-send-email-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <1517766571-409-5-git-send-email-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2018 at 11:19:28PM +0530, Jagan Teki wrote:
> This adds support for the Kaohsiung Opto-Electronics.,
> TX31D200VM0BAA 12.3" HSXGA LVDS panel, which can be
> supported by the simple panel driver.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v3:
> - collect Rob reiew tag=20
> Changes for v2:
> - Updated binding info about optional properties, node and example
>=20
>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 ++++++++++++++++=
++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++=
++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/koe,t=
x31d200vm0baa.txt

The koe vendor prefix is undocumented, please send a patch to add it to
Documentation/devicetree/bindings/vendor-prefixes.txt.

Thierry

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmP4gACgkQ3SOs138+
s6GLcBAAhNvdehaUZ21MnpGeyuwXRUkis+3CuWKTZG+yE5Ou7dng/5qQp23l32Fz
G5sMPkjhp8IHAwoR9Lx/VX7sBF82X4nobVL04nNjwbmPFYYrqgwMu20MrorgHcOs
cjOBBa4lw5ilTzxbcU3rq0hzLM0TQseQXirAsx6Gc7X7WmjGupD5eaiVbR7w+0aT
ZvNKgUkOFsP9wXIKlYd4CycRIlTmv3bD1f23FGM5KVHS7zH2mG1SfEcCt1hxPpIJ
5RUdcgfroiuE+Mceu8HWmwynDDiaDDn+sDZ0qqh1sNYuuD98mMU2RDf0WBNwOtdb
X5Dnz7DW4C8N5528xe08WJhgsQM6ez2j/qqCXsWF2MW/9+8srkikOXZygyFOatLc
fESPDZnHRyeUvjMxvAyu3jFeuxYCfTYquhV1ZGzLPnxbzrJ32VERJp7DZYhIhSfO
Gqm7zeo99YYe5IN1z/16DqK/F9vBcg2gNA7lHg+V7+IwfS6I1SVIqisGu4E+sLqU
ZI/RG/Bfoqm4QR597wF3Otb3rkJnc1zQKLdmZYqf8skXlyS/1Bn69LkqNheERWVw
wLbh1OcROWUSeDHdtOzPOuotPZNoS4Ku6WgSFvLL/J3dOJRRGuZPl6fGubX5c4br
yyAUScOV1FWuarKsz/uyC46zhP5QydKIYR7cAzm60KzWqdglIsc=
=kLks
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

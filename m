Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEDPWM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:22:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36169 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEDPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:22:10 -0400
X-Google-Smtp-Source: AB8JxZouVEvPsrnbynyjqKhZJHTYFE9OXzInYgNiTW7NhxX8gXG/IKzyLmhnRfgnV9Aw+dkROn3y/Q==
Date: Fri, 4 May 2018 17:22:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] ARM: dts: tegra30: Add IOMMU nodes to Host1x and
 its clients
Message-ID: <20180504152207.GE31229@ulmo>
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20180503234723.4368-5-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:47:22AM +0300, Dmitry Osipenko wrote:
> Enable IOMMU support for Host1x and its clients.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

Thierry

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsep8ACgkQ3SOs138+
s6FsPA/7BWtQv2bOp5sC7SAl2Tf89MwXJ5tvcaM9sW49qsuF3vLs+ByXtI2O6p/i
/E7kO1GS2suYJlffo9fu8I2ehqPPWjj2AdlxLU7siRhCQWnHdMX4LOe9IGKCSSQs
A/6tipdyvN4qW5puD3zpunnWeVPeKfnjSP1tPOlHNkjDpo3ZUNzn7K3awu0X4NHG
3cc5vP+D0aXddZBPvk/mD4RgVVtN98jastN4lg6+1vo6FaSEgoFzra/VOxi+7Lvl
ZamGK/qHzL40dQTUhokhrjdPkWCiBXGnQw5Je7nLWpKIBrLC/CjlfbGnJ77JEoL2
rwK+l+lPVZBaGau/suu1RwSYjTO0Y/1d8QopFRKP4Em3VF4LPMKSJGJ6B/r8M6Xj
KODVPwfOSvJEfyFYFEYx9kIHKWdMKKls/HnMpyDg65VkIgZmgqT2Jmgh0cXCw2Ij
bGa0sN09CVtZMtANK1pN13VSxHYIEDSC8eCjiqep6VBATtYvBKC5ZlkF7ntMSya2
R0qtQ4Tcl/LiANRN7UuOVFFofSB7WiEj9Lm5W+u/JhaLWU0EDLmV+8O3G3686LEj
kaOuYG+3ZLxie3UvnL98T/r2euQm2A7dHyiIPVVHD6fdHjQLNkgpZ9naibNn2UQp
OYzB7isdvAxb+TVX54NgkORzEhdnoemyDql5/T+ML0AjYCL9+mQ=
=nu25
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

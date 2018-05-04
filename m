Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEDMU3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:20:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45082 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeEDMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:20:27 -0400
X-Google-Smtp-Source: AB8JxZo+eA0r7xb4w0n/QikUtMvPUcUDTpXpMF1y4BzMyTPlP6LWZRL6gKUIMXmA9T+8BYgoUuy2rA==
Date: Fri, 4 May 2018 14:20:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] drm/tegra: gr2d: Add IOMMU support
Message-ID: <20180504122024.GV13459@ulmo>
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/LSm8UPTCLHL4o89"
Content-Disposition: inline
In-Reply-To: <20180503234723.4368-3-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/LSm8UPTCLHL4o89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:47:20AM +0300, Dmitry Osipenko wrote:
> Attach GR2D to the display IOMMU group in order to provide GR2D access
> to BO's IOVA.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gr2d.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--/LSm8UPTCLHL4o89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsUAgACgkQ3SOs138+
s6HzGw//YGw66PoLeB08vm3K5BWO4wvzi3QDmlazgEY0iGpEF2AgeweJYldbPq1h
BBhjGuh+mJTl5QHuyfOiKIBETWZkv00bKpITC9bT2pCwkco/AYcGQ1Jtr3sWTmW4
JtneKt0CtbMIsaioSpYLgoIC2vHJQCc5/Bg3hYjKpNBGVe+xCnuJnTLZxEEVG/RZ
Yu+2Hv1TfILqhteTdE3+hQkbgYxV81Z6xcjSNROKjmrr5f9kmjn4A1xWbcOScf54
QXazH1kJo0YVDkq2/pPn5tHRfc8mH9RVeer9sNqma9tlsXzXAVPwYSAug8Kg/mbi
QdSFrlyupA95ivWBk2dmo1h9hNcUxWC/6HuTs4ttmOmpqMBiYJFSGl5n+JVTnWnz
tnJgvCGuYJ4BixOXwofaWB376Y9sUklckipLNSyYbpYLXv/8SUD6nieD4UtKAH6h
JGMo1KYZUaGSz5LHfNoPqNcyarpxSoVRnoN8yDWzqVVcOyNXyTKt3Ka0e4xgo84j
JUwfEUENyisUmowjXAOD1bmz57eK6604S3dA920MXJgWVWkBG9JZP0efB8OeRzlz
oShCqyx4e0vAjXQZmamdwBWyvX3HDT6a6YpHOvcL2v3Ee20ctaVAkcpfHEfag9Q7
KLPGULCQxkRdA3LATwhHzB1Wgs+lfYU15IkTmDni+E6tCc0+kXk=
=gVyr
-----END PGP SIGNATURE-----

--/LSm8UPTCLHL4o89--

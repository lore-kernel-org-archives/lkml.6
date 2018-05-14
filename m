Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENIpP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:45:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44989 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:45:13 -0400
X-Google-Smtp-Source: AB8JxZrA7QS1fkPfUbqs1A+cHT51629qmxY5mNKsl5IKJ+4z18vFxrmETgJNlmj1z7ilp9uYqmn4vA==
Date: Mon, 14 May 2018 10:45:10 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Fix dma_free_wc() argument in the error
 path
Message-ID: <20180514084510.GB18312@ulmo>
References: <20180423095456.16697-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20180423095456.16697-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 12:54:56PM +0300, Dmitry Osipenko wrote:
> If IOVA allocation or IOMMU mapping fails, dma_free_wc() is invoked with
> size=3D0 because of a typo, that triggers "kernel BUG at mm/vmalloc.c:124=
!".
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/cdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5TJYACgkQ3SOs138+
s6HREg/6AvZhQov2KIbIWwTeMX0QdWhqCVvoOWpMfpwIKC6MxZXHQj7RV0RMdG1J
ennhaAkaIDhHrkjYTU7AnZBbv8rtQB5pNLaKHg/JofU3ctgA7z3tpNhVYXoyuNeR
W9n1aBVUrl7b+NECAU3z+JKPKrUa1Reh1d7k05c1Ve+tAEMtatY3/xflZfNXqDJd
ajcGDlqo/dFRQ2aqs2f7Vu3FcB/HHkFW/nijKaXnk1DPIJY0EoxTFkvSFE2nO2kn
oV2vHBe9pCMCMYQKBKizuBy/e35ISLA4E9MN87Fz3O+hf5zANAN9N1Vr+xSbLJuj
Y3ojKW9GltmFsOkNh/rDM9F0Vb3+ss8ptMmBEVqoQ5yEtO+4p11TbEHHrV6tMgpR
ReYAGdm34+nX0t8IVr1gwppuU/n9ZBmMigfxCWpJCp1s8bV60xYe5LDj3YI891C4
83Q9q/VilwSDdjBz4InN3juqJMvZgFnibWjNkn5BeWFQVymr8wq51SU9WCKtINWq
4JFKrAoF5TCaqN+XhMy9zC0C5rcjEJEgL2Y3Gp6MrwR/uBwXMT/9hcTgycLRplLG
Eekf4GuCsEchBBVBowBgmCS9uU+5I6LR++ttoh86ObztPms4cXc+BdGUDI0f3zEo
Aoe04Nbx75MGZeQI+8lk0IFZIKVGWcKXeM0WOFMT9XDJ2yHLsts=
=eBwA
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDPRI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:17:08 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39778 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:17:06 -0400
X-Google-Smtp-Source: AB8JxZqMqdW+AM7dko2BJTyDUWxKfvEcr0p13zHiu5pdS3Ylyz3O92DgrvvpPYepYjmPd1bB+p4kTg==
Date: Fri, 4 May 2018 17:17:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Couple more DRM plane features for Tegra
Message-ID: <20180504151703.GC31229@ulmo>
References: <20180504144000.8597-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20180504144000.8597-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 05:39:57PM +0300, Dmitry Osipenko wrote:
> Hi,
>=20
> This series improves DRM plane support by supporting zPos on older Tegra's
> and enabling plane scaling filters (up to Tegra210).
>=20
> Changelog:
>=20
> v2:
> 	- Addressed v1 review comments.
>=20
> Dmitry Osipenko (3):
>   drm/tegra: dc: Enable plane scaling filters
>   drm/tegra: plane: Implement zPos plane property for older Tegra's
>   drm/tegra: dc: Rename supports_blending to has_legacy_blending

All three patches applied, thanks.

Thierry

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrseW8ACgkQ3SOs138+
s6ES9hAAlid8YD5fWzqI2uBb4wrJaDFbNfeXR4yMDvUnYaks4bJ5I1/1OGJQnwRB
4O4uIDBHWXWhPt/iwcjgESmzkO9ma/pezpAw5220pEHSA8taHFxxnYhkR5VVGvBm
rFkRSwyKImYP3WP03E2/r7S25mjEBerWhbVeStGtOqk/KMgwUrPAWYSwKWV3gxo9
MVujAyvSREo1QcAysWiDse6pE0eUiM4TTZwGVVGIOyoCsZPtfirnWVmHDnLQ1ezo
Launis3VXV0Pmy2yUWjHB/don4snqNy6FYyN4iNk+a+CXkSLnt1t3uNu8fs7N+Or
97DrF55zUvKQobQTll7ttCR3sEQKOIqGW/6aZIInUcqJNoOKNpi1ThAgWh57u2gV
Co3FgTVHxBV0infzDczZgm8BxqVc8ZrK0xENxvYNquvRFcxPMliwu8ic/GdtTnMW
82x+opGBHmcYQCTgxUM0kIUB5qBS+4WsZbmjI/yxK3RAbQi4cyqkwb6Y/F2B4BKw
2Qk0z70LTq1z1tIeVCJ5qqN6QcpMQmURFsDNTiajbo08CnCO+gAYuOfvxZbOF9R1
87P0QUVLsp+uiy8n06LtwBvsAXQmTPUB2RAqkVzArmfwFnBRnlrEup2x7uFjCglJ
3FdmwuXXMlL//FfZUe8MOtczT1iwvRjfdtAHplHG1gFxL//c/9Y=
=nCtU
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

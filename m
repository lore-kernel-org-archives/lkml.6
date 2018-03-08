Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935220AbeCHOAR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:00:17 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:44886 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933418AbeCHOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:00:15 -0500
X-Google-Smtp-Source: AG47ELt/6rmUDSdrGrl3D59UndHIll7NadxADVMUl9eTUpw6DMWmBbxc8TA0cD5fjOD5VWvmtInY1A==
Date: Thu, 8 Mar 2018 15:00:10 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Enable Video Decoder on Tegra30
Message-ID: <20180308140010.GG3529@ulmo>
References: <cover.1518981147.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <cover.1518981147.git.digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2018 at 10:46:54PM +0300, Dmitry Osipenko wrote:
> VDE on Terga30 is compatible with VDE on Tegra20, hence the 'tegra-vde'
> driver works fine on Terga30. Let's add missing DT nodes to expose Video
> Decoder Engine on Terga30.
>=20
> Changelog:
>=20
> V2:
> 	1) Appended unit address to the name of VDE pool node to fix
> 	   DTC warning as per Andreas's F=C3=A4rber suggestion.
>=20
> 	2) Correctly placed IRAM DT node in the address-ascending order.
>=20
> Dmitry Osipenko (2):
>   ARM: dts: tegra30: Add IRAM node
>   ARM: dts: tegra30: Add video decoder node
>=20
>  arch/arm/boot/dts/tegra30.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Applied, thanks.

Thierry

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhQegACgkQ3SOs138+
s6Eieg/9Gpvvz1j/xzTU0oaLBptJXo4AugnotE3G1W7Qgn4XtheFguWwKX/Z0KYd
s8roltZ+g+t3Wn8cOjIAS2ygIbRkWeFTs24mKnE0YergJQlHNvo+dEZ2FA785Br2
8+AxJs80zjk8aTeR1XTT/9IXvOWXVcU8lrnb4zokK/21s/Z5/fehsE/UuX/oPuDh
HRBeygNVFfiz3kbj0QUn88qjVUJt6uSHSfz+DH8T7TvfMXxIeNJkt4WF+CcoZs8G
ULpyVb0vism3INR2urVhvw+5XfUL89f5it3z+dnj9cJ4Jr/ZisFRlJXzQfAj2PG8
sC7uL3SV629DkswpSgj7VBfZnZFuospEdy/3v0eajDyZ/LPFCh6IgJCJDbbNJOdp
gRoy2683QnHeyqKS/OIxe6uwpplzUYfQ3PG+8sVu4+6YnrVmdBopxnZdsMETVTFk
S6vAqirePqRNuwMqQjShtmfXbAbvFyIByfnmkcwL4F9p6DUXVfx6np//P+P9UCtu
KpSoYhhWmbl2xgxYHRKFPg1hBZRNkfQ2e2GzfxIq0KeEZqvwvP2VKGOkGR80Gmt/
YeFAijO/8F1PdnIvWCCf+W7tuZ/ECp/lKElFq12bzNSvI9nMYb0qVaqrALt5XuqK
mAXEflyWLKmx/9us1F3Ts5w96q1Wc2nebvbo+00h3smqAKycKYU=
=vM3O
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

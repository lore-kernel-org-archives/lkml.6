Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeD3IJU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:09:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44884 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbeD3IJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:09:17 -0400
X-Google-Smtp-Source: AB8JxZqkkucoqw0aECPIPE6pIl/zs7QLIv6z7SwFastv9sywfzWuWAF5bqen1ES6nMwUjGJgSewPgw==
Date: Mon, 30 Apr 2018 10:09:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/15] memory: tegra: Add Tegra30 memory controller
 hot resets
Message-ID: <20180430080914.GF2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <a07f9ab772b486e411bd397da2c9f6f01f3b6227.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <a07f9ab772b486e411bd397da2c9f6f01f3b6227.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 02:33:53PM +0300, Dmitry Osipenko wrote:
> Define the table of memory controller hot resets for Tegra30.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra30.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied, thanks.

Thierry

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzykACgkQ3SOs138+
s6HhmA//ZBt3IztMixkRUwbDiKepNEYIbSHQdVo9MZjlTWlZnODYAhRBkciFW/eR
Hv9W+Lf8QsT9nmdkkIJpYWZbGUa/Y7DScdrb/fmyzSDoKP+7iTxcEuZcokER/J/i
acvEiOcZe4uPOFzQW3ZgHp53tUTbxM8aglQwwEXFJQl2Senbpkdshse408uCa4Jl
IWxLGgVIOj5r6OP9UFBbX2EkFv40EnXGKq72LtIB0oiUpb9ooguzYiFFq2uSS63Q
M2jRtdl/CXu9RglsudlcgRlJYKCJuuk3dsbAg+uueqaQwh76EyZ9Vys3Pk71aI9Y
jK6/ChFFxrDsaCee9v4l2eheD8rs4kXGx2cxxQo3vzIsNLIppi6i3pjN4IQATQ6j
2d72qqwgKwaPKcv1ptNVBG4TB1RolPN5knw26LkGc6tDIgX3wa3DavyTvVIixtV3
/ai1VW4LRBCMGUvVgKIU1DqTBUkgWWYH2DziZGE5ZflSOSN6DC7jV326yvcOpopw
w58XOm7fPghsuBe7lPziq9QmiBYaeqQm+iVB8rsw45QkFp2Fu3mmXkvFEMaG3ScP
ozu1jSyTxiPTFvrddcbFbEK7w3hIaedQPm7jjw+8a0na8HXtFTJt0aD+EQXMr9Zv
YW2hnNakaRu00BpvCWySUG46ky76AsSV81eU8lqDfFG1/HEMhTQ=
=7UAp
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

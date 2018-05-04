Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEDMQO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:16:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38714 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEDMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:16:12 -0400
X-Google-Smtp-Source: AB8JxZpiUnnp9P1YIfKxjMUc5tWv1F886LLNEMaM3fBdm8cNt9h99T3dyth8QoCrAwdXKq8OhVldeQ==
Date: Fri, 4 May 2018 14:16:09 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] drm/tegra: dc: Rename supports_blending to
 has_legacy_blending
Message-ID: <20180504121609.GT13459@ulmo>
References: <20180504000844.18661-1-digetx@gmail.com>
 <20180504000844.18661-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jZNlLGxhPb4urluq"
Content-Disposition: inline
In-Reply-To: <20180504000844.18661-4-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZNlLGxhPb4urluq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:08:44AM +0300, Dmitry Osipenko wrote:
> Older Tegra's support blending. Rename SoC info entry supports_blending
> to has_legacy_blending to eliminate confusion.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 20 ++++++++++----------
>  drivers/gpu/drm/tegra/dc.h |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)

Looks good to me.

Thierry

--jZNlLGxhPb4urluq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsTwgACgkQ3SOs138+
s6HR5A/+JmNuN32atKzA6N6awXY1rRzfZyTL6Cg3NfHiBmboLwv1g6VIJt1fd6Yl
vZwFE8UDfoZWMkCDZokedEBwzzUB2Ojue841FH8NBnwDk6A6IRhiVqBzJk3S0Kp3
VDkInGVkRYT5H/Uxn4VXRA7NHVsPHMEAgxIgnT+1XwMXxqtXB37t4+TmEjV2Ox7N
z5qla4QMFDi9cDAhFSFwp3T9TCe6Puc6vo9ktor33OIjOHmB27rpxfyHlGoWcVg4
SyN1H+ibRqCncGIYJwGQq+SvHLig4pnAoAcmrDhwtaU1proN4wDDJeUD6VnZbT6n
5jBfHDpTXaOdU4G7a3Msduk84DNTFxEli/IanNN8gfL0kwi1BppKBE24c9pAUm9u
GUdgzzXzdZ38qU0cxxQ6o2rts635GY1tNFRmpL7ReqdZQG8i4RM11GhCZ0IhxYpa
cnWM6z1jsGJhyp89xlRLai8Mkk++eFf4K5x9bJ9KaEHuhwJZJEQCP3n1KkvdkBmn
iIY2p447ZxsZm2uXtSlfwRVzo+TaDo/tFt4PFJtdRr3IldjADD3X32f4e1OYrYAR
Mf6PpDrOWZXLcpwMyqqrqYPIfwEBMnoCcvVsTa/f1jZv2J9chg5uJfvSiMXeFFOp
nP/cx0njeUsvh4nnVylghEm8q5Ki+ZbfFOzO0IcI66QedRIbHL4=
=tSAC
-----END PGP SIGNATURE-----

--jZNlLGxhPb4urluq--

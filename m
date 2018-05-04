Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEDK46 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:56:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37809 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:56:56 -0400
X-Google-Smtp-Source: AB8JxZpdPIY55ze9emY8BKDWTcbnDCC/fjxzJby4illRJw3wLPFA5y6LvnzCtvcVVbvvPmEyF/TPkA==
Date: Fri, 4 May 2018 12:56:53 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Support IOMMU for 2d/3d on Tegra30/114
Message-ID: <20180504105653.GO13459@ulmo>
References: <20180503234723.4368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjSZefE6w0iW6XmQ"
Content-Disposition: inline
In-Reply-To: <20180503234723.4368-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjSZefE6w0iW6XmQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:47:18AM +0300, Dmitry Osipenko wrote:
> Hi,
>=20
> This series enables IOMMU support for 2d/3d HW on Tegra30/114, as a result
> userspace that uses 2d/3d could work with the active IOMMU.
>=20
> Dmitry Osipenko (5):
>   drm/tegra: dc: Balance IOMMU group refcounting
>   drm/tegra: gr2d: Add IOMMU support
>   drm/tegra: gr3d: Add IOMMU support
>   ARM: dts: tegra30: Add IOMMU nodes to Host1x and its clients
>   ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients
>=20
>  arch/arm/boot/dts/tegra114.dtsi |  5 +++++
>  arch/arm/boot/dts/tegra30.dtsi  | 14 +++++++++++++
>  drivers/gpu/drm/tegra/dc.c      | 35 ++++++++++++++++-----------------
>  drivers/gpu/drm/tegra/dc.h      |  2 +-
>  drivers/gpu/drm/tegra/drm.h     |  2 +-
>  drivers/gpu/drm/tegra/gr2d.c    | 31 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/tegra/gr3d.c    | 27 +++++++++++++++++++++++++
>  7 files changed, 94 insertions(+), 22 deletions(-)

Overall I think this is great. No need to resend for the two comments on
patch 1, I can fix those up when I apply if you have no objections.

Thierry

--qjSZefE6w0iW6XmQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsPHUACgkQ3SOs138+
s6FISg//WtO73vEpDpvs31Ck5tmeLUp3SGTHniGOlTq7rCtNeUxPDuSkfPOqbodq
cMWGv70PGCkoZS++9h/bery8LoEc7rw24OWIq6bqKiOZE0YSTX84u14DPeOdZARh
ihoiA/nKDmj/aYtsutMcCGMAclYxJgthwg1IbFU4fSa6LQo0lcVgEfwXGg1YePaU
mgib/M8x/q8CilgHrMDjEMz435YvrmfbIi5gyWrmPEsGkyznD+mrxi2Kp0lnqGUo
+Xj9MOzBWo3+7IhRXpnGvIrcGaq1mLXY3Dp0uMRoO0XKFbGBSx1/PuD0x/3QGnjE
G9KT5qawzoDTp3siW3P91ZbZz6rWNNPNMoJIz0P0bKVyCMSsgxoOCNF9P50FFWAu
dvJV4W519Ti2Vh6NyibnRo0MBzkJutudn87n9LTP8mn5zCHpbCbQxHLwjrox5QrX
OpR57o5jiWsMNMpcNkcs/0nNz6SQq4FyHLh2QnBPZ0589vvach6pK7kVJ8GQBDr5
3OrHqQLZETfScmWx+lJLzAAeW0I8vyq8FunUT5EZqwKKHsrZIod4Jms0srzB3Snv
+Iv5QXlf2f+Y7Su2Md7zRKilm0ULt/iX8bLiHroC17VxL/T3wna4CpWpTlIXPTrh
UlIx70Ta78vo75jijZB2GqyfrMAzA4I0bijj2CVUomTYMSmscX4=
=tsSs
-----END PGP SIGNATURE-----

--qjSZefE6w0iW6XmQ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBUWoz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:44:55 -0500
Received: from anholt.net ([50.246.234.109]:54264 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBUWoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:44:54 -0500
From: Eric Anholt <eric@anholt.net>
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: daniel.vetter@intel.com, gustavo@padovan.org, airlied@linux.ie,
        seanpaul@chromium.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 4/4] drm/pl111: Do not use deprecated drm_driver.{enable|disable)_vblank
In-Reply-To: <1518425574-32671-5-git-send-email-andr2000@gmail.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com> <1518425574-32671-5-git-send-email-andr2000@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 21 Feb 2018 14:44:51 -0800
Message-ID: <87lgfmt124.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Oleksandr Andrushchenko <andr2000@gmail.com> writes:

> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Do not use deprecated drm_driver.{enable|disable)_vblank callbacks,
> but use drm_simple_kms_helpe's pipe callbacks instead.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Eric Anholt <eric@anholt.net>

Just got back from vacation today and got a chance to try it.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqN9mMACgkQtdYpNtH8
nuh79xAAorzI/pCrkrRYal2XrI2hP2gY0GT3xEi2SXNQsFU2hXthCF0Yl0C3UdFj
0KpXUL0adzo9HruR933jnHn7UGRfcH1YTOgjJg1OeSeulBznh4SrYytHcSNeQ2Or
2oa8fSvjtZRm+bCiBWha3xnWpFAIPmvjkm25zbHCyInCg5QPKay+1Zp8kaM7eJys
fEAeDOG9To+uKwUr/vqUaVZDlYdSFdhV0tNLQyFeqVKN5AUIhxpfcM894/+ODHdu
5HeOnACcABX9kpKD5A+t5Blbe1lGrfscevD3tgBVQ7TFORriSJSVE4d4pzF1TgdR
39rczi7KwCmbxBGvDXJIC2XzhoamxIz648huzXw3VOn+NO1V9RXnjbo0vWLRT69X
mEEodbUHvza03sQ/wZi49FbFGyO+UO6gt8XXv6igOPhdi3ZpUgBDn/b3grMTYSHE
Oce+7A5ginBEXdgZYY6U44AKMty72KQnXVKzMclDijnMrV3mBoulVkgMZUpj6SV6
Sz7aF1E9pFSO6w3SZrQWaHvBIM0sLgbOiW6Gy/LWiCdx4F038Nm4XnXVNG5IzyjL
9IHv0y0vJXiVqH6l1vx4M0+0YTNSzT3Rj57KJ11e8OXxz+3xppfwNDLDLOCuFurY
aKjo7WXU7LpQIa7MpCaREHDOVpVNohB14PmfdAz9Ye3lhAu6230=
=Q9XH
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEBLDA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:03:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:02:40 -0400
Date: Wed, 2 May 2018 13:02:36 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add USBPD charger commands and
 struct definitions.
Message-ID: <20180502110236.bj7wp3ibavambvss@earth.universe>
References: <20180502095343.17092-1-enric.balletbo@collabora.com>
 <20180502095343.17092-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5evptcyfkthhkvqg"
Content-Disposition: inline
In-Reply-To: <20180502095343.17092-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5evptcyfkthhkvqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, May 02, 2018 at 11:53:41AM +0200, Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
>=20
> The USBPD charger driver gets information from the ChromeOS EC, this
> patch adds the USBPD charger definitions needed by this driver.
>=20
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

The second patch depends on this one, so I will need
an immutable branch.

-- Sebastian

--5evptcyfkthhkvqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrpmswACgkQ2O7X88g7
+pqt3A/+J4Bbu9TKCGDJ9Y4u88Q78R1zIRYi8HNf88UNJ4USD3bhD/sUQ4mnvs8B
HPjXmPqn0nuT8wLY3bWMn/QDyjvONQltgBETAjambXdqesaBl7EVyLWAnT1t8izv
kzB7bT2SWo1oikUu8r/1csYQzwY9qBz52luDJf0rxXOQEfN0L1SKbcU8zeEBfC0S
S74CpGKHen3IE1gaLih9/lxH8eqZd9aGcFMC3jfI9nMJdKOyiCe0LL35Z/L6IApB
Qu9KOkX7/rx4YOSQbQ02LathDYCuctGPva7o8ysJYyX+K+nPZF1LBkFCP31QMank
w7jQE5A0nq6afUT8WZhqGCLJceW6mehHvM+Qz8OUq7tdX9N/gBn5oUzfWvt6V0D2
QZ8DtT14QlYULDpUI8qMk+KLRq1o3szmzzU3wCsixi+TJ4+NL4DgXqeJDSgvpaU7
SWRDD9SYgZeTTu+pVFfWoLLBFN795J1xjldvj1TH3y5VXOdjrC6BEi45m68LMIdW
oWqvemkJ/j3U4aV5n/1Jh9DnmYeHCYbawflm0FomuBwEtHXit2gB/HSRchU4sn8H
e6GtbIt+0ui/hr2RUldSuMdWwzJn6QPkdDygMvBPvBo6jaAxo3s1pl6GhXaaOmZC
3+k8RDQMEznAaBBSCRix23y4JJl1zESrC1rGhsGn+17UsgZIIHU=
=7AxY
-----END PGP SIGNATURE-----

--5evptcyfkthhkvqg--

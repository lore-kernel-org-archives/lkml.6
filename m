Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBUIG6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:06:58 -0500
Received: from sauhun.de ([88.99.104.3]:43916 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeBUIGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:06:53 -0500
Date: Wed, 21 Feb 2018 09:06:50 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 07/16] i2c: demux: Use changeset helpers for clarity
Message-ID: <20180221080650.t5hshljcnfsxeget@ninjato>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-8-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="czmofhikde4js2ho"
Content-Disposition: inline
In-Reply-To: <20180220231046.32638-8-laurent.pinchart+renesas@ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czmofhikde4js2ho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 01:10:37AM +0200, Laurent Pinchart wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>=20
> The changeset helpers are easier to use, use them instead of
> using the static property.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

My ack still holds. Good luck pushing this series!


--czmofhikde4js2ho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqNKJYACgkQFA3kzBSg
KbaY9w/8DjlK+c4m1pGIjK9b+aJ57FGBmxbKpzTuuR1gW5zd0+WH5hFGRXorwWI6
mAXfPyTmWuTT4D27irtoLSt8y88REkyX55D63CmGqDrKKEMWAIHc0r2U+4F/uuHm
MRaow8tdfs84Xp/UBLBG0W4okGMfnU6h+9b6gfwMLx3eDk5GlLxqz9lsNEbn6BWE
GI+ZGPgvBf6T4jY62gDiqGEH2QqLcrV/HgJ/GXgcx0lHt6+rSsZD2f1QbAzYne6G
6vQVE44y273s0fMdQy5KAoxhXLG4pzQ3JI/ajlmetWXmEE3bm5XrcOVVzBS3zkiI
NE19TC15j26yKLr+3LkaNLKQDLbzlW2CKjXi6AlL5NDEZBw98y8QYlBXXS4idPC7
bn5+lfVtjnCQ4eEj/BYl8Vqexv4QyfsqFp86muex/hF70jrhtlIpCIlz1hAtUVVR
rNRXm8hhMRFOrqSZV6U0XNzpnP0/u8zWE/cB4L5hTFo3xXKAkKHPi74kxmuml1L0
j1b4ZHdCx9PvbSJQZSoPkQz0uGDywOvp5LejUBnjzq3B7uy025y0qG04nH+jO9AV
snUm68Du0bb/LpmbbWEgN46E4s8U8SWgvoJnDO5I2xcYLUwcOoG9DD1A0/Mc2WxN
+PfzYueF9s9mEhsTCPFUApuCPDKIdqXJlq2MJdDZHnrnQy9TvRM=
=Zf7u
-----END PGP SIGNATURE-----

--czmofhikde4js2ho--

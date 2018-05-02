Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEBRBZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:01:25 -0400
Received: from anholt.net ([50.246.234.109]:56694 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeEBRBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:01:22 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Fix oops dereferencing DPI's connector since panel_bridge.
In-Reply-To: <20180309233256.1667-1-eric@anholt.net>
References: <20180309233256.1667-1-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 02 May 2018 10:01:20 -0700
Message-ID: <87vac63sbj.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> In the cleanup, I didn't notice that we needed to dereference the
> connector for the bus_format.  Fix the regression by looking up the
> first (and only) connector attached to us, and assume that its
> bus_format is what we want.  Some day it would be good to have that
> part of display_info attached to the bridge, instead.

Could anyone comment on this patch?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrp7uAACgkQtdYpNtH8
nui8aQ/9EF/zPniNfsKtS5+ByeuCaFE2ZDbnZhVo+6EyG968Luk4+QAz7dfCURU4
pXo6JuBgqnWC4b0YAAOliab/1OPMYDPg2gnfs9JbDkwKbWQgj54ajMyilM03zVtw
12EHg67ZPpEX7VWhLpN64WmmjXxCUcRFpXHeKU/gkRe+1V0bWmzWSY5KZ9ihXYif
lpeslrv5wyC3xY9WFjiqvwmmZKC52jiV6Nb4pHrjs26P6Ru4r5OVRs3TyCaKxG3f
/Zs1JTKJc8NTWi9YU7pBCrizMoIxla46TyMwJN3wnIqE7DBRtH9vOjpMAis+d3Z6
pC/nWeVNSC3lBKxLn/5NmaNY4IsKL9yzaxUycHSpTv+LjyDNv047AZlYX/qDJXuP
FEBm9TcWE/hhRi2vr87oafJXpxUxwBO2VVAnKGeoGxKmEZsCLHQWj7kZ/8FyEZKF
bx+aRfT/YXV0yXy2elJV3prqvqeX9MyytvIBnXJSIy9d4+NQU4ZhFskhk8Qcw7E5
oMe0Jh9TQddTe+TBUFrV69Bpg1+2eJPMx4/h+CN0QpnqQmvdGBuohk0X1al06YHl
HghCpioqVrlJlo+FjeEfOlXOyKtj8+NZssx9+3Xo2+TqLqO9+eb+ECjPngOUNO1j
la8u+yLEXTqpF3jwqLmUw7+zoJfiuiXJrl0cgqDb0LVh+Y0dLtE=
=ojZg
-----END PGP SIGNATURE-----
--=-=-=--

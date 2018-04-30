Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeD3VEP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:04:15 -0400
Received: from anholt.net ([50.246.234.109]:40508 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755162AbeD3VEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:04:14 -0400
From: Eric Anholt <eric@anholt.net>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] drm/vc4: make function vc4_allocate_bin_bo static
In-Reply-To: <20180425070953.17933-1-vthakkar1994@gmail.com>
References: <20180425070953.17933-1-vthakkar1994@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 30 Apr 2018 14:04:11 -0700
Message-ID: <8736zce790.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Vaishali Thakkar <vthakkar1994@gmail.com> writes:

> Sparse complains with following warning:
> drivers/gpu/drm/vc4/vc4_v3d.c:222:1: warning: symbol
> 'vc4_allocate_bin_bo' was not declared. Should it be static?
>
> Make vc4_allocate_bin static as it is not used outside of
> vc4_v3d.c.
>
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Applied to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrnhMwACgkQtdYpNtH8
nui/3Q/7BVLzZpPO0q53cB1iqX3fV7HpObfEGCoeaILzEGDvVwmXK+IkeecyBHj9
3ugBBz2Bmfcu97hOU/+1k4d+H0LWmdXj6McVBfX9LBWL4Gbz4asQ0/HvLbKwTxfm
5h9ub7S5JugRN7mAx58It0D0KYbeCMZkfIE3QK58USbcpeorVi9JoRIhgxbtcxA9
A/zzMysxzIvGUvwfAlwkAqbXIgzFtyzqU0b5vBtqa+UxBpf/vLEvwzXP9nb/3lCQ
O4EQT+6z2U4aSuDETGKz4oU/V8h2zWeufmBoXHBDgSV2p5TTOBRO18zvib+mziB7
+Rj99Y1VzwrNn27PmB3R0s+Twv6NalT08OhGZmaasOo3lCwFIIjLhGoCFOHeEjs3
TepBxY6FdO9klXa6zGDGarA2x354Z/n0MYeH3oUMkmXiinlEDfE58/uNZpgaqhu3
Yu1NZOHeDG2Ach2f4+NeF+WnTgK+RUfwYJivnUDVNmujh8iu9iZQ8NlpfgkS9u8a
nslsQjsEeBW34I/KCJuNCNuvEsfFYbAd/O9D0QMshPaixjhfV179E9mzigU4vMLV
Kp+dO9Js0IfgK2h2/onq18Sgg0CI7lk0ambMMMOWR3baj91gROQNE6CAWcIGSTpf
yxob36kJgsQ1CUzm6q4/UbplGi22imxO8XG8IZ0/Fju1iGirGs8=
=6Odt
-----END PGP SIGNATURE-----
--=-=-=--

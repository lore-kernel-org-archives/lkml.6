Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeAaCCa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:02:30 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:55612 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeAaCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:02:27 -0500
X-Google-Smtp-Source: AH8x226nnM1q9N7AGjAvQnGUimpc7Oj+kozzFHc6/zAQIQOAvW+PGJ8YtvC1lASqLARvUxoFdMoL5Q==
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <6EDEF0FC-CCC6-4AC8-A816-76D5E8C68DEE@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1CAA5DCF-306F-499D-8456-7D61885DC82A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 2/2] lightnvm: remove multiple groups in 1.2 data
 structure
Date: Wed, 31 Jan 2018 10:02:10 +0800
In-Reply-To: <20180130132605.28635-2-m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
References: <20180130132605.28635-1-m@bjorling.me>
 <20180130132605.28635-2-m@bjorling.me>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_1CAA5DCF-306F-499D-8456-7D61885DC82A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Jan 2018, at 21.26, Matias Bj=C3=B8rling <m@bjorling.me> wrote:
>=20
> Only one id group from the 1.2 specification is supported. Make
> sure that only the first group is accessible.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <m@bjorling.me>
> ---
> drivers/nvme/host/lightnvm.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20

Same as before. Even though current implementation only uses one group,
the 1.2 specification relies on 4. At least, the identify structure
should reflect this.

Javier

--Apple-Mail=_1CAA5DCF-306F-499D-8456-7D61885DC82A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlpxI6IACgkQYx8FO3WZ
GMp3/hAAsh0KFV0zYCi3LzHBE6ZCzFGaV51q+CX5E2aF/G3DTkDMhp1d8p4Nbbyx
W6xxFrthgC05apmIZY2y3CjAJObNGvTTvthpRpnCKlYPOjSnhF7nKW+DjcTBBQOv
FK7e0vqlJ8yaNaHlvVTL2RWVpBwDd8L/YYWlhQ0S1jcgihQ533WuZsSJrVOzGc8o
OloMm3l+Bzq1h22VNOm6OZ0EmPXjTaYapl74vvICxMXcojt+fdQ2iNkYMv5NfaEx
o6GqDKwsT6PJxQ2gjkEM3m4pdCDc2WOmMdddiixUbCUUQowfpQJipSjnT2/Vpzv4
155snVRpuiNj96auVRqnNXgI3KOdd7roVAPkxDATQaTvyuozKxEASHNICkEuPg0E
AtQCrG9x7eY5aUxiTXqY2dYFNIBAIM6py3U6ZxqLi0rBCjY+80sHvUG+OUOoTWff
EIDzwq3RM7FRztLAc0DDRIiPmjDju7JiJBR/qMrz7gCZwcgclyQhT7452xPxvaU4
/o/DBWZ21QPayWj3mVJiyZLHeSGMOspCkR8Ucfh5nKNZysc59GLOpOOA4/O641tp
UvDyoKrqiOOTIfTV6l0yuc+h2HznDRNMyTKmGhi5+UM/mHG1C+9Qg7w1aU9Yn4lB
cuiIR5M3XZrJkFKjLgm9ygHvatm6RtkzeDjgtnxoUKz/AQGyFZk=
=Faj3
-----END PGP SIGNATURE-----

--Apple-Mail=_1CAA5DCF-306F-499D-8456-7D61885DC82A--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDEVm0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbeDEVmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:42:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33384204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 5 Apr 2018 22:42:19 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>, Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: vmlinuz: Fix compiler intrinsics location and
 build directly
Message-ID: <20180405214219.GA31336@saruman>
References: <20180403160728.GB3275@saruman>
 <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
 <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 11:13:14AM +0100, Matt Redfearn wrote:
> Actually, this patch would be better inserted as patch 3 in the series=20
> since it can pull in the generic ashldi3 before the MIPS one is removed=
=20
> in the final patch. Here's an updated commit message:

Thanks Matt, applied.

Cheers
James

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrGmDoACgkQbAtpk944
dnpc4xAAoHemdzlAjARKsk/B0Bh7hUe9ZdFAnuN/ecqtHp0WXGJKrYq4sF5JgNqo
yEGmmIJJ0E7lgvc1x5L6acJTaJmeEw59qiW8Ihit4zho7WNSZt0+N9Z7bN7TE96l
Gi+VGM+HqAPeMqNoVISRpiqFy8gzsYJqq/7tzXmBLi7+wtJPJ2pxMWmNh5WZp7Sc
tpgBgLJO78B1tcopDCQzwT6vijhj3SIW5cH2tc7YAXmS9KtZZ8SprjTETWUHcmtK
6Nw5n7jeda4I/ZABMJh+EfXwlmDA0yETftNvl7VClXEoHiEyorY/ekZK0VeNyIwy
eJEvPsFvMZlnPAEe2Dtr+Lr6V9RHlx4ZfvVWi6kzQtdChWxP6XE5yYi42LEBnp7o
cfhwqP1KaW/179xMxI4qK7HlQ49dsLVTUk9/tfuVvQ4A4HmUe8YkuQVW/XBOOClE
EcQC8dvOLJtVpkVD0gAB/McmP6S2tUxsYNRD0DyMlD/oUA9JuClxCwaLuaESFx7n
F0jGd2rk4lTaDVYmty+y53EGj1VvJK2ySC6nopP+HEHWdpb+p1VLT68IiatLInPy
S0sJY0OKjtwozVv6zRWPK0JTNgwwz3qPU5PiOkUTiiwQ+e66w49VdkeYJlsQ+Cfs
sk3dXuBoNPN4qSFMZLeYgRr+si9cs2YVGJ70ICjn38lGbjfWz9g=
=uUCf
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

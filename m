Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033271AbeBNRDt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032907AbeBNRDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:03:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3DD2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Feb 2018 17:03:43 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] MIPS: defconfigs: add a defconfig for Microsemi
 SoCs
Message-ID: <20180214170342.GF3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 16, 2018 at 11:12:39AM +0100, Alexandre Belloni wrote:
> +# CONFIG_EARLY_PRINTK is not set

Only Loongson1b/1c explicitly disable early printk. Do you disable it
for a particular reason?

Cheers
James

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEa+4ACgkQbAtpk944
dnqKiA/+JK10L4NAhXabJQzC3QCp0V/6S/flEnfzjFfGzkDAIDUQYNTAgW8z5SoH
j+SnhK9IRrCricogV/QqKkvHiTGhPh4VaVB7hnvuCC5+RKNnbGlf2YPBbtqKt1O+
30wV9Xgdg3JxUsglfeF+4ssKzjCJ52ymUIvCaJfNRihj8OLxJGKNH4MqA2nP/a/1
2a6Z0dtLxaeMEsZMciIBVVK/vOjHVmj54DB7ts/NJswTClPxpZYZi6h68suWUYoi
tqoYO+ylwamih9O72JS+kJTtpRtq2jLY7g+rN3AXtNZzqxG6vN+Bffflihw9HudW
xcYP+KDtUVXwLILuz/VUYPNPvJQq1VVJ9EzMPIOvFlPGKM+Jzoqnm3ucVZHpBqq4
I9XJvAgFZqYypB+40iWWc7qULgLd4BvHTnpyTEqSOtxjnCzkXAqaNZ1EJXzl8Z1K
A/O7v6gVTuFTZi+R1T7xz+RPiUSpHp80GQOMGX/3Umja18QpriQYcVszqDU8ZD++
2jF3jOYJw+gXRMLjDOAkm39T6crVB6jK8xZuTUu1kWhd7l2/TwHFG5aQrfLdDMaK
cTA+G4QnUbzwj/ac3DNRT2Vr/Weqem9O9hcIXEdoig4cddKGj2f/FBQS171qnBa5
2u5oFnHOab2G58NGQpFSbayZX7lnIfthbM+oBOCahA/v88qWyOg=
=OoOS
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

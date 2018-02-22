Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeBVHZZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeBVHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:25:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD65A21747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Feb 2018 07:24:59 +0000
From: James Hogan <jhogan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] metag: Remove arch/metag/
Message-ID: <20180222072459.GA9891@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-2-jhogan@kernel.org>
 <ea057277-fc48-3961-681d-385023741cdb@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <ea057277-fc48-3961-681d-385023741cdb@roeck-us.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 07:52:08PM -0800, Guenter Roeck wrote:
> On 02/21/2018 03:38 PM, James Hogan wrote:
> > The earliest Meta architecture port of Linux I have a record of was an
> > import of a Meta port of Linux v2.4.1 in February 2004, which was worked
> > on significantly over the next few years by Graham Whaley, Will Newton,
> > Matt Fleming, myself and others.
> >=20
> > Eventually the port was merged into mainline in v3.9 in March 2013, not
> > long after Imagination Technologies bought MIPS Technologies and shifted
> > its CPU focus over to the MIPS architecture.
> >=20
> > As a result, though the port was maintained for a while, kept on life
> > support for a while longer, and useful for testing a few specific
> > drivers for which I don't have ready access to the equivalent MIPS
> > hardware, it is now essentially dead with no users.
> >=20
> > It is also stuck using an out-of-tree toolchain based on GCC 4.2.4 which
> > is no longer maintained, now struggles to build modern kernels due to
> > toolchain bugs, and doesn't itself build with a modern GCC. The latest
> > buildroot port is still using an old uClibc snapshot which is no longer
> > served, and the latest uClibc doesn't build with GCC 4.2.4.
> >=20
> > So lets call it a day and drop the Meta architecture port from the
> > kernel. RIP Meta.
> >=20
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Link: https://lkml.kernel.org/r/95906b76-6ce1-3f84-eaba-c29b4ae952eb@ro=
eck-us.net
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-metag@vger.kernel.org
>=20
> FWIW:
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks

>=20
> Did you drop the definition of CPUHP_AP_PERF_METAG_STARTING ?
> I browsed through the patches but didn't find where it was dropped.

Hmm, somehow that one slipped through my grepping. Thanks for pointing
out.

>=20
> Also, how did you generate this patch, and can you try to apply it yourse=
lf ?
> I tried to apply it, but neither git am nor patch worked for me. This pat=
ch
> also doesn't show up on patchwork.kernel.org which is odd.

I presume because I used -D to git format-patch, which is apparently
only intended for human consumption (the full patch is 778K). I've
pushed this version of the series here:

git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/metag.git
tag: metag_remove_v1

Cheers
James

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqOcEoACgkQbAtpk944
dnr7dQ/9HkoCi/T27DeSY/sJA9zikIw0eZryOTNVlcIRN8oVjDAt0ozVw9TixWzk
JvMq0sMQl8X4wX8OzRaJTRfEScGNHdsiw2jawu6YS3RCiNx1R70p/mN3p/f2Gy+z
teZimLeh07hTUd5q8N5C9MnQdtKokdI1b4EgxxYEgvlq5q8AbgN/Amle6bMFv4yH
/2GxiMKRQhrHQ5NtwzRYCI/ilOaaGcYCJ6uyHiyApaeij2N45XWjTeYsKxa8exDD
LsWbToc/Pvr9uIk1mZDRS3XZfHgOdICOu1OEzBS9vUFMGVYONY+55J3TWtg2E/d9
Ys4gOl1pGWo9wf6ht0fuCHHX3E6nbmZJG83bFp3PNJhda68qbJx2aQ3CwReOQuPT
2VPMUdIcC4KOsyvvS4PwPqkq0N/U2h38x8aUGGRodWKuLeYYrL2oF68YqlDykIMw
J7y6wuzs/R37ZsDD80gKmW7NMZxFIGCOvXYK7Wm49NvoZe9b3sTrK4DuDrmWp4eD
v7161YTS9aGCZ66SKsAMfOqtceyBuj/UoWNXFe2JUyFIpoBxOXuCnXR/xILUqNo/
MhfaZAw2tp/DS5qFWn2V7xzlYg9nI+QMxu1/7BOF23+Zqafo3tOxtFoG7OOUI3CI
Fcfg5PgReHbegBfehWGvlhBIyQdlFkCkfBt9sJvxcnT4oqZIpuY=
=8mmR
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

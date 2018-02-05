Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeBEAJE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 19:09:04 -0500
Received: from home.keithp.com ([63.227.221.253]:51798 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeBEAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 19:08:59 -0500
From: "Keith Packard" <keithp@keithp.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] hwrng: Explicitly drop current_rng when unregistering rng device
In-Reply-To: <3f489790-dbfd-e726-e957-7bc7af0745bb@amd.com>
References: <20180130232627.3014-1-keithp@keithp.com> <3f489790-dbfd-e726-e957-7bc7af0745bb@amd.com>
Date: Sun, 04 Feb 2018 16:08:57 -0800
Message-ID: <87shag1ena.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Tom Lendacky <thomas.lendacky@amd.com> writes:

> A similar fix was already in the cryptodev tree and I thought was part of
> a recent pull request.

Yup, just saw it on master. I've checked and it will do pretty much the
same thing as my patch, with the addition of clearing
cur_rng_set_by_user, which is necessary. Thanks for looking at my patch!

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlp3oJkACgkQ2yIaaQAA
ABFwKw/9E+azFftP8H5sHTztjCvdO5nBKH7PFXhXEMplU9PlBDvacE3do3zrYCpT
iqRq53Wpg+l0Y7KSWgbOUY6uRc/e344ILievDDEMW6lxFbgtX4O1IgO9L0+mBUCy
J94zAiPQLfnCXzjgudfhBSU1yb8Tm1OGxYhucMmsHd/sbFmQnSDexpfFyGqJNolP
WISyRp++WScFfEOWlEwC8CHsa6S39W5s3Bc7HAn4cYVku1YspSMF8SVLlKFYLEzC
6kV1t8UscE0WPiSi1/t0o3xbRxsn53j899edlkUkKJQ5fKf8Ng8Iea0bffvg8IuG
+rZw0Ht6jaeVpeZ+hXSwINVnOs0aWkW2m6YRC1GAf5ZEmyH9ne7q+4fa8H6vsFwS
JUF+UqRXC/tSjobKqQtAZ6eBbCIcJvUAMl50hkAg16pi11kXfwX5VmQWzvduNnkI
5YfLC7YALYozj9GzZbBt6exNVrc4JV8ZKm4QAcQOG4JaavIeSjEhyOX3baP9cdIU
6jq2I88P29OQJeE7mMyIU6+zybe4fkp+ExQ8IZGsVDnLxzdTa5gVNeVL2xdi191c
sRmrp2QrAxtcYMyUxBP53wCeNDVRZpmaZu59aG2lfS/gRl9klClOSxLycIfJSO5E
SGtc4QPVSb5fVBJAk5r6oQClVUS77pcxzdkYhU/yhg1USuZDsWQ=
=+6D7
-----END PGP SIGNATURE-----
--=-=-=--

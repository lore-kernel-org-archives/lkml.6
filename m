Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFDTUC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:20:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32909 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeFDTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:20:00 -0400
X-Google-Smtp-Source: ADUXVKK1hmJykjjPCaOmb1Egi4Q/m8pjP2FBkuSe/VnIJ8j8afi7q2EsY4NUmht361OyYUQL3GKuuQ==
Date: Mon, 4 Jun 2018 12:19:56 -0700
From: Benson Leung <bleung@google.com>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, ravisadineni@google.com,
        dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, furquan@chromium.org, bleung@chromium.org
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
Message-ID: <20180604191956.GA223551@decatoncale.mtv.corp.google.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180604182612.72699-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 11:26:12AM -0700, Ravi Chandra Sadineni wrote:
> Currently ACPI LID increments wakeup count irrespective of the wake sourc=
e.
> This is because we call acpi_lid_initialize_state on every resume.
> Userland deamons using wakeup_count to identify the potential wake
> source for the last wake will be thrown off by this. Instead increment
> the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.
>=20
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsVkNsACgkQHwn1ewov
5ljgNQ/9GrX6uAntPCVerQQvZGujYAjfvWqgPfNxyGeMLrI/wE8E+ds9osgGngOz
1MubVAlzNOv6OMxZG1rT+MzwkWPv/U3veUT5mPQrlqg+Ddh5NtOsLciVauyKPyz1
SEpQNI0xzxpcaz/6v+qAyLWzecpcAx07TfDjmNyf2mfwhK6Uee/F2jUusA1EPGig
jV2vyaTuyI7VvU3o5oKZRFkLFeDH4R5ShE3rJqBurpQroOnyv+ECtyiSByk/kFlg
llTZLUBLzrcjhNfct1aPyDhu3yudJrhd0QtWznQlRLgvw0C1FbU69B8KBl71EQwU
PV3QiHdJl3Kzfh9jDUnbrJfkBWemj1INXXH3hKrt1sW3O32N+g01n/Rx0o75LPLz
we/0RRXfZZxNERDYbUaP3x7a9JOHPFao1yBKboDxbfzXUUc8tGfCqdUIkolWA9R4
Tx+sKzLzq0Jf558Q5ND53cuvwnrdofGBnOeoOAoooenEpDPPINk3j8gg/S4nBphF
0UMwFU4HChOiI23R8WQlUHkxT/RoT+643mwvRwV/hQwtJmW7F2gS0vbeQEGjQhEO
6WhlylcX9b9/6gK5tSIYj/d4nac4bmDxfmlpsqb4JV5hAF7JP5i0EongnEOsZTrN
oluu9TfFFccCFYbV9d2xZxBzHV3N7wWgOP9yr/HzIXCIf1NQt0U=
=BuGJ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

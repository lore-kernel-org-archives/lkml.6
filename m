Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeEVXsI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:48:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36001 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeEVXsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:48:06 -0400
X-Google-Smtp-Source: AB8JxZp8bVjo5fhZMQW185gWaJiXqQLE1bdc2oPm8w2HGtc4+fAwu6P5rui3CWkPLoJiLeSgnjIW4g==
Date: Tue, 22 May 2018 16:48:02 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Vittorio Gambaletta <linuxbugs@vittgam.net>,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: do not try DMI match when
 ACPI device found
Message-ID: <20180522234802.GB229422@decatoncale.mtv.corp.google.com>
References: <20180522230841.GA22026@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20180522230841.GA22026@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, May 22, 2018 at 04:08:41PM -0700, Dmitry Torokhov wrote:
> Older models of Chromebooks did not describe the LPC EC in their ACPI
> tables; starting with Strago-based devices Google is using GOOG0004 device
> to describe EC LPC.
>=20
> DMI-based match is fragile and does not work reliably, especially when
> using custom firmware. It is also not needed when we can locate the right
> ACPI device, so let's stop bailing out when DMI does not match but the
> right ACPI device is present.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Nice fix. Applied.=20

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsErDIACgkQHwn1ewov
5lgdbxAAix2ORmFMtBbJiNarVh1wFQVJHLgGKAmhdqS1z6AbDgZhWSnNF5oRQIfl
3R+a+N1+xKQn/MeAgzs/i5T2Q+sFqgrxHTUHtfdD1UuJ7PT8NDMGXt2m8UkMrPXP
clxYZPmVnfkm/Pm36o1rsJCcfFkXXABGLRsYUqhCSzxLBomyJoWAB1/HwxgnZ2YE
m267ZV28TFdCuu8AGa113BjqUfSqM+HV5zaoO1nx+9jx5W9/FierDAdEm94q2Wrp
/bQ0LuX6TeuKnO5Ftz4ccwVXm9bWOPUsmII5J9cWR0nMWranhFWmevh5o8sFE87Z
hR+0m7W0sGm5eWn2IcWTWFtMQ4/iwBJREiMSulfPDxOAu8YsUmt/nFTA3AbZ7eO/
5GC9ycHDnCBpp9ft0GeabDNF+wEkCeVwugt0TVnfGVKD+N5g3RLF+5+LDBFw8zgU
1KP3BYTjRgdn70NbXRXrzihcH0FS/aRG03+XGiUy8x+vGVydMKnkdCJMmB4T+QXQ
q846e5/dT61Y9t2sQeeqZChfxKU718DkLQQ70Libfp2l+HuFTDTN0slNZLePMNAq
pe629SXbv3GytDex461ZZBeWTXJmdPKSnx1ddRZwRw6ag536ksJ7b29pPt9c/o06
1h/NGf2w/HQP9V8BIbWSisKps301UfG4EjfF4oDYkA90o22eB30=
=s1g1
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

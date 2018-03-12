Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCLTRG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:17:06 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:38775 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCLTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:17:05 -0400
X-Google-Smtp-Source: AG47ELtvT46YsTJe99ArsTQZbo+nzZBLJmjtiozAkgbvq5PQMtIR2xY1QS/1pLoIQciqlE8PwInxzg==
Date: Mon, 12 Mar 2018 12:17:01 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, bleung@google.com
Subject: Re: [PATCH 00/14] chrome_laptop: stop being a platform driver
Message-ID: <20180312191700.GA131001@decatoncale.mtv.corp.google.com>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 12:08:53PM -0700, Dmitry Torokhov wrote:
> Hi,
>=20
> This series is a combination of Atmel touchscreen driver stopping using
> platform data and moving over to generic device properties, and
> chromeos-laptop switching from being platform driver, which is the wrong
> abstraction for it, and moving to using i2c bis notifier. Switching from
> platform driver to the notifiers allows us to get rid of the ugly code th=
at
> manually tries to handle deferrals in case i2c bus is not ready at the ti=
me
> we start initializing the module.
>=20
> Benson, because chromeos-laptop is instantiating Atmel devices the 2
> changes are intertwined. While we could apply them in stages, with parts
> going through input and parts going through your tree I was wondering if =
we
> could speed up the process and push the series through one or another tree
> (if you are OK with the patches, of course).
>=20

I'm all for this change. I can push this through my tree.

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

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqm0iwACgkQHwn1ewov
5lihqg//TBdwbNb506AWyEFpPxFhEnXDBnaDY14NlyCe+q2as2pWDpK/hG0nPhA2
gtNsagmO/KA2Mksm1ereK1dk+sMNJYYkp/WTQS+t3YqJOZiWKgoMT2Bao6VghxEF
T/pKWz2XAUDLjlzxOSFL6tL3hoJWND7LUTIJVBGUb/2U0JCicor+ZbiQQd+4B2rc
6j7ePnbWyMNUto4rWUWHVvhQHEHLSmuAHeLhetEvP5Um9Rj92o/WRls3MCqN5PMW
aaTqbdOIoPlDe5u5lay87kyU7EvEVRGteue7s7y4dMC/5ouRLTPeO69Js0QPtKe5
RIwFOlV02YWR5p14uC4Bi/fXqZcRsFdX+ZiPK8t/Ia8sQOMNIjwUFhvrn4UoUQi2
bdTDUCYLphY//CdHx3z87+xxM1FbMDEkYFpZ3XjteL7H6cYsiayrxI5lxCGUEjor
XdC1tEbjwD0XQBut6Tkh8jlFQVhix3w/IY+Htl8wXK7XtbSqogvjEVcqPB1mdGT/
p9Vojc4lmytsK1t44FcyBJycUFgaqQvb3+po9s3C8QCQ/SFVSQyx0YV12m8VzF0D
hz/NQVEiArb0xC0eUW18Mhl/qnpa5zgZh3dHTr6KbozYyJDYrpTcCsnFIc3QYu/3
OfIk5qb0Ja55ztcA3t2HhaE5Kp7TIWlOAaA/8z7v+QHxlIIxqXg=
=QOMn
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

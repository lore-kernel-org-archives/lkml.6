Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC0Juf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:50:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40767 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0Jue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:50:34 -0400
Date: Tue, 27 Mar 2018 11:50:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Did kernel 3.11 never work?
Message-ID: <20180327095031.GA3858@amd>
References: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-23 14:37:17, Maurice R Volaski wrote:
> I am trying to use kernel 3.11 on VirtualBox or VMWare, but it hangs at b=
oot right after the message =E2=80=9CBooting the kernel=E2=80=9D. Under VMW=
are, VMWare gives a message that it received an instruction to halt the CPU.
>=20
> I have tried different editions of 3.11 and they all are affected the sam=
e way. Does anyone know why this and a way to fix it?
>

There were kernels that were dangerous for everyone. But that was
1.3.X, IIRC. 3.11 should work in most configurations.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq6E+cACgkQMOfwapXb+vJw4QCgmBvpO9ND7AygAg0GnEYzR4bZ
ePIAn1vH5iNW33IF5zFJMnFshFVO+F2I
=sJTJ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

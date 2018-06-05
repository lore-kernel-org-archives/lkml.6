Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeFEKvf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:51:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFEKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:51:34 -0400
Date: Tue, 5 Jun 2018 11:51:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        matthew.hart@linaro.org
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
Message-ID: <20180605105121.GA25374@sirena.org.uk>
References: <20180604065802.157744637@linuxfoundation.org>
 <5b152b7c.1c69fb81.3f04a.096f@mx.google.com>
 <7hr2lmjgcd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <7hr2lmjgcd.fsf@baylibre.com>
X-Cookie: Another megabytes the dust.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 04:13:06PM -0700, Kevin Hilman wrote:

> >     defconfig
> >         synquacer-acpi: 1 failed lab

> This is a newly added board, and hasn't ever passed on v4.9 yet.

> @Matt Hart: Is this board expected to work as far bask as v4.9? or
> should we blacklist it?

Should be blacklisted.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsWayYACgkQJNaLcl1U
h9DyiAf9G4AGBAAFnEXMeBoP5FVm60shGhrXi5hovoyL1SpiNzzpWOolfKXRjdMG
dbowTQni2FsD5AwvsinWmOmeoGogNoYeH2hqwD699iWWDzxLHL8zkptKApa20t6Y
w0rL4HHKM6xeG2cHpxUBzK73NjmHK9yiJ6B7jOKZA6Zz+6wV11uw90p6+1cMjlYL
8i7sg8HdBwx4H3uNWcUJEjFDqaacEnq6nVJEh7HWBz9SbedIglWY2IUH29YEuM92
Lle76ifIWaSezSrZOckMiK5CYuBomZJ3LxTXRNBZCbj2kdq3Li0x+uKfIo5IEIQH
CWOXYgcvfGpCrd+JG5aRpsCyZ1WClw==
=BMd+
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBXIxA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:53:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36464 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeBXIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:52:58 -0500
Date: Sat, 24 Feb 2018 09:52:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] leds: ncp5623: Add device tree binding
 documentation
Message-ID: <20180224085256.GC12996@amd>
References: <20180221214654.3306-1-florian.vaussard@gmail.com>
 <20180221214654.3306-2-florian.vaussard@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20180221214654.3306-2-florian.vaussard@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +Required properties:
> +  - compatible: Should be "onnn,ncp5623"
> +  - reg: I2C slave address (fixed to 0x38)
=2E.
> +Required properties:
> +  - reg : LED channel number (0..2)

For consistency, there should be no space between reg and :.

Anyway, this can be fixed later.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqRJ+gACgkQMOfwapXb+vLIkwCfSPiuc1/xejFwvmcl3F7iEveb
UP4An2AEE786yTF8507ah0emHKw8M/Bu
=fOsR
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

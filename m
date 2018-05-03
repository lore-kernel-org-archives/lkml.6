Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeECTZR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:25:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57981 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeECTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:25:12 -0400
Date: Thu, 3 May 2018 21:25:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Droid 4: very confusing config around OHCI_OMAP3_HCD
Message-ID: <20180503192510.GB32572@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

For power management experiments, I tried

CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_OMAP3=3Dm
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy

and could not find resulting .ko.

Help text says:

CONFIG_USB_OHCI_HCD_OMAP3:

This option is deprecated now and the driver was removed, use
USB_OHCI_HCD_PLATFORM instead.

Enables support for the on-chip OHCI controller on
OMAP3 and later chips.

Which may partly explain it. But if the option no longer does
anything, why keep it? Certainly second part is confusing if option is
NOP...

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrrYhYACgkQMOfwapXb+vLI7ACffXJTWDCMGsMPHDCUB2ZfCjq8
94QAoJ3f9xNUIOPqmC69s/ekjFJIemx8
=rL2w
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeFAKbt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:31:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38777 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFAKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:31:46 -0400
Date: Fri, 1 Jun 2018 12:31:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: rostedt@goodmis.org, torvalds@linux-foundation.org, joel@jms.id.au,
        me@tobin.cc, corbet@lwn.net
Subject: ptrval hiding -- first kernel messages look rather "interesting"
Message-ID: <20180601103144.GD31639@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.17 on n900:

[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0000000 - 0xff800000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcff00000   ( 255 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 309 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 333 kB)
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16

I mean -- security is nice, but perhaps we should adjust the messages
so this does not look like we are making fun of the user?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsRIJAACgkQMOfwapXb+vKtWACfbp72oHOgSrxEOyuyVRBt2gcP
D+gAoJjRbuSNurOKg/EhXrCMv21EREG5
=kF4q
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

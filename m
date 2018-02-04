Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBDPIu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:08:50 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36908 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:08:42 -0500
X-Google-Smtp-Source: AH8x227ZHEDq1kV52Eov7s8+WT9+TguDHz/zkss6qWHfZE3d4EVGqZSA1olKvAzSb8mDvaCXYdpCCA==
Date: Sun, 4 Feb 2018 16:08:39 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ALPS Trackpoint & pressure
Message-ID: <20180204150839.b5qm4wb26vic35st@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2dayic3w3ld76oan"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2dayic3w3ld76oan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! Now playing again with trackpoint connected to ALPS rushmore
touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
reports pressure of trackpoint. Parser for it is already implemented in
alps.c and value is assigned to variable "z". When I just move
trackpoint z is zero, when I push trackpoint while moving, then z is
number higher, maximally 32. Variable "z" is set, but unused.

Do we have some input interface which can be used to report this
pressure of trackpoint to userspace? I can use this feature e.g. as
additional button...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--2dayic3w3ld76oan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnch9QAKCRCL8Mk9A+RD
UgJSAJ9k0lLmmJCbIp9rBgFPUZyiZxziOQCcCh9rRSmoThGwCwOzHRUofsPFE5o=
=R4/D
-----END PGP SIGNATURE-----

--2dayic3w3ld76oan--

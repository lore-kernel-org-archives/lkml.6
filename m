Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945959AbeCBKSB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:18:01 -0500
Received: from sauhun.de ([88.99.104.3]:53649 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1945930AbeCBKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:17:56 -0500
Date: Fri, 2 Mar 2018 11:17:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180302101754.npxrbagl74jvveza@ninjato>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ahtyt3gc37mx6sh"
Content-Disposition: inline
In-Reply-To: <1519678013-32749-2-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ahtyt3gc37mx6sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 12:46:53PM -0800, Guenter Roeck wrote:
> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
> One example for another driver is the sp5100_tco driver.
>=20
> Use request_muxed_region() to ensure synchronization.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-next, thanks!


--2ahtyt3gc37mx6sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZJNIACgkQFA3kzBSg
Kbb9XQ/+LlJzoGswBqBtRDTdormIAS+xaF4vhJb4UTt/S3zNLmx350Mg4NSdudSC
3xz4Uhp49ofOTyr+QR0k/mqJ+4nQrMs+GlZg5OFAefZhijG4qPjkZnMYGqgTlCMo
hpoil1+T/OR4d594S3x3LnliXhTrFFAgNU1uXTyw3dp+ZDpqYwnt3bTfgIm5tFCG
qgS8gxGtACk3Y0pZUWGV9l1yJMiqIoGo5U0LfJ7A9f5IF679O0k+nokXTTxGuNiQ
3wUVLKg8oF8DGo33DPVo1yUHwGVwgGpkbFIh0S/M4sO6NFuiaO99OarwUt05ZcHJ
5v64vn2akcO7l+FRaD8xtGM4LwO9lxCl3SY+JhYdV49tI7K3U1/oIbA5TjzWvyZE
lpZdG3FCbScMR5dT8WoqEmYfc309+tZfsEuERVlr2wE2d40RcouEc4O1t5Ai/c73
aUY25TCimotssWbEngSqwH/fP7u/qFWD/msD6OK7p8Yq+VWhkcTMKBcpeLlpx+mw
bOoKmDx7QNC2iqoZJSeTDKsNmdgLsMu8kAB+5At0K5z0937/IRKDHnYTGbq/gBpK
w9W7ajjYPeLi+kF0iUXVZMHbT0UCgDLzFdkLD6yu+1XaCFf8G1eugW7IWdfxhpmX
z4z8aembq/dVUc/iEeK+Dmsf5XC7lQQrveQOoSBjZ06r/SP94y0=
=acS/
-----END PGP SIGNATURE-----

--2ahtyt3gc37mx6sh--

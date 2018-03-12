Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCLIob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:44:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752474AbeCLIo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:44:29 -0400
Date: Mon, 12 Mar 2018 09:44:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: sun8i: a33: Improvements for A33-OLinuXino
Message-ID: <20180312084427.r75ko3jgmukmuls4@flea>
References: <20180312042356.18625-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cv73grxaoujzzehz"
Content-Disposition: inline
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cv73grxaoujzzehz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 12:23:52PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> Here are some cleanup and improvements for the A33-OLinuXino device
> tree. The first two patches drop some unneeded bits. The latter two
> enable peripherals that we now support.

Applied all four, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--cv73grxaoujzzehz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqmPeoACgkQ0rTAlCFN
r3QzNQ//Q5jZqfzFS0aHoJz+hg2vw5EN/HRR427q07Va48IFo2PU5kqDyM20gVIH
Rtq1tKnG9kVDZZwSQFwsh6dUUXdUpHxXW/3zMUb5/TlWfPJbiIk/whiD5zbCSJw+
AYn6hRSz6jRLhQnIlwXsKZkUlRVp4fpsmKCooaBW7BUuiWp43CoXvbQ5VvmGV4XD
qlYpPCwmoKu6lem3GqzFny1QWU5MRsMa83u73EBadJDzoWuWJQ4tEdO+eQxxizdZ
1QFV8H0CQyva4SDC9W2TlUpMnBuuAE//vCsN3RfbzFK3luNOMATwMXNsUij1kGeD
YrETSMfSB+QhqQ5APTvGqzFZ8NmbPEAeGesgjMHXnb9LTtJ0BnDLmDX9o1H/3FJB
IZ4V6C8hrDXgoUHgF5C6b+190jQgkVugw5Od3U3XiiDPSVfDN9kSMkEaCsaa2nKs
kMbJ5PfyutjDm7jyMo7m1iUBSZPJoO049noohhlspuvy4u9x4vNf8d9tfnNN+pVh
25FbtMSB1cZAX/mC0T/SleZauSHSPqJky61Dsnn6+V8nUuZ6KplAHUMLNl0J6cIG
QYB/qmG5JF4okyECzul3KSvOEqA/iwndT4AVYLEuvmr97ZkKHCNrbyto4Ru24ygO
CtHCsNe7v8RCjrKI/iw5Q6QLGUn3HszCX2s9TXK5Z7txs1nIWwo=
=mJi2
-----END PGP SIGNATURE-----

--cv73grxaoujzzehz--

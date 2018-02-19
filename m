Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBSLet (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:34:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeBSLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:34:47 -0500
Date: Mon, 19 Feb 2018 11:34:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE
 suspend_state_t
Message-ID: <20180219113444.GA32761@sirena.org.uk>
References: <20180218170424.11976-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20180218170424.11976-1-hdegoede@redhat.com>
X-Cookie: You enjoy the company of other people.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 18, 2018 at 06:04:24PM +0100, Hans de Goede wrote:
> The regulator framework is used on x86 in some cases now and x86 has
> a PM_SUSPEND_TO_IDLE suspend_state_t, treat this as PM_SUSPEND_STANDBY,
> this fixes these errors on resume:

This was already fixed by Geert.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqKtlMACgkQJNaLcl1U
h9B+EQf9HioMlMvTACNuHgxgD7fT2CcHM+7bl9GmSDyeewI4Xd2GR+8zBQav3TFO
q0Tg1Mn3Vag5sjHhOSIPIpjuU+Ci3ivdx1YlfM2vAOjMfeT6ImDsoYU7zTxMPSN8
4A/58LF+sA958B8G5sFem9snm9iyP0gM/9ZNHvMTKfrrbCB30KKBHFbwCnLp/Fq8
LUnMGngzVRPpq/Px8oy/GYyWCLKwpHXNmXGdnlP0Mmv/Oq5JLcifNjo2sWBAaNSf
oiSyP2fFcLOYSxC7MSl8TUIc9doUr0RWThswL5w/fkw4wgosHe0mKMZkHKgCDYZg
tDlrnNxY7zh2qFwX3CZB9gPCNHEs7g==
=1uMZ
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

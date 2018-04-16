Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDPQ6v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:58:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbeDPQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:58:45 -0400
Date: Mon, 16 Apr 2018 17:58:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
Cc: vigneshr@ti.com, sourav.poddar@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: spi-ti-qspi: Fix parameters order in
 regmap_update_bits calls
Message-ID: <20180416165841.GF20726@sirena.org.uk>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
 <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
In-Reply-To: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2018 at 11:41:23AM +0200, Arkadiusz Kwiatkowski wrote:
> This commit fixes the order of parameters passed to regmap_update_bits
> function inside spi-ti-qspi driver. Accidentally the code worked
> correctly when cs=0, but it is not the case for other values.

This doesn't apply against current code, please check and resend.

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrU1kAACgkQJNaLcl1U
h9Db+gf8DkztroNNFajgi5uCMec9ZiegpPoY5iv7efHPF3Fil600G6Huxe0SWCl0
fVBcZzEF/Pv0VpALb2cmKHgTV/adt/MBkOwzc35r7Zj4hpaN7lN+T4cl6CB9iabB
t2uVMUsFSl+bFzDsJKAZzANAo2WF4EOHoIkRfyWlS68kn7f9qM7+yB4Pua8cWTrR
isAnXSuutBOuvQkpr2sK0EeKun/B3VXFzdPzly50OPSBul6ovUDEi/4rnwcYix5c
Pl/ai2xC5lzOFIJvJoyWhvFJ+6gRnYqVjtjycYPJhxp/2hu6r7nUzKPJPHthvsqQ
jxAg0+d1SngNDXlUCYQKXnFKZue/AA==
=JmWt
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--

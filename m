Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeEKVx4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbeEKVxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:53:55 -0400
Date: Fri, 11 May 2018 22:53:51 +0100
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Message-ID: <20180511215350.GA20355@jamesdev>
References: <20180305170704.17073-1-paul@crapouillou.net>
 <20180328153812.2592-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20180328153812.2592-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 05:38:12PM +0200, Paul Cercueil wrote:
> The debug definitions were missing for MACH_JZ4770, resulting in a build
> failure when DEBUG_ZBOOT was set.
>=20
> Since the UART addresses are the same across all Ingenic SoCs, we just
> use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
> Ingenic SoCs.
>=20
> Additionally, I added a #define for the UART0 address in-code and dropped
> the <asm/mach-jz4740/base.h> include, for the reason that this include
> file is slowly being phased out as the whole platform is being moved to
> devicetree.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for 4.17 with fixes tag and 4.16 stable tag.

Thanks
James

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYQ6wAKCRA1zuSGKxAj
8uz0AQC9PKGntccWQ6m5z6EDw5V9yNFMq6qwunv73lq2de7pgQD9H4foYjoxYig3
4Ayuijs6bzL/RR4lyI88f3pLjNjBOg8=
=T+SI
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

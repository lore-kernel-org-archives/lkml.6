Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeBZUUM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:20:12 -0500
Received: from sauhun.de ([88.99.104.3]:38388 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBZUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:20:10 -0500
Date: Mon, 26 Feb 2018 21:20:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
Subject: Re: [PATCH 1/4] i2c: xlp9xx: return ENXIO on slave address NACK
Message-ID: <20180226202008.w4r2aevpdlpc5bpb@ninjato>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mbufeim6zwk2esu"
Content-Disposition: inline
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mbufeim6zwk2esu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 05:39:21AM +0000, George Cherian wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>=20
> Fix the driver violation of the common practice to return
> ENXIO error on a slave address NACK.
>=20
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-next, thanks!


--4mbufeim6zwk2esu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUa/MACgkQFA3kzBSg
KbbppBAAj/RMyChsrGlNbBLXeRx9TZIfanFiWWx6UDpayEd2Ot1Uy16ikQGNtDkP
MoUmAG/S8XN2JGI6B73JgtlWuSCTRZnSi03Dx7c2i40sHf9k+uw0dJ5cjHjWI99j
+FzZpppNRQHGp3Y85ZZmE+IUemXrSdtudWbu0szDUSUwISLwUxk1VzPwkeCaWe1f
sNKKCc0QnarxKKhGhGiwA7uTY1GY6cgUqL2VjoOFMC2gKckxwvzSJmEbfVrbf5KE
MjVjj+9Hu6SaLMx2r2SNu4/v1FygoaiqfW1K7ERBkBeOZBSnEV0cgUXkt9D5Vd/h
iyytqr5B/LpQdp7mvoNB2lsx7gL2It1lqoyrXsTLLv0UMrVzyuFMLJIBRveFx9td
MO/eteBTc5P5rbM5Nu5XTGlDXbmsMN1u48t/NDGs2VPfJFpM8ztFVf5xspOQsIZC
6DfToU8gGexZ8MT26l78nAX8ZbR6Jbzcpv1/UBOXGKlmQ6P/GG156sCgzXFlthe+
m6hRlo2PqQrvUmO3ujR6WzBNp2XOWSfiftyS+5zEmHN4F8qeXs3Cd3eDfJcPjjHY
Bk0rEv4/WhFoQb0LCiBFUw2yPZ9iYuDrPhLYb7riM6ncRumqn6+nsQilLkyaOfeU
mbb33zGXT83aM7UMo5UVhf6AP0U4z/Nm2EJ5W3hPHehT8sBuLU8=
=/msg
-----END PGP SIGNATURE-----

--4mbufeim6zwk2esu--

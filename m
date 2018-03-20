Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeCTKxv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:53:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbeCTKxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:53:45 -0400
Date: Tue, 20 Mar 2018 11:53:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/sun4i: Fix some error handling paths in
 'sun4i_hdmi_bind()'
Message-ID: <20180320105333.56uhos4rarqyyhas@flea>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azndqhggqixbtuj6"
Content-Disposition: inline
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azndqhggqixbtuj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 18, 2018 at 11:48:08PM +0100, Christophe JAILLET wrote:
> I've splitted these fixes into 2 patches becasue they do not fixe the same
> commit.

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--azndqhggqixbtuj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqw6CwACgkQ0rTAlCFN
r3SCQQ//d7BzyskRYf0iRiV3nQGFg7yQReUV/95kpLvdLvMnfmThlF2D5zo+KeqP
xJJEa2lmX4rp7RTBUX/My6oh757jupCZABVMwxZglXs2ybA3Zj7QR2IWRe867Dmq
EC6m/Z97szMFXA2ViNWi+BXcBmniZcFQGp3kMmdQo24V6bN8/b7IKx4z6M2QVoFJ
hPIjBEx6c5dyZLthnKDdP0fH35TvBBgjnLW0SyWnsKl40yL9oVclNV1BKhDh5mhV
Rb7JkgdTNuH2GpYT7hlMjIt3AIFvuGIYoBdpiZCXaf0deZCB1BG3T47lUO6A6klC
Ivxiv/5UQqeiw8cSw/Rxp2K782mTHahWkPLOf84g1Ipx56QBNPR24Ec+JfehB5S7
JkmMN84W3MT4yCPabfMn1fBU2W39N8CGP9qmv9/E3AZEI2KglQvrTpyxKY2yzfwb
stB0IEtCzyUvHgrLf0dgTw4mxDNaLXBEgVYztKjpIyK4adWZBjTz/3AzqjOhvtn0
QEcM5tateLOcohnz7cNgilZmomC01RhyEGT8/GAaG0/4M6Vy+akK4TcZZl4+q7vC
ElbFaLI12RgiepvBNanmc5V3o0aGabcWEDNNRifUG4+cBlu6V/KljMj22uy6HJWC
GJ87SudZZUYuW/61jGqdaHLTQ2QXg8qgB+uN8ejoZdiWGfD/FfA=
=SZeJ
-----END PGP SIGNATURE-----

--azndqhggqixbtuj6--

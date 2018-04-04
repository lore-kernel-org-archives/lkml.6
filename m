Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDDHOQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:14:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDDHOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:14:12 -0400
Date: Wed, 4 Apr 2018 09:14:10 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] spi: sun4i: introduce register set/unset helpers
Message-ID: <20180404071410.qhjela7b55oaecuu@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-6-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zut6nqsjatua2up3"
Content-Disposition: inline
In-Reply-To: <20180403152905.1524-6-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zut6nqsjatua2up3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:29:04PM +0300, Sergey Suloev wrote:
> Two helper functions were added in order to set/unset
> specified flags in registers.

Again, the diffstat is pretty neutral, so what is the benefit?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zut6nqsjatua2up3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEe0EACgkQ0rTAlCFN
r3QxQg//QzRrYiuAY5Cxm4evvkiU/H2F6YIQXyyq0mCTeWLBSEfqUc7kS2X15v28
+HyIKvjmEmlj7fv6x4dEg2QfUDwUNpGD2ulcM+2METzOQV3QSA6kpcxzpBkQx411
Ifwx3FbRSqH8ybKnElsamX/CX5cGWfs6rBZsgn/1ZyI151h7JjsvaDcyMnvQ3ux8
y0Hct9RaYHs3Jho441kpzzjVuqZKS1SK8HC2wB71KlLkt/3qy41rlYcY1O0+FvxD
MJPNF+JEjCEhqcBxoaFt+6B4L+gHQmR8q+RaFNdoDD2ZjG5/Z6BvE9nGegNbMDjG
yhcun3Qxny12x6raauM8Jdo4XCVwv+p28VCJBKt8EbKIdhkWUUy2vROLURK2QOQa
CDG4twwPsUyocMCnEcpIt2vwtB6yomwK+RSpiPKblNd3W2LMyXr/ZbmGCgBiJ1Qf
/yN9UGIt50dU/CBAECwY7Ti2ue1aqQyQ9Hl0CYbRg57dWsKR2YvfvSuF37III054
GK22N+TIiKbLtAS9CidYQp4AzsPy5xiavQQ6pZuD1UgmDwpxzVtvuhp/tjQldtu0
yRQ4+8tK/bTn5Odb0vHzlOSNR8qpBXhYrrWcRmhNBsdOyjJdLiFP1ML5KTo/h2k7
liXA/xVG8N74OTY1dlfhVjn27/G8v/5cv6BeSFzvx96JfGtBF8s=
=6lhN
-----END PGP SIGNATURE-----

--zut6nqsjatua2up3--

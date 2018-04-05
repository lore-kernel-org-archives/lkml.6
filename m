Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDENRt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:17:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDENRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:17:46 -0400
Date: Thu, 5 Apr 2018 14:17:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180405131735.GB12349@sirena.org.uk>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
X-Cookie: Last week's pet, this week's special.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
> On 04/05/2018 12:19 PM, Maxime Ripard wrote:

> > The point of that patch was precisely to allow to send more data than
> > the FIFO. You're breaking that behaviour without any justification,
> > and this is not ok.

> I am sorry, but you can't. That's a hardware limitation.

Are you positive about that?  Normally you can add things to hardware
FIFOs while they're being drained so so long as you can keep data
flowing in at least as fast as it's being consumed.

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrGIe4ACgkQJNaLcl1U
h9BmoAf/ahzcFkuIYLDWPJ6YcVmSo2FrEo9db3cgyBVAdYr5Mjc8tfXGcALZWqu6
gfPNrxkvZwpj7AB7XTFeVwr51tYriWPmAbRhBQ/jGH97hovKCQ1Etibg9Sazvdgi
JMdB4P27ZkULOa9E7NFHdKGnf8FEPjhZX7/bXLeGBUII/R4BMQD2uE8DPpBeKtMl
dtfk+gvwHf/n18H8kp9SQ8+BGaZ/jd5hjZcwS+ELHGfNkSe2dCgRt+l/jelx1xKd
evkyGmpaQa/rWzFHqQcjuCPlinwKuoqH26vb/RCD1KDHgeefq/kHwWKzhid5FSfF
QkT8QJXlGj+g2Q5NqwJ4+VbbR2pZsw==
=0+Ns
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

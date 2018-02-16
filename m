Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965634AbeBPMDV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:03:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeBPMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:03:19 -0500
Date: Fri, 16 Feb 2018 12:03:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 5/5] regmap: Remove regmap_get_raw_read_max
Message-ID: <20180216120311.GG5886@sirena.org.uk>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
 <20180215175220.2691-5-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <20180215175220.2691-5-ckeepax@opensource.cirrus.com>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 05:52:20PM +0000, Charles Keepax wrote:
> Since the handling for max_raw_read is now inside regmap_raw_read there
> should be no need for client drivers to query as max_raw_read.

No, they might need to know if things are going to be combined into a
single transaction - some devices have weird sensitivities about bulk
I/O and so the driver may need to know exactly what's going on when it
interacts with the device.

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGyH4ACgkQJNaLcl1U
h9C27gf9FGruca1bJJ8HPUq5QqsxtVWtsbh6dN825ZcshAg27PggFmdvvyQtcvmU
CUdS8sI8dDe/bFQWVy3JJTP5Y387VQIClYQX7rNUO/kaHwr2sCSh478CqE0gIDnl
ea4MOKRgi9XrxacDC3uzejwjamWdUnqV8Fq/br5MjPSYeJWa53PzJZKfz+5l2G8r
1XMag8tVCWmPkgsY2VvVmwhv3SSWGY8zYxqot2sGClxhE2NIboQnoeOU3ltomFVq
lFPtUbc/AoYsEM1taz3YweFgz49XK7yt5TNuUzeCxa4q2Ry3kDeYxiapPYsTZdlQ
Ez58cGEI+8JtUbRJ3k24RpoNgNLRfg==
=jr/8
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--

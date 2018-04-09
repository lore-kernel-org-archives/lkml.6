Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeDIKuP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:50:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57064 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeDIKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:50:14 -0400
Date: Mon, 9 Apr 2018 11:50:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180409105001.GC11532@sirena.org.uk>
References: <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
> On 04/09/2018 12:27 PM, Maxime Ripard wrote:
> > On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
> > > On 04/06/2018 10:34 AM, Maxime Ripard wrote:

> > > According to what you said the driver must implement
> > > "transfer_one_message" instead of "transfer_one"

> > I'm not sure what makes you think that I said that.

> Because current implementation tries to send more than FIFO-depth of data in
> a single call to "transfer_one" which is wrong.

No, that's absolutely not the case.  All any of these functions has to
do is transfer whatever they were asked to, how they do it is not at all
important to the framework.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrLRVgACgkQJNaLcl1U
h9CnYQf9ErPlv8aRIR4+w+dvvkn8OrxLG9toRNkFR0JAiEVl9JIZ1/BGej1IevOx
UiAIIYJAh2coZTAyQGBYGVvuPsXm2YudxIbGRRRvtVKv5ibJ4ze5lG6m0z4sSlJB
Gyx3U0eev6uKPKccVLXBJeRDNdpzAAW0Cwrji9kSct+GaHfBPBfgegq2I1lKl6Mb
Hhm117nHhYmnBstCjlVJEqYAXDfQvtE758KQEjuqF05/HUfJBdtY3QvSCb3/AL68
HYOWAshITARltEQWc11X7+4uaooKvGUmQebGQb5cH4dmLvYQS+uaLpWesDMcosJt
ZLWzxtuTxxyQ9c1C+np2SIdYaL90VQ==
=4EpX
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

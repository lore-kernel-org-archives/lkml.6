Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeBSQ3X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:29:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56114 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeBSQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:29:22 -0500
Date: Mon, 19 Feb 2018 16:29:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc
 on resume
Message-ID: <20180219162919.GH32761@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-7-hdegoede@redhat.com>
 <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
 <e32ac973-fb6a-37f9-ed65-b6865c13d9dd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <e32ac973-fb6a-37f9-ed65-b6865c13d9dd@redhat.com>
X-Cookie: You enjoy the company of other people.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 03:02:03PM +0100, Hans de Goede wrote:

> The is the net/* style of multi-line comments which is used in quite a few
> places in the sounds/soc dir. I think both styles are accepted under sound/soc?

I really don't care, whatever people want.

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqK+14ACgkQJNaLcl1U
h9AcrAf+Oa1kwtn+F3OxjO6vMJ0wlpfaRV4PiBRE00x5nXkIZ5s7TjhBDRIFcueL
9rCVOnG8d5WrFIebs1sSmA5rzc3CotLd51z+iQ3fyuXJ11MjVwKgKHBWmwY7P4Df
UJyCxUsa5ztsXj4CkGubAay4lZVOqgsgRWgvISUHJBQuWAfic3HuwqPBDGSR4DoA
GnL+magPc/QoqbbnVpbsEzuZ+vKonil2IAzUdFSBOMOXt5Lb1Yw3ESIwbgAoA7ib
1eNxjBSse9KK05K5BWHKMjZt0ZBLBkKt1WRFIu1SBcMI66+Uw9DtZnY7/opp7MG9
F2ic4Tft1qhhF/5Ezs5zgyDEIIXAug==
=XXvy
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--

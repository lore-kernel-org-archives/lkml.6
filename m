Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeBSQgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:36:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39032 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbeBSQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:36:02 -0500
Date: Mon, 19 Feb 2018 16:35:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc
 on resume
Message-ID: <20180219163559.GI32761@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-7-hdegoede@redhat.com>
 <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
 <e32ac973-fb6a-37f9-ed65-b6865c13d9dd@redhat.com>
 <20180219162919.GH32761@sirena.org.uk>
 <96d18475-c47b-d3d1-9a65-cd3a056e1857@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <96d18475-c47b-d3d1-9a65-cd3a056e1857@redhat.com>
X-Cookie: You enjoy the company of other people.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 05:32:16PM +0100, Hans de Goede wrote:

> Mark, is there anything specific you're waiting for before
> merging this series, or are you just waiting a bit to give
> people a chance to review it?

It was sent less than 24 hours ago, please allow a reasonable time for
review including from the Intel people.

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqK/O8ACgkQJNaLcl1U
h9D1qwf9EgCMgLlo+4Boxtaqmc4Y87UiklXIyv5F0zXiTgLg5oDhahSk+z/abuAt
LW5zNZtDjsU92Um1DxdJ6f8uBCXNzCLpNdx5FEh20dZqKvkQOIJdFBIUYWqX0n5H
SC2Bchaqqp3rApoNBSAQmNpFj9jjrWN4FKdKjVysIGYa48njnoTwnhHuNTqbx/Vb
LphDIYoUcVFONfyoyrD0eYDLMeLv47pcgFXlQOem8dvagS7jOzxHcsai69V56si8
Bs85Ogr08JuLBPZQpF+HwEeHUxHpa/6gHKDPyaWQ5g9wnjHNbQ11awM1QkFIWWm+
cMZFP2WjWJFOsdq89oiYjswS6Y9AVg==
=HBK4
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--

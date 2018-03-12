Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCLQLX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:11:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeCLQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:11:20 -0400
Date: Mon, 12 Mar 2018 09:11:12 -0700
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180312161112.GC2186@sirena.org.uk>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
 <20180307102006.GA7290@sirena.org.uk>
 <5A9FC3E0.5020600@rock-chips.com>
 <20180307105731.GB7290@sirena.org.uk>
 <20180307165405.ltuobrr53vko4do7@dell>
 <20180307165738.GK7290@sirena.org.uk>
 <20180312140742.vazjujloyn5l72nu@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20180312140742.vazjujloyn5l72nu@dell>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2018 at 02:07:42PM +0000, Lee Jones wrote:
> On Wed, 07 Mar 2018, Mark Brown wrote:
> > On Wed, Mar 07, 2018 at 04:54:05PM +0000, Lee Jones wrote:

> > > Is that an Ack?

> > No, it looked like the change was only for MFD?

> Right, but you can still Review/Ack patches from other subsystems.

If I want to ack something I'll do so explicitly; I've not looked to see
if what's being filled in here makes sense or not.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmpqAACgkQJNaLcl1U
h9CfzAf/UPLGxgUQOjT9hXX5+DaJ+MFvy+7DeFFK9488x4FMPxOJOPF/MiF40a0y
9ZCdfqVuBu2PVI0psbxC3xjFx0K3g9TySLzqdoUtcqm0byzIc7AVDEzRECq7cc1z
BDb0DzmudW7c2nVrs4BwwC79hFPbcl09bPRwnELwiuKsgKRDLZ1zakp2gxmmLLB9
tpV1WInW0g4+Zy30NCSyHDLXfszP+ibBw9Wqh+oAmVJLeT6kIM+xT1adJAGAzORQ
aK5kHSYycsIw0WQpR611pirogZMaeS4e0mgkLtl38qC+ovEQlMG0wDZIk9Z1xlla
MSuYfMeyniPuPiz7QBvOCXMzHlruCQ==
=PVm2
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

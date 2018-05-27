Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeE0SnK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 14:43:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeE0SnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 14:43:06 -0400
Date: Sun, 27 May 2018 19:42:43 +0100
From: Mark Brown <broonie@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the userns tree with the arm tree
Message-ID: <20180527184243.GC1564@sirena.org.uk>
References: <20180525101455.GI4828@sirena.org.uk>
 <876039uf30.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <876039uf30.fsf@xmission.com>
X-Cookie: Adapt.  Enjoy.  Survive.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 27, 2018 at 01:29:55PM -0500, Eric W. Biederman wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

> Mark.  Did you get a bounce from this email?

> I saw this when perusing lkml but I did not receive a copy of this
> directly to myself.

Turns out xmission has decided to blacklist it, no idea why.

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsK/CIACgkQJNaLcl1U
h9Ctxwf9GhO0TJ6O2FeYv7ESn17kjOnWIbBmsfafM+G6A7ki6baiB631yF6EEpFT
ubUaaqulHb1sR/3kmlgDeFtbn2cvHnOqghM0iBEPTvvmVDnZeibwaG6his1/Ogvm
I7sxde7CZP0ujpeuBdMD8k6XLM5bpJ45f4sYQR+nzI0bHOyR4k2hRkhzAlvGER0P
nWR4UAa0jrVdEFoeNB/2akdjimFMPe2pMzGwBxbB58tYZiMg2Sm7BS9ZuCpmnvLq
H9i3QREmRR69kvVA6aNl46rmPKr4aIMVEtYzw1GZbveSrna1T96mlpNAXUwQVDQU
RNdoZKKgNSs8/txcxiYzTTTacyC5rw==
=DQNc
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--

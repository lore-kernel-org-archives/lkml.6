Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeEQQpH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:45:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59204 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeEQQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:45:02 -0400
Date: Thu, 17 May 2018 15:38:06 +0900
From: Mark Brown <broonie@kernel.org>
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: jun.nie@linaro.org, baoyou.xie@linaro.org, shawnguo@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/45] sound/soc/zte: remove duplicate includes
Message-ID: <20180517063806.GN20254@sirena.org.uk>
References: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s8J8qjRpxLkp1Gun"
Content-Disposition: inline
In-Reply-To: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s8J8qjRpxLkp1Gun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2017 at 12:02:03AM +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--s8J8qjRpxLkp1Gun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9I04ACgkQJNaLcl1U
h9ARbwf+P2Oq3YquIZNXfw6884eu6+lDJUqPTUX0v8jSNNaMD65j8Z0dgLZrwSiA
LxlvM6f5Y+Tym+YmVibhKn2PaZ9MQBO90cvsccAiKEYx++L+ngyR9xmVtic4FFHD
XhpEW3/PRKcDn5vRJTm4xbbmdtpsKl1p95oslh9hMqNOXN36ylBwYbinZYNkovPc
ouhNFVlgJ+QY+MA4FVrxUkEfa/iIsi6lDOVha6hzOAy4rzRzWjSl0yqXj0ROKQvn
8m2ZzVZyfDSqnXuI6OuaqdkJJiga5SibKaa+mmR7wjezuc5YkaFXk5GAO48xUQev
9HhucI1oAcImvrDZxwv2XoaR4VLEiw==
=6Dwl
-----END PGP SIGNATURE-----

--s8J8qjRpxLkp1Gun--

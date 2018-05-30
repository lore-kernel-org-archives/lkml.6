Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969010AbeE3JNb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:13:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41714 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968939AbeE3JNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:13:23 -0400
Date: Wed, 30 May 2018 10:13:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>
Subject: Re: Regression in Linux next again
Message-ID: <20180530091314.GB6920@sirena.org.uk>
References: <20180529221501.GJ5702@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20180529221501.GJ5702@atomide.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 03:15:01PM -0700, Tony Lindgren wrote:

> I think I bisected this same issue for the second time now
> but for a different merge window. What's up with that?

Last time we just reverted it as Maciej was unable to reproduce your
problem, he's tried again with some alterations.

> Reverting both patches fixes the issue for me. I could
> not debug it further because of the compile error(s).

OK, unless this gets fixed really quickly I'll revert again.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOaykACgkQJNaLcl1U
h9DNKAf6A0cfH/nhMzM3k9/MWcbGVsNRHfchze+CTrnz41nIssZ67o04CMO8TLL6
bpchJj0JLMrn6J+nEQjPqIyBEh9RaT7ZkVdb6ysmyEPCBRLDQgGCI43CFMitjrRd
aqo05BcVJIDL5Ljjf0cr+HOl6vmbI/WGYkMLsR0JTELe3C3ZdMHyBbIUiWF8kX42
ZPBVKFZhZO/lY4rjhZO43O7mCmF8e+vZSQ9BxLqaYurkcZTtB139J8HIWFfA9HBQ
fQZgI56qiJY+GxCDZQ2SQCMqeND6ZUH4+WlCh2UMlKP101jEVbvGObwkRPc4QhtP
6WhUeUkbCpGY8LoQvr3UWi/nsBw1VQ==
=0dPJ
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

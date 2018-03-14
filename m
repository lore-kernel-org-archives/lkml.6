Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCNQMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:12:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCNQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:12:26 -0400
Date: Wed, 14 Mar 2018 09:12:12 -0700
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 15/47] ASoC: remove blackfin drivers
Message-ID: <20180314161212.GS2186@sirena.org.uk>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-16-arnd@arndb.de>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 04:35:28PM +0100, Arnd Bergmann wrote:

> The blackfin architecture is getting removed, so the ASoC drivers
> are all obsolete as well.

This is going to cause loads of conflicts due to the ASoC platform to
component refactoring - can you send me something that I can git am
directly against my -next please, it seems better to apply it there so
that nobody needs to see the conflicts?

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpSdkACgkQJNaLcl1U
h9DaIwf/Tv8pWYVLPMnlGBNdlg5uS4LTtoickmYdhGauOa2y7kLG1t17zEDR7pvb
SvDAtQ/nvUYSF5TJ/It7LN47nus4ZDWBndvxTuEDTYA8un6k0LRN/Hn6noRZE0ka
tKvtLoFDD1T/Ul9KcCqTuUvz+YgIAPMNeFZxemt0A0cHAHioPPJUDUFPVlq5YUCj
GHdmBScRazZuW+ZV4pbziqX81DNzW1uTJOTAaGCqO0OpG1ytuQHAcFNkGRb8t7Mn
iQgxEJcuQo4WyaeiD6Vb3vvvjBUcc88iRQDAds8PdsUhXg7ke7vwiAY1LLfBXt7f
uMdXKFH1sWKYRsrqDquP4ERX8oPEGA==
=hEr4
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--

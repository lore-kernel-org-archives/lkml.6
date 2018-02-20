Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeBTMlK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:41:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeBTMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:41:09 -0500
Date: Tue, 20 Feb 2018 12:41:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE
 suspend_state_t
Message-ID: <20180220124107.GD6378@sirena.org.uk>
References: <20180218170424.11976-1-hdegoede@redhat.com>
 <20180219113444.GA32761@sirena.org.uk>
 <5486ab34-4e5b-e2d5-9475-4d7e24a0cda6@redhat.com>
 <20180220114759.GB6378@sirena.org.uk>
 <066afd48-896f-b8fa-0bc0-7e3b0b76e33b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <066afd48-896f-b8fa-0bc0-7e3b0b76e33b@redhat.com>
X-Cookie: Don't read everything you believe.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 01:12:08PM +0100, Hans de Goede wrote:

> I might just be looking at the wrong place and if so I'm sorry, but I
> don't see any (additional) fixes related to this here:

Seems to have got stuck somewhere, sorry - pushed now.

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMF2IACgkQJNaLcl1U
h9Aw7wf9FSReESPP0gGN+B6L9igxFyNzcwbLOXSdwbMy92t7cvncxWsr9yNSMweU
BgXBhre0Kxbk5YMZPQ90ge26SMhfLXPoqsD3G4L3JoTn+BxGW0LGVn2nl0mUpwdK
o9+3RD5y/2OAqHwZXCRvwgmhebXtobtSjrJlUWkWdTmD3aSK5ZuxM8EVtQ2WBh/p
Qj/AtSTriwZCmQWCb5UOCsnnlVIs266locbeS/BjiAOdmVNEUsUo7wlyk2o9rwmT
l2Rw6sbjSZLGgyZkLL95TT8VK1uYd3Ajuq8Fi64O+6w1t3Yhswkroo3TH+7ZpXQq
tFyyLjRuKpc3AeLJktnOIxot1mGN/Q==
=Q2el
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

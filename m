Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeC0Lho (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:37:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0Lhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:37:43 -0400
Date: Tue, 27 Mar 2018 19:27:38 +0800
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180327112738.GA29239@sirena.org.uk>
References: <20180321133040.6754c372@canb.auug.org.au>
 <20180321024556.GX2186@sirena.org.uk>
 <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
 <20180322013817.GY2186@sirena.org.uk>
 <3d47f2cb-0a73-98a7-bb3a-f40baf00123b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <3d47f2cb-0a73-98a7-bb3a-f40baf00123b@amd.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 11:24:43AM +0530, Mukunda,Vijendar wrote:
> On Thursday 22 March 2018 07:08 AM, Mark Brown wrote:

> > You need to mention dependencies between patches when publishing and I
> > don't seem to have a copy of that patch, according to the list archives
> > Alex asked you to make some chnages to it.

> =A0=A0 Changes suggested by Alex already implemented and posted .
> =A0=A0 Current patch (https://patchwork.kernel.org/patch/10298281/ ) is
> =A0=A0 dependent on below patch.

> =A0=A0 https://patchwork.kernel.org/patch/10296597/

I'm working offline so these links aren't doing anything useful for me,
sorry.

> =A0=A0 We will publish patch dependencies while sending patches.

Please.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6KqoACgkQJNaLcl1U
h9Br/wf/exHUVXi7lUJ3wD96w9SKGEWKII1Y/07TDLuCTiWBPrrCLU77xLo0ivMD
jzEm+jV7FfRDmuET5DCtMVPMf3OcSTGJyhAXMlvlJL+ajZLZB2jAMY960kpjfXz7
TTNMGGYRp+TqnuKoONi1RV9fSleWMvAfmbwMDxcLZa9kAgHnrof8k+pt5mEVHVeS
AlnBl329IIjFG1J6FVeZM7P4Fe6PFvyY+Y1UPd2xOyuwi/HIfjvgjFp8y/aSHwAc
JGU3TdG6REmmhagU079BGfHMkVUrng2MaDsdd7NrdyF+A0nsV5KeF2dqDOeu0hNF
1rVIUtSb+YF5zS/yK3ip3J4Dj7XoBQ==
=HAxy
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

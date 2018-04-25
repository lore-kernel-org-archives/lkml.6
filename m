Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDYL4t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:56:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38478 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeDYL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:56:48 -0400
Date: Wed, 25 Apr 2018 12:56:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Baolin Wang <baolin.wang@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Ingo Molnar <mingo@kernel.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com,
        Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        subhransu.s.prusty@intel.com, Bhumika Goyal <bhumirks@gmail.com>,
        gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>,
        hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Fabian Frederick <fabf@skynet.be>, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
Message-ID: <20180425115603.GE24769@sirena.org.uk>
References: <cover.1524570852.git.baolin.wang@linaro.org>
 <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
 <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com>
 <1b6a0710-7bc1-08d1-49a5-f1bed7bf3f84@perex.cz>
 <CAK8P3a1P8+DDmqSZquFVUn7C7F7+8M=Xft+wbY_H7a6ptfXJeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1P8+DDmqSZquFVUn7C7F7+8M=Xft+wbY_H7a6ptfXJeA@mail.gmail.com>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 01:26:23PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 25, 2018 at 9:23 AM, Jaroslav Kysela <perex@perex.cz> wrote:

> > We have almost everything hidden in the alsa-lib code for the
> > applications and there is the protocol versioning, so we can detect the
> > changes easily and handle the new fields in the library.

> I think we are both misunderstanding each other here, let's try
> to work out what changes are required in alsa-lib. The idea of
> Baolin's patches that you can simply rebuild alsa-lib (or any other
> library using the alsa kernel interface, if any exist) against a new
> C library and still have working audio.

It's probably also worth mentioning that there are userspaces that don't
use alsa-lib at all, at least tinyalsa and salsa (if anyone still uses
salsa).

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgbNIACgkQJNaLcl1U
h9DwRQf/SiHEyGNOdmvMxSBoGCeWhqhleQcnDqZcE9DyIOiIuILQm/IRLAbaUMr3
4fQfOaCrMgc6jopN5ICVt6NkpMdtEyQOW0eUzaQvw6jY7fSIBOKFW1qJcvkQ9UFU
HEdGLn9ckOTDAalDnE74YjiKD7pMFmWxYCr4OXd1r4m0i0Pcdb4i37trbT2x+EGU
NqmIAnJBqMFryKa2YqgwapNWg0gqcUrrmPMWUY+cNoUfhgJkglzMh96D3doAWNXW
umPUIPJKWeiCdKLyVTxpS8bT5jbaqq9bsSbve5ic+gp74Drsi/E17wU0nl2GWIIs
uh3sjhQH4Yfjh1YC7+sTA1HOTZcnFA==
=9ZE8
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--

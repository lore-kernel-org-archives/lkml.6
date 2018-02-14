Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032421AbeBNQVK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:21:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032203AbeBNQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:21:08 -0500
Date: Wed, 14 Feb 2018 16:20:44 +0000
From: Mark Brown <broonie@kernel.org>
To: abhijeet.kumar@intel.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Wang YanQing <udknight@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>,
        Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: hdac_hdmi : Ensuring proper setting of output
 widget power state
Message-ID: <20180214162044.GG12658@sirena.org.uk>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-3-git-send-email-abhijeet.kumar@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <1516728657-21522-3-git-send-email-abhijeet.kumar@intel.com>
X-Cookie: Who is John Galt?
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 11:00:53PM +0530, abhijeet.kumar@intel.com wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>=20
> In usecases like hot plug-unplug DP panel or modeset during a playback,
> sometimes we observe no audio after codec resets. During no audio
> condition, we have noticed that the power state of the pin or the
> connector is D3. Optimizing the way we set the power mitigates the
> issue. With this changes the verb is sent to set the power state and
> waits until actual state reaches target state. Thus ensuring power state
> is set.

This doesn't apply after the recent refactoring to move to components -
can you please rebase on current code and resend?  I pulled Takashi's
branch already, it's just this patch needs handling.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEYdsACgkQJNaLcl1U
h9AKRwf/aQYOadzpRuSjf42fRFhP2JSNlDePo5T7mc4pa7lS8Z34vkFRjgu7ookh
Vd0DuYjtwlHIX3MFoL+00b+t6bhoTjBk31eXVggmEFhclqMVg0qb3lbDBGGqzndN
Sl3/OOJXtZBnXJHTYr7OhPxxG+IgguVfft0g/kD5GPj/njiB3Jrhszws5gyvXgUO
hwdWheUfDlQDwSToi5vR2mwdM7/rvV0hWN2420bE8TzEcdA8wtDDHrpeTS5ySyaK
pRYVo2hliN+MRIXRTvcenu11k2+5PGxWWJ10EfGf3zi5gUO6bFLpjKLYmVVkWC0m
JvtC6wnprmOWyPPnB4sBizNNJfP6MA==
=2HsW
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754823AbeEaLt3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:49:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbeEaLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:49:28 -0400
Date: Thu, 31 May 2018 12:49:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 16/21] ASoC: max98088: use match_string() helper
Message-ID: <20180531114921.GD13319@sirena.org.uk>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
X-Cookie: I've read SEVEN MILLION books!!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2018 at 07:11:21PM +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.

I don't have either the cover letter or the rest of the series here so
I've no context - what is the story here with regard to dependencies and
things?

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsP4UAACgkQJNaLcl1U
h9ARWwf/eXONi0P5tRYseDnx7xeRNPi94O9wUx2+o8n7BSELbY9Plpo2s6YEW2U0
37zqBaKzT+6Q95eYqGXDzAQPhvmsogWRUC6xRGu4pf1Q7giYLed4wq43PP4DGpSy
262Z00PayoE3OqdbdZgbo6dKLAgjyDpVvl39ARX4p2KlgOwv2EUg2GKhtkaXvrBC
f89Bf7is6X6gF3Fn6b5FHTdEcOK0mFptZAt6pFpq0g9LDNCG6W5YV3LgBA5pVl6/
JCg63Tg0E0ASAfWwU+y8HxKB4/Jzhxn0Ig0Pvc6p158nBtsfX9XY9kGDudzeprtb
UR5XRWsBWrRh2AeDYv1cxofuupb0dA==
=bLKf
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

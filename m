Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeEWIYm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:24:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50248 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754153AbeEWIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:24:38 -0400
Date: Wed, 23 May 2018 09:24:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Guenter Roeck <groeck@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Message-ID: <20180523082424.GA4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 02:59:35PM -0500, Pierre-Louis Bossart wrote:

> I am also not convinced by the notion that maintaining topology files is
> only a userspace/distro issue. This would mean some distros will have access
> to the required topology files, possibly enabling DSP processing
> capabilities, but other will not and will not be able to enable even basic
> playback/capture. Just like we have a basic firmware with limited
> functionality in /lib/firmware/intel, it would make sense to require a basic
> .conf file in alsa-lib for every upstream machine driver - along possibly
> with a basic UCM file so that audio works no matter what distro people use.

The point here is that people should be able to update their kernel
without updating their userspace so things have to work with whatever
they have right now - anything that relies on shipping new firmware or
configuration files to userspace is a problem.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFJTcACgkQJNaLcl1U
h9AS4wf+NiCBQ9NPvTyXDKTk07Ae2ufTmBc4iMUvFK5il01eXr02pmf2FtRRodk0
M9R1BVCtmPBDeruSIAbnA9x+u6SUxWwszTbDp6AL5p7oz5VjyJ9o9XBcWcvXKivy
iB3uIommTHeY+9ESd3HBO7SI2UfZtgpVxa9pqYWpIlUyjpeAq7UwN34qbqdmuRu4
tm8n3//+hp09MfiixFoWmOdfbNPIh8iz4sPYSzahAYZ7fYgN355eOE4yLDuZPB08
DsXRyGBqHWD3uIaleZXIvyatKjyJI1uLpS8xb+E64ntcblwh8ph7rrf3Ojb44PCp
6FXCx4HBw1TNTzECC11WsQ8FvZt6Cw==
=m9Pa
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

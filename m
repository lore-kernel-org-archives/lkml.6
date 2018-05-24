Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031669AbeEXOSx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:18:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030532AbeEXOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:18:52 -0400
Date: Thu, 24 May 2018 15:18:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180524141842.GW4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
 <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ItroYk2LVxvwOvi/"
Content-Disposition: inline
In-Reply-To: <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ItroYk2LVxvwOvi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 09:17:23AM -0700, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:

> > I'm saying we should move them there.  They're clearly part of the
> > userspace ABI and therefore belong in uapi, it was a mistake to let them
> > be elsewhere.

> They define a firmware file format. Not sure if I would call that userspace
> ABI.

It's a binary provided by userspace to the kernel, I'd say that's
clearly an ABI.

> I don't mind adding the structures to
> sound/soc/intel/skylake/skl-tplg-interface.h,
> but it seems a bit out of scope to tie this with moving the file to
> include/uapi/sound.
> I think that should be a separate discussion.

Is there some reason not to just do it while we're looking at this?  I
don't see why we wouldn't want to do this.

--ItroYk2LVxvwOvi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGycEACgkQJNaLcl1U
h9AdLwf/QbknuFoYVCNkUSaND4yd83yRRB4Dk8wpC2M92DJnv1h1OoiUpHN6It9L
h4Tq5K9sK7QzJUiQZ8RN1upzl8YWg/Ar0M/op6APK+vXBliyf24bJBxa1aFXYIJ7
pUs4MAWX5eR3Xz5BbZXTjt4gX0E7/Ur6MWlUdfLjm44q40mGtRjKAySfquWOYZ4v
U1p5Jr3LV9sUZRH/vKGyjWlgd/5bAvxAtRRZfqdFU99bhLhl/NilEbPSMVDjh2Gv
vCMkJj7GvlFZ2hcuCUNt3hHGQ1jgMTF3Q6UyppfxoHLyeBX84abeWxrnu3QbXrpm
vZY4UZuXuU6yF4kWzwVkaZ7iUD9J4Q==
=ukzP
-----END PGP SIGNATURE-----

--ItroYk2LVxvwOvi/--

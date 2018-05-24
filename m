Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970879AbeEXPL4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:11:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968131AbeEXPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:11:53 -0400
Date: Thu, 24 May 2018 16:11:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180524151137.GY4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
 <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
 <20180524141842.GW4828@sirena.org.uk>
 <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OEa2bCMk+rg6xBXy"
Content-Disposition: inline
In-Reply-To: <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OEa2bCMk+rg6xBXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 07:55:06AM -0700, Guenter Roeck wrote:
> On Thu, May 24, 2018 at 7:18 AM Mark Brown <broonie@kernel.org> wrote:

Your mail client formatting seems to be broken, the word wrapping is
really funky (it looks like it's breaking longer than 80 column lines in
the middle of paragraphs rather than flowing paragraphs within 80
columns).

> > > I don't mind adding the structures to
> > > sound/soc/intel/skylake/skl-tplg-interface.h,
> > > but it seems a bit out of scope to tie this with moving the file to
> > > include/uapi/sound.
> > > I think that should be a separate discussion.

> > Is there some reason not to just do it while we're looking at this?  I
> > don't see why we wouldn't want to do this.

> I don't mind doing this. However, keeping the change local and in a single
> patch
> would make it easier to backport, and I think that the ability to backport
> would be
> essential to get more than one-person test coverage. I also would have liked
> feedback from someone at Intel, at least for the Skylake specific
> structures.

Oh, of course - I'm just saying we should do this, not that everything
needs to be in one patch.  Obviously the code motion would be a separate
patch.

> Anyway, what file do you have in mind for the structure definitions, both
> for the ones
> in soc-tolopogy.c and the ones needed in skl-topology.c ? Everything into
> asoc.h,
> or something else ?

All of those that can appear in a firmware file, I don't super care
where they end up but possibly a separate header file or files to the
kernel specific ones as they might get used with Windows.

--OEa2bCMk+rg6xBXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsG1igACgkQJNaLcl1U
h9BPwgf/eVjK3Vi8LMSAcq3hLEUdx7AYPevQdzCZ6kkbjU5TRNe0ioVmn4AUh7/D
TkzhNC/FsRufNoR/MOo+Ut4+wD8r6MshEnc9tjHbSjKLS75CyCuMTbHTSHKSqx4+
+ozYYDt++wJIa93KDs4rSKQ83deRFmkVo3EdIJkoIbYOfde3m5UQtngtXGB+YWDR
KfwLjh61MQVD4M8gI8CzI2r8Bk0batRJaNEEB793ONqV/xjoB/ShsWrRf9YZkfLN
3VPzmjTZt6+oDiUSHARRh4SXSTPAiYecWlh5ww7IWcjJceQoVE0A34b4HtLJoHS9
Bplb9zSEMU1UhEQYziVkP+KzndXrrg==
=f0A1
-----END PGP SIGNATURE-----

--OEa2bCMk+rg6xBXy--

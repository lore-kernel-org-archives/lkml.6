Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDMLTf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:19:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbeDMLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:19:33 -0400
Date: Fri, 13 Apr 2018 12:19:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Message-ID: <20180413111927.GC6854@sirena.org.uk>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
 <20180412211437.21599-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20180412211437.21599-4-peda@axentia.se>
X-Cookie: You were s'posed to laugh!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MAX9860 Mono Audio Voice Codec
>   *

Please don't mix C and C++ comments like this - it looks unintentional
and messy.  Just convert the entire comment block to C++ so it's
consistent with itself.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQkj4ACgkQJNaLcl1U
h9BenAf/W/JDwlbxh9fUKL63ITIAECbCWfVFrPyFMGalYh/tM3Gt+w4aSNENJa1P
Eu6RrNVVhreEr1TN1GcJzPu5o84WHMGSBQRsBRWM7VFzfE46TByeMAq23FhBZUTl
UXCEXc4gGpMji0GqWWDF2gVniWIXQBquaDv1+96YdrDCLCmKs5SSABktrO8daHDy
7GRbovvhdqlaMPE76RYm4W+xnePcNwxqpTNKW3/70MGJR63M04May65NyRRmqNZp
YFhUYinQZ+43UTCX3mBkfYBqmVUC9EmG54e3pot/2IrcLTT+hK40KvWqGHdMr09A
NRJg712HVhRbMSYG9qzDBldAC0a0yg==
=9021
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

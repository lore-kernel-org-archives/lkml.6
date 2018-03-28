Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeC1Coi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:44:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeC1Coh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:44:37 -0400
Date: Wed, 28 Mar 2018 10:44:27 +0800
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH 3/3 v3] ASoC: TSCS42xx: Add CCF support to
 get sysclk
Message-ID: <20180328024427.GN29239@sirena.org.uk>
References: <20180327175040.GA26604@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline
In-Reply-To: <20180327175040.GA26604@t7-ThinkPad-E560>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 27, 2018 at 12:50:49PM -0500, Steven Eckhoff wrote:
> The TSCS42xx relies on set_sysclk to get a unique clock id and rate,
> which
> prevents it from being used with the simple-card.

I'm missing patches 1 and 2 of this resend.

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq7AYoACgkQJNaLcl1U
h9BqWwf/XFltXPVpE+9oCtx/BdFm0tGKdCQ/Cfy5SJhwpuB0EYm7RTOk2ht3819b
ogV0oJguUQZANVtlU1zbT0GzjGzOQx3RuAOK1TKfW53K3Gdw5CrxV8GcaEmM3lRK
BxGjtMuM5sIBVsZWK+8B3PSQ31PCmoxTxTuB0+FBKfpodMeK2al8cic0HuThLZ/0
vom8sAtR/HlF/d+XMgoT09I9LqEYrRZtLY7r7VbUqXrXQhNkWAT+2ir+awWpknOI
EdfWSDCS/1fBes4o43YcY+qrEmnGZZQFu/x6J5PLSiDt6nY3FUIs5IrC3/IczjcM
Coj0UDuL4FHS15GOqk1eMGP9wjFs2w==
=Lsi8
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--

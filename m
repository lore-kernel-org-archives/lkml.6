Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeDXKUM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:20:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56848 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDXKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:20:08 -0400
Date: Tue, 24 Apr 2018 11:19:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: tas6424: Allow disabling auto diagnostics for
 faster power-on
Message-ID: <20180424101953.GA22073@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
 <20180423154411.GK19834@sirena.org.uk>
 <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2018 at 09:00:18PM +0200, Jean-Jacques Hiblot wrote:

> I can't think of anything that would make it unusable.
> This auto diagnostic is really useful in cars where wires can get
> disconnected or shorted to ground.
> In quieter environment it may not be as useful, and a test at startup may be
> sufficient.
> Diagnostics can also be triggered at will.
> Do you think a sysfs interface would be better suited to disable the
> autodiag ?

I'd just make it an ALSA control TBH.  sysfs should work as well though.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfBMUACgkQJNaLcl1U
h9AmdAf9G2hWHGY7WD/hfxizWfpUaXImjYIXNKDx+C5ZRJNzNR0J34RRiOi4l7R9
PCD9FYNShJiWygRKrE8XhNbLouhXw6M02W+7zjD2Hj280TLTbg4JcH/IpwPvgwER
ZWiRyWLsm5CY/TwM9HqBhDTfSZWZuC3hLK9fWezm1HCkFGZyQA1b34Bg/7ZdNbDH
rRpL1vN7cWoNiESP7GPikmCDyVI8sU5BPV6mfu9yW1C72wcsy6KTZ+uTRyKc9F1z
qXsvHUpQtwktIDPXe+u1BKbRLO69y/unfgrF97ANFii5ziWYLh3lLwUg9ZSTbM9R
PL7Nuh2gZaZJIilyxvbiHg7pfuGkzQ==
=2PQK
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

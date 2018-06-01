Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeFARJZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:09:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55590 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeFARJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:09:23 -0400
Date: Fri, 1 Jun 2018 18:08:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Message-ID: <20180601170847.GC8677@sirena.org.uk>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
 <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
X-Cookie: OS/2 must die!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 10:19:58AM -0500, Pierre-Louis Bossart wrote:

> I wanted to ack this patch but the Intel validation folks asked for a cou=
ple
> of days to finish their tests on a variety of Chromebooks (e.g. Lars) and
> double-check which models used the v4 topology. There is an internal thre=
ad
> on all this which remains active. I don't think the feedback will be dela=
yed
> beyond early next week.

OK, I'm expecting the merge window to open over the weekend so I think
I'm just going to apply now so we it's in -next when that happens. =20

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRfZ4ACgkQJNaLcl1U
h9DtcQf+MLxA1Y7K9CWrSgFsWQtI23eljjg88XksXgCBs/1EEiyYXLmu7dVRLg+k
5jxgxM98qG7M94RxNycoGLTa/IreTk5RdOBwLR/x7Y7G1/TYTbhqu7Bas0i0fAGv
oVdi45AKtB8ummzQ180IVoeObPo+dMoBKLnTp4hRYumFwG8/BCOZo3ekj6yjXJak
Ki66YWqsOp0DozBHl0Ezirne38FK27CtiJE0ze6iqR/7tX2MqExzfX+2AYfPlwLY
zwRJS1T3rnZkrrQ0lpKmphaFH6nqZVvWGjXaS90me5pQdsubukm5Gtxu0dmDAko+
Zn0+hBNs15Zdz0mb2teeUD/vuNpoHQ==
=huYi
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

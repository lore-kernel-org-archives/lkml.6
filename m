Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeDMKl5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:41:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeDMKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:41:55 -0400
Date: Fri, 13 Apr 2018 11:41:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a: Replace
 GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Message-ID: <20180413104130.GA6854@sirena.org.uk>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
X-Cookie: You were s'posed to laugh!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 06:46:21PM +0800, Jia-Ju Bai wrote:
> broxton_audio_probe() is never called in atomic context.
> This function is only set as ".probe" in "struct platform_driver".

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQiVoACgkQJNaLcl1U
h9CQPwf9EQIfFL7w6d2apKyJctMJiogjpDcKmRDZkAvAXXhZLRkjYE9+JADLxpi1
s4ClYXhU1ggARiyLLXGRnWDRCYY7Fh67huCBpKkf5GDPAbC2tAvOBAtbVN9Ex50Z
PFyzkOW9bENfM3RgdlXP3Sql00XrjNErjrl8Daw+STmlORzXsGLzZZDZH3owI35Z
cwQ4qzqaMjB5O9EWlse1EJla911Kf6xYjVGeTQw91C4nLxg9Nm32YjBhp4iSHjqW
1AFBB2L9fmTcWaPAEgmnMlnWE6NGZBdcpXvYSvfkJbdhg0lpp0vE728pykUDmAxz
rHtKyUeHTsw/59UOl5cQDGs19HtB/A==
=D/7C
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

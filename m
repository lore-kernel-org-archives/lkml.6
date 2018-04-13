Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeDMKzv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:55:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeDMKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:55:50 -0400
Date: Fri, 13 Apr 2018 11:55:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a: Replace
 GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
Message-ID: <20180413105541.GB6854@sirena.org.uk>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <20180413104130.GA6854@sirena.org.uk>
 <32138b5e-843b-3f37-28ee-62d7fa93f0db@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <32138b5e-843b-3f37-28ee-62d7fa93f0db@gmail.com>
X-Cookie: You were s'posed to laugh!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 13, 2018 at 06:54:15PM +0800, Jia-Ju Bai wrote:

> I looked at previous related patches, and find the subject should be "ASoC:
> Intel: ...."
> I will follow it in my future patches.

Right, that's it for these thanks.

> Do I need to send V2 patches?

No, it's OK - I already applied them.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQjK0ACgkQJNaLcl1U
h9D2vwf/VXf0+ZvsqH9UHwB5oQcc4hObpFgXuCGvV0wds7WQeQZ4MjjKWN8giOfP
JOVAnKmDbwqM6vCkCOZcuq3wplGZuOoi8CeCvOMzwfdRm94nyjLXwv2CAyz7BZxo
rJNeU9B7BqYtG72QHOY5Dhu5VWU/zO1Yvck2+HvpXCGWIFFXVMKOKZv2+qUVeh0j
uThUaiLIQ6SnxlgVpBaFf85sDVXLmrIJyvJTUD6aHqryqAVeoger1DQPz6PqAl8d
vwWILBnjUEb5Cul5O1KD8Gb1jrx416/bUSitu9mCf2LqC2N/z1FSgQDBL42LEM+w
9fkX6GdkS8OwbUbG+M+f0z4JzyHYqA==
=zWrb
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

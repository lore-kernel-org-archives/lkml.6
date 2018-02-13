Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeBMLmQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:42:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934078AbeBMLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:42:15 -0500
Date: Tue, 13 Feb 2018 11:42:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: linux-next: lots of merges in the sound-asoc tree
Message-ID: <20180213114210.GA5988@sirena.org.uk>
References: <20180213093857.2fe78090@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20180213093857.2fe78090@canb.auug.org.au>
X-Cookie: Blend until smooth.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 09:38:57AM +1100, Stephen Rothwell wrote:

> I know that you usually like to keep one topic branch per soc and then
> merge them all, but currently your tree seems to only contain a couple
> logical changes (platform to component and codec to component), so
> surely that could have been done in (maybe) 2 topic branches and saved
> large number of very small branches (often a single commit) and a large
> number of merges.

If you look at the changes that are per branch (one series is on a
single branch due to dependencies and a lower change rate) they're often
relatively large and likely to conflict with further development that
gets done.  This also lets me drop anything that causes problems much
more easily.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqCzxEACgkQJNaLcl1U
h9DcmAf/fGU128bubp5fQpFD3wfSSnTt923yZJM+bCEUewOLSD/7jOHiN3w5WkLw
x0dzWTk0yRzS7CVZhQ7/5UKJII3AfYidIn+FAxbB7/tUz+Oyv49pXgkr6bpbl3+s
3h+9aI55XfeXF2Q+jMde7gqhRldPXni1YX6gmbO57X+rTIo34ArTvHg6fN+cLjgS
iVBnpv8bsEdAJeoHL6FYzigWS5oRdiMefKla7MNGcOxSeWs/9DJNeohEx9i7A5dU
ziWjTKg5OBrgiANMoFc8CmYUvEBQ7I+4Kf6hR5Os5O/ctCvim6xf3Nnhm9l9cyxk
XBS9vnC07R4lee/I2NVy9HtLPNJzfQ==
=p2vJ
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

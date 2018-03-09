Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeCILOj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:14:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeCILOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:14:38 -0500
Date: Fri, 9 Mar 2018 11:14:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Message-ID: <20180309111419.GA5252@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <20180302124050.GF6255@sirena.org.uk>
 <26212674.B0xcQEiVyd@jernej-laptop>
 <1832733.mujlD9skaR@jernej-laptop>
 <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
 <20180308111348.GB6019@sirena.org.uk>
 <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2018 at 11:49:18PM +0000, Kuninori Morimoto wrote:

> previous my patch used new flag (= .alloced_component),
> but I think it is not good idea.
> And I noticed that snd_soc_add_component() is
> also calling kfree(component) (= has same bug).

> So how about below one ?
> I want to post it instead of previous.

That should work also.

> # I will go to ELC next week, thus posting patch will be
> # 2weeks later

I'll be there as well.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqibIkACgkQJNaLcl1U
h9BdMwf/dgi+zRusODM3QHazDsSRySwq2A6zHxuxsw4nCcucFQr+cM4Ai6+znXV9
iDL6Ex3x39TGs2viCeuD/5V7Tq2YFmXvVpBkokjEzcUSVF1Np4fILcJZNb4KQSIq
0gBSCOSgrlIjmdkL4k69wLowg7V9ZNfJvOUlmDCr9/kjZjw4cwew8Xe++eQ9OdlY
TYbE21c1swh7/tZRTufgVXjdJyYBY8WxyqC6SerK8HeZXOV6Apv/ITk/8xSTqZld
QKqjo4o/lOCbLn81LiQB8747er13/H76Gnknlv2hPxgtDEStb6ykMS3rSzw3y4nS
tklNiPuvj6ysesBpv8geQyt2zJTVeA==
=uLw5
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

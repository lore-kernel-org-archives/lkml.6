Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbeCFVd6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:33:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbeCFVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:33:55 -0500
Date: Tue, 6 Mar 2018 21:33:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>,
        linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regulator regression in next-20180305
Message-ID: <20180306213350.GH13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk>
 <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 05:06:48PM -0300, Fabio Estevam wrote:
> On Tue, Mar 6, 2018 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:

> > Yeah, that's what I expected.  What we really need to figure out I think
> > is what exactly is taking the lock that we end up colliding with, I
> > don't seem to be able to reproduce so I'm having to just go on staring
> > at the code here.

> Any debug options I should turn on in order to help us to understand
> more on the lock issue?

No, unfortunately, apart from the generic kernel ones (like lockdep).
I'll try to have a poke at adding some tomorrow, though I'm also
considering just dropping the series for now.

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqfCT0ACgkQJNaLcl1U
h9C9LAf/fr4dr//g7R8brVqukeJ7zYuWo3k4o0h8+VidxRv+hHlkvDMsIk1R9Pjp
QCJFrRcF+pXiitZzMLeFP8w3/IC7pR2yiuq7plKfVOTJs7O5H6bcULyFfiXg3FNK
zKu7o6VWdZuAtJNZ4TzJQwC2+bx9l58zAgZHCN8Z0iYOnTRyMB9nkM5eDi6QjdOu
0E2BYhxNuq+TcFWxL0Pv6+2CL9mkkxKmScSGWIA9nglzTzE+bh9drrU8tgrT96GL
xGVN++2OvnAzAOAGn86f6nKWVGfY4UMu439fUKmv3fue942+b83WbHFTmbf0+iuw
XZv2Hu5DOKsSyJtWHW0PQF5y5cYBhA==
=5ukD
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--

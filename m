Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeE3QHx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:07:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59782 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeE3QHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:07:49 -0400
Date: Wed, 30 May 2018 17:07:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180530160744.GS6920@sirena.org.uk>
References: <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1IOPqZ3f1xe/JZlz"
Content-Disposition: inline
In-Reply-To: <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1IOPqZ3f1xe/JZlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:06:16AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 8:48 AM, Mark Brown <broonie@kernel.org> wrote:

> > Without the core doing something the regulator isn't going to get told
> > that anything updated voltages anyway...

> I was just suggesting that when the core tells the regulator driver to
> disable itself that the regulator driver tell RPMh to not only disable
> itself but also (temporarily) vote for a lower voltage.  When the core
> tells the regulator to re-enable itself then the regulator driver
> restores the original voltage vote (or applies any vote that might
> have been attempted while the regulator was disabled).  That wouldn't
> require any regulator core changes.

It needs something to tell it what the new voltage to set is.

--1IOPqZ3f1xe/JZlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOzE8ACgkQJNaLcl1U
h9AIrQf/TFGg2jyGgAkOVoUcnkOUimhz6KvGgF/8GhDJAtv0bHjLpgSK2G/qzDdU
4sdpX0aS6Sr6vpOn1x0mDtZr1aayVRX0pLiBGdPbccQPY9NhYQOFbiFFooKr9+ay
i8nQg06gjTOcI3huoEXoeuVwSz1riTh7f22/EP2vJwTUytwN+A/Eom5+dQa+TPsX
mPXNrdke8ZN/0unrfmbwKHbuEXLOCNPii4aDIq54SxORU5tX7b1MEbEl+jKJ8rAI
ZnjDglqFEjehqFGVOpwI763pyxOvf+b37qHlqmTtYZqofJdWnuoBSVcktn0uR3/E
Pu2cEtYtHn8IhwjPaNQKQTP/B+/Fqw==
=U8bR
-----END PGP SIGNATURE-----

--1IOPqZ3f1xe/JZlz--

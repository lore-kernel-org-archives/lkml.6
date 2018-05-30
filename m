Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeE3PCr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:02:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeE3PCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:02:46 -0400
Date: Wed, 30 May 2018 16:02:41 +0100
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
Message-ID: <20180530150241.GO6920@sirena.org.uk>
References: <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 07:46:50AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 2:37 AM, Mark Brown <broonie@kernel.org> wrote:

> >> Linux vote for the lowest voltage it's comfortable with.  Linux keeps
> >> track of the true voltage that the driver wants and will always change
> >> its vote back to that before enabling.  Thus (assuming Linux is OK
> >> with 1.2 V - 1.4 V for a rail):

> > That's pretty much what it should do anyway with normally designed
> > hardware.

> I guess the question is: do we insist that the driver include this
> workaround, or are we OK with letting the hardware behave as the
> hardware does?

What you're describing sounds like what we should be doing normally, if
we're not doing that we should probably be fixing the core.

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOvRAACgkQJNaLcl1U
h9AFtwf/cJZ2Tq/ONozyyV709R6zeUtnvfSRxunX/FBfzIs0TqHBMxO9PW2U7oZq
GWJF1gQoB8MVcnaWSWzGLrNfGJqBlaWD0N/jG9MAOuBaCd+J5fXGvfsbEc9qNiZI
HGz+eD/Qbzmplb3HAt3/ABvvzFTCuBLiqHKupY6/VjREAWujl09FEbFcoq5tiK2P
Gd+hnY2HYBV7WcZYrFXXDXq/eWxZcGchq7Yv80ugxzbkSSFazRwkUaiL2Tf8dcfO
OR6xYHMWiAfde/4bfzwM94XIFyesH8pryEsvh/kBkeZJiCtiWm097wngfgKuPBie
Nq3FNfijxJIBKEAPb7rDZHDOr3Pzug==
=f9IM
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--

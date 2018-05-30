Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968778AbeE3Jhb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:37:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964974AbeE3JhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:37:06 -0400
Date: Wed, 30 May 2018 10:37:01 +0100
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
Message-ID: <20180530093701.GD6920@sirena.org.uk>
References: <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 10:30:33PM -0700, Doug Anderson wrote:
> On Wed, May 23, 2018 at 8:56 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yes, that's definitely not what's expected but it's unfortunately what
> > the firmware chose to implement so we may well be stuck with it
> > unfortunately.

> We're not really stuck with it if we do what I was suggesting.  I was
> suggesting that every time we disable the regulator in Linux we have
> Linux vote for the lowest voltage it's comfortable with.  Linux keeps
> track of the true voltage that the driver wants and will always change
> its vote back to that before enabling.  Thus (assuming Linux is OK
> with 1.2 V - 1.4 V for a rail):

That's pretty much what it should do anyway with normally designed
hardware.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOcL0ACgkQJNaLcl1U
h9DM5wf/ZIB/GXA/GKedSaSDuEH7anyaK0FDs0T5+c5BeuhSOKMMO56wPSCmNKOS
wiMVH2Oe+SjF07QaUMXYAnBKhSJ95P2c+U+MbzexI9MVcaV2DCyqE2PYlALX4Gsg
1p+F/ESu6fLIbNMWhUQ9jzqIsoNL5fAWX/B5sJeSb1hXPTo/QXvKGMz9SnO0LoLM
btZh5hlny9lzNGPxEz+8IrcDi/y1JoAjtFUICAfiWlxlk45g88rJ43GciuBb4yYT
HN4DTFugMryqY97VeQ28RXO5gnvAq5PKjLGfCraDRzy9irgTqyBiuF5mzdCV6vm9
qMtsByT1THQmE6RX/ab4hL3xbchr/w==
=hbBI
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

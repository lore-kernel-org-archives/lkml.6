Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeE3Puv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:50:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753257AbeE3Pus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:50:48 -0400
Date: Wed, 30 May 2018 16:50:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180530155044.GR6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 07:54:47AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 3:37 AM, Mark Brown <broonie@kernel.org> wrote:

> > I'm confused as to why we are specifying the maximum current the device
> > can deliver in a given mode in the DT - surely that's a fixed property
> > of the hardware?

> Said another way: you're saying that you'd expect the "max-microamps"
> table to have one fewer element than the listed modes?  So in the
> above example you'd have:

No, I'm saying that I don't know why that property exists at all.  This
sounds like it's intended to be the amount of current the regulator can
deliver in each mode which is normally a design property of the silicon.

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOyFMACgkQJNaLcl1U
h9APmQf/a3fBWO7O64dclaPSy5PQTT+0iC1JNxs/Hk+txGYbRZTI9mLlpVVG/LJP
haMLQQpuxMQwCAz00MMYTLcpZDTut1uMaOpYMACfAT8wvC1CWQiPk5rOyW1dKrXz
C0/st2AmpkF1bALS/uPiqar9Kb9goo0kpXDapFeySHICsqSKSlJW3E6Rjqytz0rR
SOVBaJ7nbNnxoNAedsklQQodymkpEOrW2UhYBbSeCVvfWBkCgRhtlqCqpaY3iIR6
KOuQgt+rBIlPUsaEmQBn0gM+tBuu02bwMDCA8lNovZiAhzS2DIJSjSZG6zptBgtg
AspebxFE83E1JP6nD/GiIuQagki/CA==
=Tg4l
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--

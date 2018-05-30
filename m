Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeE3Kha (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:37:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeE3KhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:37:25 -0400
Date: Wed, 30 May 2018 11:37:20 +0100
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
Message-ID: <20180530103720.GH6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 10:23:20PM -0700, Doug Anderson wrote:

> > +                       qcom,drms-mode-max-microamps = <10000 1000000>;

> Things look pretty good to me now.  I'm still hesitant about the whole
> need to list the modes twice (once using the unordered
> "regulator-allowed-modes" and once to match up against the ordered
> "qcom,drms-mode-max-microamps").  I'm also still of the opinion that
> the whole "drms-mode-max-microamps" ought to be a standard property
> (not a qcom specific one) and handled in the regulator core.

I'm confused as to why we are specifying the maximum current the device
can deliver in a given mode in the DT - surely that's a fixed property
of the hardware?

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOfuAACgkQJNaLcl1U
h9DCkwf/TUW3B79DOQ8gDtXWhAdDlfnHkl1MQ+yklnO9/BV1sXKmL7RPDwwOyCqT
cKIWmY4o4H7nvMpr1YXBwW1CXG4r6+87fQDaP0212TufnzJkJjVPv4XMsMAe/Z7b
BTtTtXCFmudVjSrp4l24q94APzWQcgt5I3FWLKiiv93HhKp8+4RBVCKFq/D3XLxk
3nhjUG8zvTMhDtADgAYw3cZrT473IOyUEaXCwTc3wY3srVSX5ffzSZqM8Y2K1Vmi
PLzk694h1wLsHXZe5Ig9HCF/Ys3y65fqhipmHGPcDkB3voPiJj9PNAmSZa16xsYc
Beq6G12n2RpuddPVHJGdx+kuX2KvmQ==
=SPtN
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeE3QNR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:13:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeE3QNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:13:14 -0400
Date: Wed, 30 May 2018 17:13:11 +0100
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
Message-ID: <20180530161311.GT6920@sirena.org.uk>
References: <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
 <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OowMmFE4aK71mEhh"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:09:02AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:07 AM, Mark Brown <broonie@kernel.org> wrote:

> > It needs something to tell it what the new voltage to set is.

> The regulator driver has its own cache of what voltage was most
> recently requested by Linux.  It can use that, can't it?

If we're just going to use the most recently set voltage then hopefully
the hardware already knew that, and it might not be the lowest available
voltage if the last consumer to get turned off was holding the voltage
higher.

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOzZYACgkQJNaLcl1U
h9B6Rgf/Yms2GdcmMMUj3u4d9y+PBjuS86yXp1+z0NNJHf88fhyWjhMHzcpAQOc/
yNh11Y4cIR+tt/4gXbh9LQR0O7iunImfsTbD3KH6CqycrAyVcG+s8llqNUwdKL6L
BK84gQk/g/877c0Yf/dEpWwxjGfiCEofwRfoqM7JgsCmLhDImWH/W0S5NZSuZSVp
MUn5RzG72VaV8V3Q550FnHWk2bdweBsFulC7eLoVpJz8K6Wr1Lruso4qxrSpycff
tgrKMLJuCUelD6rdHalEekQD7s2+7GpkvCmHB45WqTMwq3c+yQLBJp4GW7kMxW7S
2NGWlRK95dYaiuNdYvWMjUaMzqZIoQ==
=+Bib
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--

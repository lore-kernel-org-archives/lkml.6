Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeE3QUO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:20:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeE3QUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:20:11 -0400
Date: Wed, 30 May 2018 17:20:07 +0100
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
Message-ID: <20180530162007.GU6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
 <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dXvu6+ixFx2ZffE8"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dXvu6+ixFx2ZffE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:12:25AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 8:50 AM, Mark Brown <broonie@kernel.org> wrote:

> > No, I'm saying that I don't know why that property exists at all.  This
> > sounds like it's intended to be the amount of current the regulator can
> > deliver in each mode which is normally a design property of the silicon.

> Ah, got it.  So the whole point here is to be able to implement either
> the function "set_load" or the function "get_optimum_mode".  We need
> some sort of table to convert from current to mode.  That's what this
> table does.

We do need that table, my expectation would be that this table would be
in the driver as it's not something I'd expect to vary between different
systems but rather be a property of the silicon design.  No sense in
every single board having to copy it in.

--dXvu6+ixFx2ZffE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOzzYACgkQJNaLcl1U
h9CfwQf/dghVtBPln5sTA95A+zVqCX2K0kot4Y5BBRZTpovVgNXnS1RRCmleysbT
YxTV1SK6ZbbnpQfCnNnt4U2xA4VfWggvfFkm5EabjUkXYAU5RNrS8tD6kI2+SLx4
uRowqV2F2QRLz5urd71PtSry6jGA4Fa7TXoPUARM1FBpa5INPSh9r3pV8KLpTrVO
vVKwdbjVrM8a6eJrZ6/RPgkto/sPsHTinXSgNjtbWrpeFGEtdyJyOzRUKexBvGOx
FbXlzGvSIZw0cftpK1iWxqWfdIf037CeyZK5HJ4qcnAELaROiq7vKhAKV/42XqWx
8KdIfuF7T6zjcrnzqz4tDa7Vxj505A==
=vHVF
-----END PGP SIGNATURE-----

--dXvu6+ixFx2ZffE8--

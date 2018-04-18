Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDRRCz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:02:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbeDRRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:02:53 -0400
Date: Wed, 18 Apr 2018 18:02:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [v2,2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180418170250.GL10061@sirena.org.uk>
References: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <20180417182347.GD244487@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <20180417182347.GD244487@google.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2018 at 11:23:47AM -0700, Matthias Kaehlcke wrote:
> On Fri, Apr 13, 2018 at 07:50:35PM -0700, David Collins wrote:
> > Add the QCOM RPMh regulator driver to manage PMIC regulators
> > which are controlled via RPMh on some Qualcomm Technologies, Inc.
> > SoCs.  RPMh is a hardware block which contains several

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXejkACgkQJNaLcl1U
h9CsUAf/YJfgBCyg7VCLcYR7z9m/x6x7JybqUog1YofoDD7GT54UR6YflgyVIhGq
RNs7IYjyRS/00wPBhfhLc0m9RaGGEvnX+fnZ7eyhAZr2gdkRtQiJIkO+TtVdofGz
nRBTswjOM8hx1zfDB32Q5lxDixxwv44cigQd8UJzzt96lyxh1xg+WOLVDytFQyze
dJ5tuCE8xEylebos7HiIuixM1JrGK3+ep2uc3NppFrixP6AdmUv8WD28Oa79O52k
TJLT0tQpj1RfPDLvAeEp8ko+OJFLDLVF8qr1bVrUDnLF9KdJ5NINnHZ83otLFm28
40inyZhP7YyaOWJp8ms0hy55dPVO/Q==
=WWCW
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--

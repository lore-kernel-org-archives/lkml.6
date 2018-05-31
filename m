Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeEaKib (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:38:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60116 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbeEaKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:38:28 -0400
Date: Thu, 31 May 2018 11:38:23 +0100
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v4 0/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180531103823.GB13319@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <20180530163343.GV6920@sirena.org.uk>
 <da40510b-443d-d8fd-7285-c6e7eff45dc6@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <da40510b-443d-d8fd-7285-c6e7eff45dc6@codeaurora.org>
X-Cookie: I've read SEVEN MILLION books!!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 05:11:54PM -0700, David Collins wrote:

> I'll split up the patches so that reviewing is easier.  For the base
> patch, would you prefer that I remove *all* mode support (handled by
> generic regulator framework DT properties) or only remove the special
> purpose drms mode handling support (i.e. qcom,regulator-drms-modes and
> qcom,drms-mode-max-microamps)?

Standard operations should be fine, just weird custom stuff that's been
causing issues.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsP0J4ACgkQJNaLcl1U
h9AWvAf9GFN3V7LQ1QpDCLbT6jGBM8FSyg1Lf4Hc7HIvUz7egioAF4pjj3yR8sWN
gCwoW2jcKJcwd4Cb8PjhIWJ8hfcbmvhG5VZy3tc3nxV3vZJXfH1SxFSeUKWBnYkn
mDkcsZP65XA7tCTpM//MnuUQdK3mr4KNEHpUMqAo6a+/bxF7nVIcGnGZN/KypAjb
/93fFofC9gfHWO7BkhxECxfT8hgd/9GtJf+liR+nkn7/vH/Pduy1kIJGC+idFAJU
AzUwd3dInLEdy+FYv89VZM3XeS1mIae1wod7RuXxFhZp6SGc8+EAA53htmU+tIK1
76MHf6I5YMwzVh7Ue4GEK5nAsQL0dw==
=BoBR
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

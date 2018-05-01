Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEAUnu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:43:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeEAUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:43:48 -0400
Date: Wed, 2 May 2018 05:43:34 +0900
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ASoC: tas6424: Allow disabling auto diagnostics
 for faster power-on
Message-ID: <20180501204334.GD2714@sirena.org.uk>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
 <1525077018-15863-4-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <1525077018-15863-4-git-send-email-jjhiblot@ti.com>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 10:30:18AM +0200, Jean-Jacques Hiblot wrote:

> +	SOC_SINGLE_STROBE("Auto Diagnostics switch", TAS6424_DC_DIAG_CTRL1,
> +			  TAS6424_LDGBYPASS_SHIFT, 1),

This should be "Auto Diagnostics Switch" with a capital on the Switch.
Otherwise this looks good!

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0XUACgkQJNaLcl1U
h9AMVQf/S1qlSoIDTPu+x4kDJz0jWfL9QIuRRefE1IknLjIvgUF89vQxe9JXmsE8
7S7jpISlPBktDaqieBQs5JDETcHJb7HTHeCLiGNJ0JEXtsVHbotpbfpLbL6W0Jnd
Zcr/Be27wRc6LhOHUceomVmjKy3zb1+PtEj8F2RqTtisQNtGEDgVdwFwNsf9Et7h
hZ8zf3ww69ceTVrzjtQ3YOs8sUDZXL6ncC53pwZhWTzoFZwcdYlhwZyO7yfRPkAP
JdkozvfpVBmRuUZEZZV6nUSVQt2oW4OWjFjab29DkiQAXfwZncubDVX6MKXy7Yi+
Iu5HN/dzjKxoWeMRxNZv89UZv2rCRA==
=cyd3
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

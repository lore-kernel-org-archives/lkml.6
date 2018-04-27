Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeD0Pai (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:30:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbeD0Pag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:30:36 -0400
Date: Fri, 27 Apr 2018 16:30:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: tas6424: Allow disabling auto diagnostics
 for faster power-on
Message-ID: <20180427153021.GE6872@sirena.org.uk>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
 <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
X-Cookie: Honk if you love peace and quiet.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2018 at 03:55:49PM +0200, Jean-Jacques Hiblot wrote:

> +static const char * const diags_enum_texts[] = {"OFF", "ON"};
> +static unsigned int diags_enum_values[] = {1, 0};
> +SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
> +			   TAS6424_LDGBYPASS_SHIFT, TAS6424_LDGBYPASS_MASK,
> +			   diags_enum_texts, diags_enum_values);
> +

This just just an on/off switch so it should be represented as a
standard _SINGLE() control with " Switch" at the end of the name so
userspace knows what to do with it.

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrjQg0ACgkQJNaLcl1U
h9B3BQf9G8mc2VxRhn8o5ZTSsYg3S9EJadQ1MvSluxiVPchmaCMOK6ubLlJO1oAQ
DFiElg3t0AZd+8Omo42op3mcadKYH7pskELHvBa65AkT/9ZSW5kSII2AA+FVJxPb
dmjdv36qXEvpUrKsA1jLn8yG5b4TU7dQ962kNg7ONO4IgolrC2u93e7WSJvfB61k
0bsmACPMOwDr+meF/cnG2uF1vXRmoE70uWgvKvemTmbKugRevRVSt9UNj/v6xBQG
o3He3kv1KRO7/n5G+xATph5ZxKc89kAUydV5hG0nTaMPF33BXXKhlOLHCuSM2ump
zCD8ONrDK7J8qXieQjzVBQjg8FvhQA==
=tWnr
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--

Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4AC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A33420864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fzh7SnuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A33420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeGLRFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:05:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32982 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeGLRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=un1CIKQKP7dLTY7iZnZVw0B5yvmIQybdsovLpgvETXc=; b=fzh7SnuIvIJ8ZpgyYkilmTJtr
        kK4jSkUHWaw7wfpnUUZxIeXAINQ1R+rF2uNuqQsuF6TT7xp/Go4v182JM/3Pi69vD6Wrb0hV0gwYw
        eMiBUXcSB+daUhvxhPWpwC2gfdZWx5Rwoq2kyVS/HOYhSQtMxtUY0BHgoZSGm4eJ2IQl4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fderp-0003pQ-R9; Thu, 12 Jul 2018 16:54:57 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fderp-0008Ve-Cz; Thu, 12 Jul 2018 17:54:57 +0100
Date:   Thu, 12 Jul 2018 17:54:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180712165457.GI10369@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <20180702102853.GI18211@sirena.org.uk>
 <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 04:44:14PM -0700, David Collins wrote:
> On 07/02/2018 03:28 AM, Mark Brown wrote:
> > On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:

> >> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] =
=3D {
> >> +	[REGULATOR_MODE_INVALID] =3D -EINVAL,
> >> +	[REGULATOR_MODE_STANDBY] =3D PMIC4_LDO_MODE_RETENTION,
> >> +	[REGULATOR_MODE_IDLE]    =3D PMIC4_LDO_MODE_LPM,
> >> +	[REGULATOR_MODE_NORMAL]  =3D -EINVAL,
> >> +	[REGULATOR_MODE_FAST]    =3D PMIC4_LDO_MODE_HPM,
> >> +};

> > This mapping is really weird, I'd expect one of the modes to correspond
> > to the normal operating mode of the regulator. =20

> My thinking here was to have a consistent mapping for consumers to use
> between REGULATOR_MODE_* and physical regulator modes for both LDO and
> SMPS type regulators:

No, that's not useful or helpful - if there's any modes I'd *really*
expect to see one of them be _NORMAL.

> This allows a consumer to request NORMAL in typical use cases and FAST in
> use cases that require low voltage ripple.  If NORMAL is not supported,
> then it automatically gets upgraded to FAST by the regulator framework.

> I could change it so that REGULATOR_MODE_NORMAL maps to LDO HPM mode.
> However, doing so would make it so that REGULATOR_MODE_FAST requests would
> fail for LDOs.  Thus, consumers would need to know if their supply is an
> LDO or an SMPS (which seems undesirable).

You've just discovered why it's a bad idea for consumers to do anything
with modes directly!  The mappings are just never going to be consistent
given the massive variation in what regulators can support, the
retention mode of one regulator might be able to deliver more power than
the normal mode of another.

> Would it be acceptable to have both NORMAL and FAST map to LDO HPM?

Having something other than a 1:1 mapping is going to lead to pain at
some point.

> >> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int=
 mode)
> >> +{
> >> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] =3D=
 {
> >> +		[RPMH_REGULATOR_MODE_RET]  =3D REGULATOR_MODE_STANDBY,
> >> +		[RPMH_REGULATOR_MODE_LPM]  =3D REGULATOR_MODE_IDLE,
> >> +		[RPMH_REGULATOR_MODE_AUTO] =3D REGULATOR_MODE_INVALID,
> >> +		[RPMH_REGULATOR_MODE_HPM]  =3D REGULATOR_MODE_FAST,
> >> +	};

> > Same here, based on that it looks like auto mode is a good map for
> > normal.

> LDO type regulators physically do not support AUTO mode.  That is why I
> specified REGULATOR_MODE_INVALID in the mapping.

The other question here is why this is even in the table if it's not
valid (I'm not seeing a need for the MODE_COUNT define)?

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHh+AACgkQJNaLcl1U
h9C00gf9HOP2+BrySgb9hV9H4nbGU9MOhYejLNqRBf6wBj7c+tybn7hx/ffQ6EOE
Ce+k74plxslZBcJXI/b0oT7BvNDPJRG2f5MaeOR2yKzFc1D7w5NYRwEPM3Uy0r5x
SMIlt6TrT8sdeM48WJTkg7ltaB5ldu6DKXxyNXsMQdtegWFpRLrFORkpPzYprX83
EDu9BIOdryRfW4MWhhtDT+RO7Brz3mcct5eZ0paohaHD4bmN9P6En7Lz9ckYCrq9
PhV3RAE1zEeVwJBI4leGHyWa7SvnLf7m2k0KfCjFbuPe8G+YRpf+pDz53wDbDkvE
9mJoe3pawHKWsRpPTipWtDqrXMSdSw==
=ok8c
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--

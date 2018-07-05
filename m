Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6DAC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB467240FB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gDhGOOl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB467240FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeGEQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:48:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeGEQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9PdQVaZW2I0kfZ0C62AEEnzvk0iC6RQ5B4ysrbF1FOg=; b=gDhGOOl3ystB2AsTsi24ME+Cg
        +kuuVr+5hHsmD3J1bW0yaWsFFkbcn9wiqvy2qOaAwTGQ6XnGTZElQTfw2LfAVby2TascxbLJ3txf7
        JVD3c8m95gsDv++IJNDXp6xxJNLB0ruW0JBI68rhtozl6saCBVdeZ6n5Y4R1cU2kDGqTw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7Qb-0000zo-Pm; Thu, 05 Jul 2018 16:48:21 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7Qa-0007mn-QF; Thu, 05 Jul 2018 17:48:20 +0100
Date:   Thu, 5 Jul 2018 17:48:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 4/8] regulator: stpmu1: add stpmu1 regulator driver
Message-ID: <20180705164820.GB6227@sirena.org.uk>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-5-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <1530803657-17684-5-git-send-email-p.paillet@st.com>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 03:14:23PM +0000, Pascal PAILLET-LME wrote:

>  obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) +=3D fixed.o
>  obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) +=3D virtual.o
>  obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) +=3D userspace-consumer.o
> +obj-$(CONFIG_PROTECTION_CONSUMER) +=3D protection-consumer.o
> =20
>  obj-$(CONFIG_REGULATOR_88PG86X) +=3D 88pg86x.o
>  obj-$(CONFIG_REGULATOR_88PM800) +=3D 88pm800.o

Looks like this got included by mistake...

> --- /dev/null
> +++ b/drivers/regulator/stpmu1_regulator.c
> @@ -0,0 +1,919 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved

All rights reserved and GPL :)

Please also make the entire comment a C++ one so the block looks more
intentional.

> +static unsigned int stpmu1_map_mode(unsigned int mode)
> +{
> +	return mode =3D=3D REGULATOR_MODE_STANDBY ?
> +		REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
> +}

This looks confused - what's going on here?  Normally a map_mode()
operation would be translating values in DT but this translates
everything that isn't standby into normal which suggests there's an
error checking problem.

> +static int stpmu1_ldo3_list_voltage(struct regulator_dev *rdev,
> +				    unsigned int sel)
> +{
> +	struct stpmu1_regulator *regul =3D rdev_get_drvdata(rdev);
> +
> +	if (sel =3D=3D 0)
> +		return regulator_list_voltage_linear_range(rdev, 1);
> +
> +	if (sel < 31)
> +		return regulator_list_voltage_linear_range(rdev, sel);
> +
> +	if (sel =3D=3D 31)
> +		return stpmu1_get_voltage_regmap(regul->voltage_ref_reg) / 2;
> +
> +	return -EINVAL;
> +}

The only thing that's going on here that's odd and that couldn't be
represented with a helper is selector 31 which looks to be some sort of
divided bypass mode - can you explain what this represents in hardware
terms please?

> +static int stpmu1_ldo3_get_voltage(struct regulator_dev *rdev)
> +{
> +	int sel =3D regulator_get_voltage_sel_regmap(rdev);
> +
> +	if (sel < 0)
> +		return -EINVAL;
> +
> +	return stpmu1_ldo3_list_voltage(rdev, (unsigned int)sel);
> +}

This is just the standard core behaviour, no need for this.

> +static int stpmu1_fixed_regul_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct stpmu1_regulator *regul =3D rdev_get_drvdata(rdev);
> +	int id =3D rdev_get_id(rdev);
> +
> +	/* VREF_DDR voltage is equal to Buck2/2 */
> +	if (id =3D=3D STPMU1_VREF_DDR)
> +		return stpmu1_get_voltage_regmap(regul->voltage_ref_reg) / 2;
> +
> +	/* For all other case , rely on fixed value defined by Hw settings */
> +	return regul->cfg->desc.fixed_uV;
> +}

It'd be better to just use a separate set of operations for the DDR
regulator rather than have a conditional here, less code and makes it
clearer that this one is a special case.

> +static void update_regulator_constraints(int index,
> +					 struct regulator_init_data *init_data)
> +{
> +	struct stpmu1_regulator_cfg *cfg =3D &stpmu1_regulator_cfgs[index];
> +	struct regulator_desc *desc =3D &cfg->desc;
> +
> +	init_data->constraints.valid_ops_mask |=3D
> +		cfg->valid_ops_mask;
> +	init_data->constraints.valid_modes_mask |=3D
> +		cfg->valid_modes_mask;

Drivers should never be modifying their constraints, this is a no no.

> +	/*
> +	 * if all constraints are not specified in DT , ensure Hw
> +	 * constraints are met
> +	 */
> +	if (desc->n_voltages > 1) {

Drivers shouldn't be doing this either.  The API will not allow any
modifications of hardware state without constraints so unless the
bootloader is leaving things in a broken state we should be fine.

> +	if (!init_data->constraints.ramp_delay)
> +		init_data->constraints.ramp_delay =3D PMIC_RAMP_SLOPE_UV_PER_US;
> +
> +	if (!init_data->constraints.enable_time)
> +		init_data->constraints.enable_time =3D PMIC_ENABLE_TIME_US;

If these are hard constraints we know from the chip design they should
be being set in the descriptor.  The constraints are there to override
if either they're board dependent or the board needs something longer
than the chip default.

> +	/* LDO3 and VREF_DDR can use buck2 as reference voltage */
> +	if (regul->regul_id =3D=3D STPMU1_LDO3 ||
> +	    regul->regul_id =3D=3D STPMU1_VREF_DDR) {
> +		if (!buck2) {
> +			dev_err(&pdev->dev,
> +				"Error in PMIC regulator settings: Buck2 is not defined prior to LDO=
3 or VREF_DDR regulators\n"
> +				);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		regul->voltage_ref_reg =3D buck2;
> +	}

Can or do?  Usually this would be hooked up in the DT (with the
regulator specifying a supply name in the desc).

> +	np =3D pdev->dev.of_node;
> +	if (!np) {
> +		dev_err(&pdev->dev, "regulators node not found\n");
> +		return -EINVAL;
> +	}
> +

May as well let the driver probe?

> +	/* Register all defined (from DT) regulators to Regulator Framework */
> +	for (i =3D 0; i < ARRAY_SIZE(stpmu1_regulator_cfgs); i++) {
> +		/* Parse DT & find regulators to register */
> +		init_data =3D stpmu1_regulators_matches[i].init_data;

You should register everything that's physically there unconditionally,
there's no harm in having a regulator registered that's not used and it
might be useful for debugging purposes.

> +static const struct of_device_id of_pmic_regulator_match[] =3D {
> +	{ .compatible =3D "st,stpmu1-regulators" },
> +	{ },
> +};

This is part of a MFD for a single chip, why do we need a specific
compatible string here rather than just enumerating from the base
registration of the device?

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+S9QACgkQJNaLcl1U
h9Ah8Af/WM+VknAiFcVbiVarONpM4bnMEejAs5ViUkRjTy5YO3N+PrZqEWwwSQFe
adumgdEpd3G/tYrJOqQmFxUFdJrY6OEMIL0G0Gi/VNjhFadUGs6wWC9KBEG/NNcC
ei0ExN18lyXSm/jE6k+1VX6Ty0pQt2R6ZE8pxd6aUqK1oZnnPl8wdgoinNmgZViq
6Ju9T048e1lL8OfRt9jtveEBc+6M+yRuCaLpKQvtX7zDZlA6j+LI+EpZRBQIoyUK
jFQcHIVzRHPqEq3UvYgmwJ0sHkvH7l27h0sUr3mc/LY5fTB/xY2BPK5MxzLyz9wM
mdoOqdgADZ+7MqlrzbtkOgA7zvJaOA==
=wg+l
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

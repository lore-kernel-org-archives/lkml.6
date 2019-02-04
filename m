Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E1214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549270991;
	bh=AXkZHcOPveFlVAMtdIm2xLMkxuLp1vP/zWdrrsfq9FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IV8xl5CEZ2RSqdtiq8cQnqIgB2PjTeKhnRtjbmOj4A9zABWx0dJkKkQuXdH5NYs2G
	 Q2MdAnmF5qInDKiF/iSYGPbuWrVi1sBcKGTeklDmwHMt4YVHIgONZcbxm/QiJ1Qbyk
	 d54mNWDLQ07IYc2buUCjWvOIeKKWc2UP0ea8pFQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfBDJDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:03:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60782 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TJrHOAePs06pCrkVaWMSAlaYoFeXAbWnb2f2XPY0mhM=; b=EAR72MtTkYEKRNnJLKN8QGdET
        zsFSEYCQIfiGzv4ygkZADwGcEyEpGeLDKemDEQk9miQ4mPmZWGSrA9G7/tAuI8Ogy/4DJUZmOyzRB
        l39tIMAF2DFFeEe718UOhESosHuc4P1VT3CBXbAT8W9NGoQj5FcClEm1af+uttIizvJYw=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqa9e-0000e7-Qi; Mon, 04 Feb 2019 09:03:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2539F440082; Mon,  4 Feb 2019 09:03:01 +0000 (GMT)
Date:   Mon, 4 Feb 2019 10:03:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Message-ID: <20190204090301.GC23441@sirena.org.uk>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 12:45:03PM +0100, Jorge Ramirez-Ortiz wrote:

> @@ -653,6 +708,10 @@ spmi_regulator_find_range(struct spmi_regulator *vre=
g)
>  	range =3D vreg->set_points->range;
>  	end =3D range + vreg->set_points->count;
> =20
> +	/* we know we only have one range for this type */
> +	if (vreg->logical_type =3D=3D SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
> +		return range;
> +
>  	spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, &range_sel, 1);
> =20
>  	for (; range < end; range++)

Rather than have special casing for the logical type in here it seems
better to just provide a specific op for this logical type, you could
always make _find_range() call into that one if you really want code
reuse here.  You already have separate ops for this regulator type
anyway.

> +static unsigned int spmi_regulator_hfs430_get_mode(struct regulator_dev =
*rdev)
> +{
> +	struct spmi_regulator *vreg =3D rdev_get_drvdata(rdev);
> +	u8 reg;
> +	int ret;
> +
> +	ret =3D spmi_vreg_read(vreg, SPMI_HFS430_REG_MODE, &reg, 1);
> +	if (ret) {
> +		dev_err(&rdev->dev, "failed to get mode");
> +		return ret;
> +	}
> +
> +	if (reg =3D=3D SPMI_HFS430_MODE_PWM)
> +		return REGULATOR_MODE_NORMAL;
> +
> +	return REGULATOR_MODE_IDLE;
> +}

I'd have expected a switch statement here, ideally flagging a warning or
error if we get a surprising value in there.

> +static int spmi_regulator_hfs430_set_mode(struct regulator_dev *rdev,
> +					  unsigned int mode)
> +{
> +	struct spmi_regulator *vreg =3D rdev_get_drvdata(rdev);
> +	u8 reg =3D mode =3D=3D REGULATOR_MODE_NORMAL ? SPMI_HFS430_MODE_PWM :
> +						 SPMI_HFS430_MODE_AUTO;

Please write a normal if statement (or switch statement) to help
legibility.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxX/8IACgkQJNaLcl1U
h9AT0wf9E3UlafXm3pZLIqrY5EIoO+llv9YGhMENRbXSjvSt68YbsVh4naMSDVPF
Esp/LfvSl6S+jEKNRYuofIdqidqnYUQzaPjDAUEV7lVv1PIjZDLeG9HrEJer82rv
c7zmbRz3oEcPD6Ja02FpOdxuCS7AqVdbTOIHUaw5DSlzIQTHEMC+aoCQ0btTerLJ
j/aO8IGVw/Bazyvya3PUnRPIj8foH7msmKQgXpf8+Gl/wPp3X9VfeaHfBdCssxQb
anflPszsQ83skkXShVttyUr4j+N+UgtkhpedP1tuydfI5BlFhquKZD5aMG1K7ebD
0MsgwXc2R1L4P/vf/5OINRuONkd/3A==
=IuR9
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

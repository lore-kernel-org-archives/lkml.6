Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC1AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8232084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544630119;
	bh=yW3bwXui1z9Fx9nGBQ2a7tFhlIF0Tn9oGxEotH1mOOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Li1BcZWBJ476aQMI7TI7cCyXwZGz+NA8mptw29nChKxppfwKUiIIsuH5T0Ny9Av8k
	 COSJu5r73E585ttq7NqmqquTD0dNF7BOGNbtpwOFjeHlySK5L24m0Z4kzIDqbaT1k4
	 E6qyD9Z0L8hu3fXliHT8zlu6a8NNIBFY/7S2IE3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8232084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeLLPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:55:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MxRJpaEmCq7pl5aHRVnXXQnL4V8VTjtBmPWkYK1fRgw=; b=wT77kI/qD1QiWQ7BKsScLBWuL
        sA9XlEuKO84+09F1Wu62349eHWDmTqcDHNaJr8dW/Nk+PtplDJenc4zzHmhGEl/Og3/WgL0ghpMjP
        rsfiGGpLXcmVyiHiaBiNaROT2y/IYyRADgsJibAsxJWnBpwiet+7lU5EIL/bafhvmm4L8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gX6qk-0004Fd-T2; Wed, 12 Dec 2018 15:55:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 465C21125535; Wed, 12 Dec 2018 15:55:02 +0000 (GMT)
Date:   Wed, 12 Dec 2018 15:55:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181212155502.GD6920@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
 <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
X-Cookie: The greatest remedy for anger is delay.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 08:01:07AM +0000, Andrei.Stefanescu@microchip.com w=
rote:

> > This puts the device into low power mode when the suspend function gets
> > called but this might not be safe - devices using the regulator may not
> > be suspended yet so could still need full regulation.  Normally a GPIO
> > triggered transition like this would be being done by hardware as part
> > of the process of suspending the SoC.  Is there some reason to do this
> > manually?

> There is a line from the MPU (SHDN) which goes low only when the MPU
> turns off. That line is already connected to the PMIC and it differentiat=
es
> between suspend-to-mem and standby. To switch to low-power, the PMIC must
> be controlled by the GPIO pin LPM.

> The suspend sequence is:
> - LPM pin goes high (PMIC enters Low-Power <-> Linux standby)
> - SHDN goes low (if target suspend state is mem) and then PMIC enters=20
> HIBERNATE

This feels like it should be being controlled somewhere else, if it's
actually causing a change in the PMIC state it seems like it wants to be
done as late as possible in suspend to minimize the risks.  At the very
least suspend_late() for the driver seems appropriate.

Could you submit a version with this feature at least split out into a
separate patch please so we can apply the rest of the code while this is
discussed?

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwRL1UACgkQJNaLcl1U
h9AOAwf+K8t0YPz/fYY45FbWktz2aoX3ECrcgy5r25ACJVOjG7tBhTelZLbGkitB
314uampogG8tT6s8WObZbEJjQL+VUbyt7bgcpTI7YamUdPSwkXSJDsfjpPOVVLoa
2iAHn+GBi7O63sKNUb9s+D4q7K1xbMs1vxcpQoV+I/SZx33z6GaoJPBUI8CcDes3
UmC9aaIMUMva/RuKtPSEomI/+qAhiuMdZ1e4SQyZ/AZLxThOPyXJvh1hs8fa2IQg
qC4heudi00SNdZj0dGl6GlyYLetqaYKamlZ8aYf++xJPwI6hH/bsSP/Tiq2iaWTE
wnP4HNcX1dCaLvgGy84OxUTV9fmiOQ==
=8c4e
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--

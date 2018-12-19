Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82445C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9C2218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545241964;
	bh=ss2h2KyLhihHA93+El/3KBAbh6hqt88ctL5G8l1JhI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wqhRUMPi+YkQe2bvrWh6NiL/PmNuzvRnd/eEEiP1oo95IX8H5ebUUo1rSO8a9scTB
	 nMqpPliCqjrH5yh6tH6qwW8hrd6d0HUHu+EQiwsI+i6msp5PJxlDARax/Fmvz7n8Me
	 tXhe2RPaO3iuUFp3ajHBjJwEfMpBXXgYsXLaWhHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeLSRwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:52:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeLSRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ss2h2KyLhihHA93+El/3KBAbh6hqt88ctL5G8l1JhI0=; b=WQ3qvbTOJab4ODbgq7ShZhsny
        eNHIXsyxiK1lpusGyodfB0jFSEiI4B5ctcKdTiCOONlRHQDnMLZhMl68SqMkVWLfcMXPAEtABzD6u
        QWotyX5mFrHGaHtPatiK05KJxPGfDCSxLCt3cwXyLsBoH2dB43NowxsVoDPdHAh6U6IqM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZg1H-00057A-PN; Wed, 19 Dec 2018 17:52:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 61C3A11259E9; Wed, 19 Dec 2018 17:52:31 +0000 (GMT)
Date:   Wed, 19 Dec 2018 17:52:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        vladimir_zapolskiy@mentor.com
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181219175231.GL8130@sirena.org.uk>
References: <20181218115931.GA21253@localhost.localdomain>
 <201812182306.X3vcHVlL%fengguang.wu@intel.com>
 <20181219064842.GG2477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Content-Disposition: inline
In-Reply-To: <20181219064842.GG2477@localhost.localdomain>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 08:48:42AM +0200, Matti Vaittinen wrote:

> I forgot that the block of code the commit "regmap: regmap-irq: Remove
> default irq type setting from core" removes do use the old type specifiers
> whcih this patch changes. So even though this patch applies cleanly on tree
> which does not include "regmap: regmap-irq: Remove default irq type setting
> from core" - it does not mean there is no dependency. This was my brain fart.
> There is dependency. "regmap: regmap-irq: Remove default irq type setting
> from core" should be applied prior this patch.

> Should I combine these two patches as a series (and resend them) or what is
> the correct way to note the dependency?

It's fine as-is.

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwahV4ACgkQJNaLcl1U
h9D8UQf/cKSwLpyU1OuYNzL4TbE68AmUX4jP5VnxUYC16AJJCUWPw7sg1ma3q+t+
FakAuzWg0fIXBGwHRYC/0co74Tgr0OoLfBIpO9q4uFtDiwGRdXRxWIuSEk1P4asl
+21K64niITSAByGQAPEG7xLWM79JzSmA0Ub+Ndz/yOTrfGOUe1zaTDEj5nD+w/TH
NLF6X5POoL4lGhJvbfej9lpVB9OK0eg1iodDv3hnCCVbkrI7H3y+MLeW6NkSEEy7
TGkhaDxfE9OBXEqTpBDzEqBiIAhI3s0fjenwjs2IzdC07kJo2todfpRs9q82XjrW
Bf23ULk8V3GJJztiOLt+jXV+7giAXQ==
=WOgy
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--

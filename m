Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B285C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557202073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546284640;
	bh=pS22hed7m/va8xjY+6KDP3WKsk1otppvGubpQouanuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GBTx/bUNfff56Nup44EZyBpT0Apd2Lki18ELp/Y77yLzKFD2hH1Fz9bp52LsKRXIA
	 hhNjllI9a/rOM2BpBd8Pdg1wqpCKtmqXwbiEyKtsvyqTX5TkkwtFtm3jCUuqnYw5El
	 gJIG7MFfjuFcw2JWP6ACfeZyrekas+zwVY+NKwAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeLaTaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:30:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55580 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeLaTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pS22hed7m/va8xjY+6KDP3WKsk1otppvGubpQouanuw=; b=kFd4mlqDNWfKwmh9/llhYOakv
        CG7UW51NGyl5JWTuTIuwlhv99dC2tQoi49r0EJrMTAYIjn7detv/r4FxLGvXBqd8TRYdSvfouYNaa
        tzinGJAhSHbIg0kiwml9lxiLBcS7e4S2Blj9/bGqqVqJh0o24+mxfxpfint2Wx13uzjhU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge3GU-0002j8-El; Mon, 31 Dec 2018 19:30:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 50535440080; Mon, 31 Dec 2018 19:30:17 +0000 (GMT)
Date:   Mon, 31 Dec 2018 19:30:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Message-ID: <20181231193017.GN1846@sirena.org.uk>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
 <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
Content-Disposition: inline
In-Reply-To: <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:

> > I don't have the cover letter or anything for this series, what's going
> > on with dependencies?

> Here is the executive summary:

> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> used to select PCI. This is no longer true.

> You can build an ACPI system without any PCI devices.

So there's no dependency and I can just apply this?

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqbkgACgkQJNaLcl1U
h9Cy7Af/SKh5ExwIo1qfaqbvscfVYRWs0W8VKlzlNdN8kXxt8QCCNdbT/2O4rs6N
+Y/6+FAF8v5ZOBWmOGsnxt8uDP9iLcSWn7y2xOZCAdqbSoWpIQ+lLqRjm3URogit
VWAciGWsmUpqRK3YVGSZS1X73gTaYaSFlK9S3LixBZE+ADnxBDdtGsWPoJcllgvi
38PyqC1eeOLIfuV1Mvp/jVuuFv4PnI4VIDgkE6Wfc6n6xXHkATGeGwsE23oufyVl
7B/6FIJXvtrEG9rVSaXyY4VBX3GA30xYPb97UvDDTe6uY1YVsKSL8LbMzs8SPoKi
U9eTFFH0kA9P27ScaicV6CPKju5z6Q==
=zjWy
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--

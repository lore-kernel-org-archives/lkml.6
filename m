Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25AA20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545049505;
	bh=rF+Wf3BEWAlG7/4djN8g2jxFmLhKraAd0WxhdtDb6H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQdpCT5E2bWaI549aq0o5L+RdEsaUUIcyDwnoqAYrHnk7scnLTUCi0VEI120imY88
	 IuTp1A9hXpeY8MCf/l3tsH/SS0U0r8IDQPkjWtyXhDPEZfjSR+4PlT9TytZ++3wPTS
	 o8MAmYHaKtxNt1xinw0xw6wIELPZQRERC2gxfwGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbeLQMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:25:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeLQMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rF+Wf3BEWAlG7/4djN8g2jxFmLhKraAd0WxhdtDb6H4=; b=N79RH/IdfjGysrWSOOdwBBgYS
        aPAMxtuS8kUvh2O6kf+14J4JRpjaurxIkVIzLX3uCtHBJnukk5tepNCCZ0pZaa/IrjyxjH2yiuBrp
        DoJzyuUXf6Y9DttNcozRISynm3c++8w0nOWMPhw4JepCESxCazJeWp2hUjTDCbEtousTY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYrww-0002Hf-5V; Mon, 17 Dec 2018 12:24:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AADD0112593B; Mon, 17 Dec 2018 12:24:41 +0000 (GMT)
Date:   Mon, 17 Dec 2018 12:24:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Message-ID: <20181217122441.GC13868@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
 <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
X-Cookie: You're at the end of the road again.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 07:50:43AM +0100, Michal Simek wrote:
> On 13. 12. 18 16:31, Mark Brown wrote:
> > On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> >> @@ -0,0 +1,185 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Xilinx ASoC I2S audio support
> >> + *

> > This looks otherwise good so I've applied it but please send a followup
> > patch converting the entire comment block to C++ style so this looks
> > more consistent.

> Is it the rule for your subsystems? Or did it come from any generic
> agreement how this should be handled in .c files?

It's mainly me, it's certainly not a consistent policy.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXlYgACgkQJNaLcl1U
h9CieQf/d4qfEmhEQY7q0EE8eRo+Jy7falVp81WeY6WS40+3+HHpLtlu9i3ful/U
lP+grha3OB7ugQyuBBZQxlotb69r3pVHLPaUu/WDoumwB2OZ2Mkfgt5+dBPXcxCt
tKJ2IpRmCJcsYyQVed2i/XzmqRjc6EcONyO8FjA77w1YbkncAbjfko5CeTT+xUf1
TubG6H5dZdTsaYfdkoHoAqLhQkE7dEOYopnFLB0wm9n0NRhDtGy7TebU+/HSDkhE
kP5lSbtRP0/f1sdnvlBFddTn13EZtk5HLQAzp1dUOeYdl4Ml1jMvvCXz91hDhMRu
ZDlaox91zIow+PhuGCM0d8YDMzEGEA==
=ux+Q
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

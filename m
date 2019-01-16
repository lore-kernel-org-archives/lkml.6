Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A48C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C5D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547643144;
	bh=zocHPgqrJLLcvhzPRPh6giO290W+5WiL6XSm+yhAWrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HDBYYzhIOP0G9WCvhk5FBlpgYHN446KevvX7Q6BEXYeWL66OYJhx8o7iyvutE6F0n
	 g9/XssUjrE+5ZirNFHi5CBQPkGvuZPc7bZP9lP09RHVXl3oGhjd9719hdF/RbOpE3k
	 CCSMSGpsR9rE/XY6L3Sma/f2NIlV1/JmAKAMD/WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392882AbfAPMwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:52:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbfAPMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zocHPgqrJLLcvhzPRPh6giO290W+5WiL6XSm+yhAWrs=; b=ETUdQ8M1wBOfjpbO6BXC3NRHB
        vIDX4AjtfY+aKWIwyA8E6Zp3aBV6CMrqD5H6jhzyZE6RA5fJ+/45qNLYRO5FI02BPFZ2fPr7ZMj5x
        67JzI7jjiPvZD0+EM4kIV4KJ/apjDA2FKz4GwfQma71+e1cBFH2+HK/yej7JgDhk7PDhw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjkfy-0000Dn-RD; Wed, 16 Jan 2019 12:52:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1B1D31126FFC; Wed, 16 Jan 2019 12:52:10 +0000 (GMT)
Date:   Wed, 16 Jan 2019 12:52:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190116125210.GA7186@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
 <20190116001025.GL5544@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190116001025.GL5544@atomide.com>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:10:25PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [190115 21:09]:
> > On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> > > Any ideas what's needed? Some triggering mapping data to palmas.c
> > > driver?

> > There should be a fix in -next already waiting for me to send it to
> > Linus, can you check there (a couple actually, in my for-linus branch)?

> OK great, yes the two drivers/base/regmap patches fix the issue
> for me.

Excellent, thanks for testing - I'm aiming to send them off this week, I
was going to send them off earlier but then the second fix came in.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/KPcACgkQJNaLcl1U
h9DwqAgAgbp/wZ9ShYsmuBGRqZdnPQEW8wZpe9J1e5R5GTuMp3Cy1DCifx6ohZvk
IxQ8rb098HtKbLdK4ujaKoim33Q6e/du3O6hRUh1gYUBdh8TFVkYsFXkB01zPQyq
ZTfB46YNXuvMW7/ozyYA7C/nH1ELFSoxryuLOHFkgrZDOo90KwcrgkrnBzgoEvHb
4ZqwIcUXaEk1LkzR9XDiY+JjXe/pKLg4uiuwvCd7X3cjJSMOJeHTHwIYP91tK+yy
emHNsoG48aTVyBFjUIYf1Nni2YeZUj5/+Bi1Oo91rC2Z7k+glaPJnXwQsFBhbnH3
ue+lO3czhhIgW/jtnUe7uH+8LWNgpQ==
=DgRu
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

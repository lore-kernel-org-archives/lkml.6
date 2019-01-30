Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548862810;
	bh=G0gJjHBKp6BFs3XfPsE/2DOPMPqljkASXnoDiOLOIXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mIV6XxcoQ+1voi2v0CEUiDq8NB+M3hXIcc0NKjUVpQ2z09NZnxqMw9KkE2qhDuZ9n
	 owj6Cxdiwk8zKR2Y2sWlTE/ojiyNFIfVRhRw1OHlLVr6S9rjhSeczC6JMfeNga/ejF
	 93MzNoJVoaM5iOWlBk1qbBxda5ydrDoUob4Awz+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfA3PkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:40:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47340 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfA3PkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G0gJjHBKp6BFs3XfPsE/2DOPMPqljkASXnoDiOLOIXw=; b=mxiCYy2GHbDO3c3z2eGOfC6GO
        25eEtm9uJ2ezYxpx23QnIVhQnjJhWchkWTuDHquFqNz3NzQMPWsrrpPP0sFw6URjP/neuYqjBjjvj
        pVZI/yKNdCcUBFUzBgaKCN6jIc+p79qeihrcOcQots96+Q1WoHP8QilMQ996rvUKiQFVI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gory1-0006Rd-8P; Wed, 30 Jan 2019 15:39:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 99D911127D43; Wed, 30 Jan 2019 15:39:56 +0000 (GMT)
Date:   Wed, 30 Jan 2019 15:39:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Tony Xie <tony.xie@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: rk808: Fix BUCK1/2 voltages on rk805
Message-ID: <20190130153956.GB10665@sirena.org.uk>
References: <20190129195424.10161-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20190129195424.10161-1-otavio@ossystems.com.br>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 05:54:21PM -0200, Otavio Salvador wrote:
> RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:

I'm missing the other patches in this series and don't see a cover
letter - what's the story with dependencies?

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxRxUsACgkQJNaLcl1U
h9ChBAf/XVHqjJDE4f6/KMdt3ImoJBZgtxg2TGTThPA9aBsS25nL2VI9ElBmDvVK
Y7lSAlOe8XFpmWXidFopMQfbV/9T708b5xaRY1QWkY73bq7OszPzHqq7SPwuvn7f
mEeDlM8xtR0dOkxR2JT/r0UT4VvjWx3eSDt2zwND1tFGeQhoQ2mec0Rk5b1DLW/c
njN8MUAOkNVV5Z2jA0x3JiE5zeBGArt5zkfq2LN3yLE0DQ1AKAA65xUze3bN+SkG
koHBkMNsO8jc1J3HwW6WBDqrndgowfw8UDwQ8lHBvF/3cC8tk3ks4fEHFV5jjDG8
xEReJXlbMI0j3OyG368x3RuyeIKhww==
=2+s5
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

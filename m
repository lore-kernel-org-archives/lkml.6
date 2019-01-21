Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD382C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD8620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548074613;
	bh=6yOtvdG1NrLF/rsM/uextnIKXW7XLppBaFr/zfAqS10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CWUgEDjy3FhLNHepRPJgNNJK9Rp9G9C2S1y3LIx5LIp6ct7Q/mMB2Bydn5IU7rjYD
	 Vl/hH5Eonwn5/Nx1eIkh9Lb9u2X0Kg4G7NT1lpgCgx8obobfgz/9w+ltcfspA/JLc6
	 5Mx79NdEeFQrYxtRbXCOPmtsRLbg9DHpLUzQiaDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfAUMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:43:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfAUMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6yOtvdG1NrLF/rsM/uextnIKXW7XLppBaFr/zfAqS10=; b=pYHAB70Rjm4Reob0bZh1xFuP7
        xCK+nHUSjDiwLRBNsDRahx6RuMtWww2xjEKZKrXCIqte8kNBbDMvlpYfZbr1/NjbNN3XMEgRPCtTX
        4hF/16GA+z+pQXddLZAWQMGQ/XCbfHLggFiMfYjpfi596vKkLI1yCO1pfbGCyybAInCpY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glYvH-0004Oq-NI; Mon, 21 Jan 2019 12:43:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D02D112767C; Mon, 21 Jan 2019 12:43:27 +0000 (GMT)
Date:   Mon, 21 Jan 2019 12:43:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20190121124327.GB12679@sirena.org.uk>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
 <1548069703-26595-5-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <1548069703-26595-5-git-send-email-alokc@codeaurora.org>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 21, 2019 at 04:51:41PM +0530, Alok Chauhan wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote accordingly based on maximum supported SPI frequency.

I don't have any of the other patches in this series or a cover letter -
what's going on with dependencies here?

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxFvm4ACgkQJNaLcl1U
h9BwHAf9GAJQWLR7hvzjlg9jObQnh1ulxHG6TJhue0l5nEpwbTJUugTlEtXrvxDh
laFlozIEGlpQOIy4jqrW8QodcPFngge+AS4sn0J+X2E32btYfuU7GX1bmIOfCN2z
S59CU6sw6bvkBM/kkhVKL+vGsSmbz+4lZ+1FeEWN3MSuhWFoZZ5Tn/yCt9j7kUoH
QipZsmFJQoclLlUIRcpE5ejuOtesSnI2yC9vk/4dTSwBW4WE1L5+waGEpPzsjWZF
OlUCNtpS6/zXIDnRY7Gcwd7e/qSN1LrX0LGwx/76wIpsQRQwPOIWFvWTbWfnHFsJ
0a8wEyoYmn6fUhJ576yIXDBiIpwJgA==
=Xpu0
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

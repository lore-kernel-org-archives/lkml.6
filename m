Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E517C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0582184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548259479;
	bh=sS+DwhjjskSpudqGi4Xyvx5XWHv67xqFUYf2O8LSVOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P9aD4Gnr1NPiAyM90/SRwiEBdVbbLcfVHilAGPJ9tpbcxx87jkAe53Bi8GhOriuKf
	 3eJoMXb1E6P5AkzjBjqMQ1bKGswkxXgpEEbc82XcP7T0d4ahz5hQCcV2F8RL7Uggcx
	 3Nx5GmqhrqxEkQ2KSSEiTBq8skifaIHFgqEu+eXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAWQEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:04:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53352 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sS+DwhjjskSpudqGi4Xyvx5XWHv67xqFUYf2O8LSVOQ=; b=eZTGtFRuPxSUuIK2BYovNvr07
        7oobQaCe2ko/rvoenKiGHfwpEm9okF5AY8BMQaLSP1nhTRdA3gtcC1vgKWo2PIbWhVD+jiIZ5yMv2
        DbIlPmxG+6gaqXN1yX9cyKcg6t8D/aHQLZ6kfLiqvhpSMnAb1/hx0iJFjIb1xIplQGQ7M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmL0v-0005vw-Id; Wed, 23 Jan 2019 16:04:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0D1241127ABA; Wed, 23 Jan 2019 16:04:29 +0000 (GMT)
Date:   Wed, 23 Jan 2019 16:04:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20190123160429.GE7503@sirena.org.uk>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 12:03:34PM +0530, Alok Chauhan wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote accordingly based on maximum supported SPI frequency.

Acked-by: Mark Brown <broonie@kernel.org>

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIkIwACgkQJNaLcl1U
h9DSZQf/Z/RXV5oMQ+WeQEjgLJUGNcAKhNgh3h5Ybq6Tn1RanSJMfwLA/kY1mp/e
9ESnLPEA29E4WCaSUz80AffsHaYge162pI6R8DeR3+MsChdO5dde7S4NwE+Dc9FC
o3c5MkhxN2gMufWHY30PWI5Hzq/QsKvuLUcN9tBLZZdIXJoIR4+9iBWWbRLbqx5C
we3GSPuWlVB5xludSl9iAQmiu2FNnzahM4r3OBm4R/+dMOPWViERGMVMIEjI6rrg
yCKDfUc01EscZyJpO1JcF778OAGzaj+IF6ZDax79W+Y9dke8YwqaJVjOT9l82Xag
bdX3zyVWgDdLMSOZ+iJD7QBFq3mHSQ==
=3f7w
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--

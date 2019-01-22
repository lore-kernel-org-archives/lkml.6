Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188971;
	bh=I6Jz06NvGYNE2HACl2QTeuX+vUunHcLQLSmAVVwwuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EWvWrXs5v4gSetJorROFZKazYJG0FInKQ11IZfVRr6vYtWlzQzFAqCevRKlx82VJo
	 6oM4YGJy8k0KGZQD/w9y3BJT99sWyxzUa5PFTH43ySyD2s1bMhmd4nJawWv22q9m7c
	 NSHONSzmKm4kaTVPScs5OZdliVSC5qJYyO+l9Tqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfAVU33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:29:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I6Jz06NvGYNE2HACl2QTeuX+vUunHcLQLSmAVVwwuNw=; b=DeLq9lZRtkHrb83FDILU9VTda
        8kEByrHsl1TfXGYQloUS3HTUacjCnqYqdKqyMAbxvNJvKf7LRSJpiOhOCEfYhwvQRrHd39lFmQx0q
        mEw3kKh2vGxG8NjDT3Ud08WJP7P7XXGALghFvTDL09S9Td5m/Bce4p25m5ZCOHxtUh3Ak=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2fk-0007DQ-Mb; Tue, 22 Jan 2019 20:29:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 497CB1127955; Tue, 22 Jan 2019 20:29:24 +0000 (GMT)
Date:   Tue, 22 Jan 2019 20:29:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20190122202924.GL7579@sirena.org.uk>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wIc/V6YLA2QdyfT4"
Content-Disposition: inline
In-Reply-To: <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wIc/V6YLA2QdyfT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 12:03:34PM +0530, Alok Chauhan wrote:

> Get the interconnect paths for SPI based Serial Engine device
> and vote accordingly based on maximum supported SPI frequency.

Still not seeing anything except this patch here in my inbox - like I
said what's the story with dependencies?

--wIc/V6YLA2QdyfT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHfSMACgkQJNaLcl1U
h9DqqAf8CaMWvbpCWug3/SP/1Wojbdc+Z24TR24YSW41nHTz0VMhLtkOEtJWyRgp
1H9iY6cqsqqVJzFO42nBJgT1rk8hcdcvEHw9cGJ6MqUhnwd5IDUhosRiUNPijkgh
g1pcCZ8Y3hyC+6sKddlOomv744hJmluB1QEy9IeAEBykpE6ScHAhXgebO/iIk38j
Hj+4VdGyBq/9O5c72J3s7LumYm5JPqAtgjIYIjL9hMgeSXj39hgqX1/mUObI8X9O
xoZ1irHhtBaeP2jPyZt15XwFaCwbz2vEDUez7e7OOIY6jek1lnTUGUCYbr6tmcEF
vev6Ccup/Puey+hycNBosXTobNpIOw==
=R7VJ
-----END PGP SIGNATURE-----

--wIc/V6YLA2QdyfT4--

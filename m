Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4219C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AB120652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wViyaS8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeIFPoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:44:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0u2K94Oxi5HXSQzLX90mRE9mhp9EfYhS6RkjSB15g+s=; b=wViyaS8KlWuQrjC+OtGn6NdIy
        WhauIK/Jyf2eF5IhpB6QUmYqU3WpAPZI17RMtvk/Z2PQoFvmoPM7nQfXbuXz+eN+Fx/Qnz8fFdctp
        /kgZH5ldPcGC8ofzWelBSq3p4d0uFZLCefYFeKj1GPI+LvDGESRuUvGP1543CvFL6YgXk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxsAA-0004Aj-JC; Thu, 06 Sep 2018 11:09:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 37F671122A1F; Thu,  6 Sep 2018 12:09:26 +0100 (BST)
Date:   Thu, 6 Sep 2018 12:09:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v3] spi: dw: support 4-16 bits per word
Message-ID: <20180906110926.GF5360@sirena.org.uk>
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
 <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
X-Cookie: You will lose an important disk file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 09:49:44PM +0200, Simon Goldschmidt wrote:
> The spi-dw driver currently only supports 8 or 16 bits per word.
>=20
> Since the hardware supports 4-16 bits per word, adapt the driver
> to also support this.

Please don't send new patches in reply to old patch serieses, it makes
it harder to follow what the current version of things is and makes it
much easier for the patches to get lost in the old threads.

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluRCuUACgkQJNaLcl1U
h9D85wf/YmKZ8aHJOxpyDfdQmNcesGTi5ybZSc9SQDIs6hfflIjwDVpkOXc90rsL
q8ONe+x8RYrzp7a4Zm/SqAh8MFTfs4xIY16gQ9++yjXh+asVMoY79qFF13NyB+o9
0xy70bExYIsy+xNMMN4WcQ4MrsfnwjExFXhrZwkMCQkR99FHZogsH0Hw92SxPJ9r
A+t114XnHyMHYPpDV3VDaersBJJ4BAykA9AiEe7VIlP2yKglAv5jTc8n863npp2f
pkd0RkEmCIuyDhghJ2QQAJQNbZkfRzEWt0K7HPV5quWrUyJcVOHPhv1ISE94e//z
az+o622DzjT0GLkwmLISIgm9UD9N9w==
=vayP
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--

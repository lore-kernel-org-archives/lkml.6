Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46DF21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548241108;
	bh=C5TDLE0B1UhvrS1hRA/0SBV7uYBG7MeRLKDz/PrKhzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t6pVqNm4lUmXolTqMY/BRz79KXc1OytEz7SXV86Y8JmBI7FWeS90dIeneT5/eiqO0
	 zp5A+ran4Q8AUbX+28oe+A2iBX3hqldC4/dm5AWn8qAIbX9SYyyR2KBjebM7N0WpGg
	 oDuvRbTSBKZy/flTkWOm1fF/uxUgYoFzsHIDjb3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfAWK61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:58:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47662 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C5TDLE0B1UhvrS1hRA/0SBV7uYBG7MeRLKDz/PrKhzs=; b=Yag+NcxlbEj7FPEku0NCqAfAo
        WPhqfIHLkLkUYu0QLXHNDePq9C3ZMH0oj/uDozaTTY2RSFF8bJfRM0fEoRZpZ2+iUKe+dQz2HtW+T
        IbxCFwCTYNnTJXYvzgLRoSB/5T86tBuyybl6rAOtI4scsn0PyKIvRX5BvBi6AMSVIt8Vs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmGEg-0003R1-At; Wed, 23 Jan 2019 10:58:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B55231127001; Wed, 23 Jan 2019 10:58:21 +0000 (GMT)
Date:   Wed, 23 Jan 2019 10:58:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alokc@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20190123105821.GA7503@sirena.org.uk>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
 <20190122202924.GL7579@sirena.org.uk>
 <775cdd29a7d536772330a15a7013f251@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <775cdd29a7d536772330a15a7013f251@codeaurora.org>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 23, 2019 at 12:45:30PM +0530, alokc@codeaurora.org wrote:
> On 2019-01-23 01:59, Mark Brown wrote:

> > Still not seeing anything except this patch here in my inbox - like I
> > said what's the story with dependencies?

> I've added linux-spi mailing list to all the patches sent as part of this
> series. Not sure why you didn't get other patches. Today I've explicitly
> added you in all the patches.

You really need to ensure that things end up in people's inboxes -
sending them to a mailing list usually means they'll go to a completely
different folder.

> This change series basically enabled interconnect (as per
> bindings/interconnect/interconnect.txt) support in GENI QUPs based drivers
> so appropriate BW request can be put based on SE usages.
> here is my complete change series: https://lore.kernel.org/lkml/1548069703-26595-1-git-send-email-alokc@codeaurora.org/
> I hope I answer to your question properly.

So it looks like there is a dependency on earlier patches in the series,
that's what I needed to know.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxISMwACgkQJNaLcl1U
h9CoTgf+PA29xBdCek5fu2oi7M3F4k1fLvkUkXx08R30Xh2AEVPfA9BZTIBp64Jd
6kpDFuGII2h38T7Y02pZhtZtT+36Q0YA6WD9H7AuzupmP7K0CsqOlysR06e43DwX
8d6tloJYmZlK6isHO+iHG9ID3McrL/9EBng8OCpnIAEAgqR/Dm07L4nAx10NeU4O
n8WzQJkhCmtvgnSt+ZvF/vVdxGUEKYVmdDsNPUyNmNmH+quhPk52qnVjjWXQIUog
pULdWHaJADV5o+ewWyAj/67QXWHiq52k63uG80u0/Kp+lstEDfhhL4NkGsixeEpH
g+6VqKfMx9hBGOpnbcVgX2QpBpvhxQ==
=ssTu
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

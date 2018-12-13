Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A94C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68E22086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702139;
	bh=XCocCh+rGfkm9+gbY2BTdAYDNLJa1L9nMR1sC1iIsJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UZxXRz/yhlejvRDDBY4CIqc9llg0kUoZF6MVrTNprNz8kwWhcpiv/T/v+Oy7p528w
	 oxMk22YpT0Ynd8axmDo78IviEkVihgmgNBsm14GOSvYfBOVwc6mk1lvK8K9UUPAx0V
	 ZZVprClKNfAAiGw1jpIyT04+ExgxP5cROM1E0/Xw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68E22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeLMLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:55:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbeLMLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cf8kiObg4wBjtbCGefgt9SvikZQh9UUDOA9AYhMbKik=; b=ccAZ2qQ6RmzXAoTMyY2uFlmrw
        akwAFOJiTg5rwHafAZLOPITmTzswa24w6r/7hK3k/nQyQG8zUdW3ItMWzEEH8hhpixSdQjrUc+sGo
        9Nxptz1hYC1m7pQYwyAUI5nSdVHkRPMer4P18Uyqwh11ANDAm+6HbB0sOU5I3dFdGNh+8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPa7-0000vw-2i; Thu, 13 Dec 2018 11:55:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AB8A811254D1; Thu, 13 Dec 2018 11:55:06 +0000 (GMT)
Date:   Thu, 13 Dec 2018 11:55:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213115506.GD10669@sirena.org.uk>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 08:42:12PM +0200, Priit Laes wrote:

> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

What's going on with this patch?  Will you be applying it or is this an
ack for it to be applied with the rest of the series?

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSSJkACgkQJNaLcl1U
h9AZsQf/YXyJVoAUX3S0IL4vtOj9ZV+oUz2WshSkO8tw2qyCouZpFn3/HAvO3rVC
tgMCOekbQiTaCsZN5rEdQyOYehMzv2eiAtquWd8cb+06lAlwuyKEcnA4sRuina2G
5dtWX3bVR44H9ieqSh+Gj+G+hgKETusnPSEow8huH/esy3xJUFRBnvavlDr/J6aK
uZ1rYvjvgpR6TmcgZr0lwJiCBiPVQcc7sH4q7BiqA9IAs4elQGP41uh5W2gu6blP
gX9pvk2MePsoJY4KzFzbcS/cAdt8Tg9v6xpX2+JvwOE+7gnDStpOOxiVgmANIcxr
Y8anygTunjAxEQ0yqWTz3cBYaTxASg==
=ZyRL
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

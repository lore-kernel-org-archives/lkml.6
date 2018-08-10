Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B04C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768DC2242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lR8kzG+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768DC2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeHJTAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:00:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeHJTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yTkDr33tScXwB77cW6QGhr3sB9hkG+WH2/p7aanIwPI=; b=lR8kzG+fLl1d1rbo/FBesAUHR
        gInqfmfJ1EA6ZedWx9gE0zu6rFtfTAOXjTfjJMM4oE+Yb0fBxJFmQbmY7eA3sfkqAmFU+Jcwu/uF7
        D7JYFV9LBbzsyLDPFisU0NLA+sWRdZxdD2tQZkxNFKJovuF12j8EApDJxgrGJoPhJxdSU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foAHw-0004ru-Pk; Fri, 10 Aug 2018 16:29:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 70ACA112435F; Fri, 10 Aug 2018 17:29:20 +0100 (BST)
Date:   Fri, 10 Aug 2018 17:29:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH v9 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180810162920.GG20971@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 06:50:59PM -0700, David Collins wrote:

> +	switch (rpmh_mode) {

> +	default:
> +		mode = REGULATOR_MODE_INVALID;
> +	}

I'm not sure why the break statements are being omitted in default
cases, but I do find myself stopping and trying to figure it out?

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttvV8ACgkQJNaLcl1U
h9AVEAf+PwJei1gP+kqd4Alr2LPAKXL4NorS7ssYny2+0zOCpf8eby40kxVR5SqL
bN5VjqG2U1KnEjE4Ff1ROxIZYsiWTjzfpU0wMO/waNdnLYpz3CE0Hp/CpZ/qJx5A
Oigh6G1M4olEbQEddYU2aPRxIHhn3tdwpgBVkcGml53oq28adakeDeF9Pnxa/eVY
bFc8HZuSq87W3JJVCByyB81qrntgBM//Mnhzm0G0vA3xNtFq1QktAv6kt9X2vb5c
QYH0mWUNsfv1d+ETohJ1HALsrsxUVUbWMThFQ6n3i/GjLiCePyfDI7jqAXpdn/yl
cjyoDf4ctT6qfPb0eRv88rkX0RDIcg==
=1kxy
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--

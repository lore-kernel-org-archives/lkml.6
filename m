Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44768C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BFA208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fWU2n1zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BFA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeKNEBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:01:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNEBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qC3xFPdtzVUc0cwL7IGCduIRGpbo2e+8/Ljp6selzoM=; b=fWU2n1zp4Pv6lh+IBA9KNgJ41
        +9XxZIskZBjks80FgPM/D25k/UAzHs3Z70FZVwGZnilK2aPixl0WbVoP+XtRxtbkbypWaULwCeJNa
        iKTooKlu/nIXZuxALVvE18vGXh/tITJ3rQcRVChrktnoMsloe4RTAKakQLDBUdD+yVKD0=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMd18-0002MY-LA; Tue, 13 Nov 2018 18:02:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 732E8440078; Tue, 13 Nov 2018 18:02:20 +0000 (GMT)
Date:   Tue, 13 Nov 2018 10:02:20 -0800
From:   Mark Brown <broonie@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator/of_get_regulator: add child path to find
 the regulator supplier
Message-ID: <20181113180220.GC2089@sirena.org.uk>
References: <1542001987-8352-1-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1542001987-8352-1-git-send-email-long17.cool@163.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 01:53:07PM +0800, zoro wrote:
> when the VIR_LDO1 regulator supplier is it's brother,
> we can't find the supplier.

I don't have the rest of this series or a cover letter, what's going on
with dependencies here?

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrEasACgkQJNaLcl1U
h9Dtlwf9EzcUPrh+hMp4vEc0klI5ypjrHq4EunAm9ndhz1mfMeGOZJaXL6OjWeAS
Mk64n/q+w8fnjEVwKzWJaekK/Rn2aTQi4DBWPfpJmq9hLanLZvfv38QVddLrEdpn
0ZFqsH+Dks9/SI37ZYi0r1gxNxdwUo0JQcdnuvfD2UaG7j4VMBKCPtoGthYagZRr
O1Wry3x6LNejgzJZ7vA5z5Y8SksvobSRRoIRyQF8JY6HnHX2tooOizttF/XJn67N
/creXvpeTcdjs7o5Idr5lEFDOZykRrl9MJArmS09mw8mP1XFSgf6RNJaVaeTFgw/
o0cS/dRigWapr1M4qb/z6/KPzso2DA==
=n3Dv
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

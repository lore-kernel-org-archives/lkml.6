Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D99AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA9620890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TyuDVCP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA9620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeILRck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:32:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LJ/0jNX7jDIeXyJgvAqi2ST3/Zxfe/VRFFz0ZuJd3Qo=; b=TyuDVCP7p3bK6HR3HQ1stL7dN
        pPOG7OywdU4vBSjJHSnrtirnbQHakeWYRXhpH3zaqGZGiQ6g1eZ6V7+kxdHC52TREQoBt9Y8L1wvk
        xQw1goqcsxPR1Det3Mj+147/2ewYlG9l8BiNjzCMDR3JHqe3Kpd3xlhWdHhb+NhA1f844=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g04Fn-0006fG-5j; Wed, 12 Sep 2018 12:28:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C8F701121C6A; Wed, 12 Sep 2018 13:28:18 +0100 (BST)
Date:   Wed, 12 Sep 2018 13:28:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org
Subject: Re: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio
 support
Message-ID: <20180912122818.GH6062@sirena.org.uk>
References: <20180912121955.33048-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <20180912121955.33048-1-cychiang@chromium.org>
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 08:19:54PM +0800, Cheng-Yi Chiang wrote:
> max98927 codec driver will support reset-gpio binding so it can toggle
> reset line in its probe function.

All GPIO properties are supposed to end -gpios even if there can only
ever be a single GPIO.

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluZBmIACgkQJNaLcl1U
h9BtAwf/W569laNPEtSJDjZPojzO9JM3hTP+83xOgBSvB5xBu81+4NxbNDxHbmVY
nQhGwx926DP+P6Lq2a93i88OPzuqL4av6Ox5TqRQnSQ6eIKagvo0g1pVicxO2Oiz
7sP/xY35CM5EvAwsZ7EJliSp+T3yGg9RSDldwsoJ1a/jrUBSASGZgnVuxFHYupve
BDIL1uXgmlDvAsGhsxUk+esoegPr2mssGLbvzYySIigjH6ABPIUVM7Hq5QshiGAW
0FztykdUG/NGBNFPK+JRudbFzolHQk6DCM7wpruculdc2e5VjVc2x+mmny8yUXvt
CozQJW7RZVUBE688gFrM0tET6DFtug==
=Ld/T
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--

Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E58D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VLqCX+TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGWTPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:15:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nJcymvOwNnezM3j2N7zKpj8nmQAmrBvm9u1XCGX/FmI=; b=VLqCX+TL53Qpz2HOmdbGYwwFh
        mhiPt8MFRoU2JJcfVJLkFkQPZea76ycJQlIQQ7WHtE0FL1FIv34EXpcVwuRgSqFtmtFZT+Fuk9qBf
        fXH9L1OnjonFc9kAPFC8EiQTIRpp56gWhILBrgMryOsYPF9n1ULUaG35gYYFF09TLGm4o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhfKh-0004Qa-1c; Mon, 23 Jul 2018 18:13:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C544C112387B; Mon, 23 Jul 2018 19:13:18 +0100 (BST)
Date:   Mon, 23 Jul 2018 19:13:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Message-ID: <20180723181318.GG13981@sirena.org.uk>
References: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 01:58:26PM -0400, Peter Geis wrote:
> SW2 and SW4 use a shared table to provide voltage to the cpu core and
> devices on Tegra hardware.
> Added this table to the cpcap regulator driver as the first step to
> supporting this device on Tegra.

This also doesn't apply against current code (though it does now parse
OK), please check and resend - make sure you don't have other out of
tree changes and are using an up to date kernel (ideally my regulator
for-next branch) as a base.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWGr4ACgkQJNaLcl1U
h9AfwAf/XCwGcE+K0zhJxp5j0yfWe0ruL2GQZVNZORD39f7Y3xuhkqBcRqQcP5jV
EGizT5CzcVbfgyo7jXPpu4aVI8zRmwdoAEWTGAqoqxLB73mLyg/GEc+B2um07ztq
4ryRefWuKmSH0tDf8fuQSX07HHHJ0+LQlhVQJP1XAcR5L1gOHqbMrpYB0TICkpzv
xibhvMfa3wFZl+Qzr1jAWphL7NJMlgYrmEyv/HKSTD5yPu3rIsYhLEVy9798Ddvc
T//HxkEJkvNJ8kvbAIqyHtQgF6ARbN3zzcsVKwvurw0noprRFAyDw7BdydIn3pDB
2MKtVDAXuwHwyUhc2G098DuOXEnSFA==
=Qbeg
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

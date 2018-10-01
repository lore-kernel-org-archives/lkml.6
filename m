Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4E3208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tccwaIER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4E3208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeJAVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:00:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJAVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q1iZ4bqq+vG1rFgOhZiuBPNZIKqkfVgkAnLPbJRfkHA=; b=tccwaIERuxF+vLf02ABDTxpWO
        9uVesws6SLPuRlgaeun1KMFHWZwEnR5SeNQ9DTtHYltxrsWsyllyViVe7zrC7YZNqVkyQShhde3MB
        l+AE3VE48Ab8A46nhdTa6heOyxdF17rRTrUSsA87vY674JWpmFw1QDOmwF2ODMOG6CmIw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g6z5X-0007pc-VZ; Mon, 01 Oct 2018 14:22:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 81B8D1121CA5; Mon,  1 Oct 2018 15:22:19 +0100 (BST)
Date:   Mon, 1 Oct 2018 15:22:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc:     Lukasz Majewski <lukma@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with
 spidev driver
Message-ID: <20181001142219.GB19099@sirena.org.uk>
References: <20180927223152.24990-1-lukma@denx.de>
 <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:20:32PM +0200, Jan Kundr=E1t wrote:

> Hi Lukasz,
> I tried submitting a similar patch for another devicem but got no reaction
> [1]. In the meanwhile, there has been another proposal [2] which moves

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluyLZoACgkQJNaLcl1U
h9DH9Qf/SFVF/bDGp17OoeMy7ATxeW7zOlHxpeL3lM+opXvngLi1zcktNPRyjOz9
Hhj1g1JlATLU7HmbqDXhF5uZCTS+vN7AIqWg8uYl5ilEuVuTCgUHLc2R9YgAVAro
/r2fVn/cFOgbfd+xj2hrgtbvZupbAIlynIweEiCJVGJQrAi96edBLHI5Ha5RgVR9
lOtWINYAayeZf5J6oR+dwyAMVGISIajyaHdxaPKvd59Eu1Mexh9SWuNYu5ZdA4ue
JWFgAGrql4jHH5lHf9Ggjj1ouEy+BCZfqtUpJCv9Wdbh+X20NVIqN92buHf+7yyy
uMvoqNjgiGs9XjnlV7Aq8/SldLtDoA==
=cu4q
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

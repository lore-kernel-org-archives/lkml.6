Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B25C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EC4259F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BaAbQFZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EC4259F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeFYNHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:07:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SUYkmoKLYhiANkgEC7YweDdkYW/1K1zWLSMv9+j61yM=; b=BaAbQFZFliQVMd8DXDuEvQTH1
        aG9XYD0kJBOhvAasvPAJPWghC1n9qzwePsIYjcYnjbUlGrfAhYjqw2HKN2nEYIJhApHMPtJc1FWNb
        ghqr4Y++t+35JFiQgNsLrGOgRDoQeMCt9ld8YxNa1MHo5rVxQ2NNm6QGqV1QpRB680/Yo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRCy-0007qz-HZ; Mon, 25 Jun 2018 13:07:04 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRCy-0007zx-2h; Mon, 25 Jun 2018 14:07:04 +0100
Date:   Mon, 25 Jun 2018 14:07:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Message-ID: <20180625130704.GQ9413@sirena.org.uk>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180618104159.24b9fffb@bbrezillon>
 <87d0wnrhqz.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vsi50HYs5tPfr+1I"
Content-Disposition: inline
In-Reply-To: <87d0wnrhqz.fsf@belgarion.home>
X-Cookie: I'm having a MID-WEEK CRISIS!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vsi50HYs5tPfr+1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 18, 2018 at 09:56:20PM +0200, Robert Jarzmik wrote:

> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
> checker to be fully covered, and I'd like as well to know which tree the ASoC
> patch will take, ie. if Mark commits to take it, or rather wants to pull from
> the imutable branch.

I'll pull the branch in (a signed tag would've been nicer but it's not
the end of the world).

--Vsi50HYs5tPfr+1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw6PcACgkQJNaLcl1U
h9DjMAf/af5+btMq4R9XHetdh/iAvu2jYHAw4/iyHWOKMS8MDABxBEz/3eB2XlUA
35JbCDcC7RYyk41csobZ7/CnhgkTM5HOjyLVHs8OOYhAOSrmFK0sDoGg884OvlAp
F5WNWOsmiqGfJEUoiSh7SoHtVi+cN3snsAcgX2yJtPlmyMcRodxvSMdXxjACwDoE
092a9LGzs4WYoPqdk8zszqY+2cu2HLH2aXvB1oplkwbcyJYB3VkO4Q0O+7o9AvMM
26QSPG26ufIJY+/ZxrO5BWsZrs8QlOAAhLjI65FITchHfVEoBxqryQbGk4MjpG3G
VAOCzizL4A454dl/xHPD8erqdXCmVw==
=EUsN
-----END PGP SIGNATURE-----

--Vsi50HYs5tPfr+1I--

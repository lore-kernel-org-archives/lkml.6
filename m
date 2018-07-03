Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56837C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE624210
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IubSChTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AE624210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeGCPcQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:32:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933530AbeGCPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OrRrh/6sBKLzweLWsnmPw+3v+tf9vVOiHUp7L+fLQS8=; b=IubSChTx467qoF77sLsEVd3FI
        bdd2/wWRb0VKMgTCnMgXeGx/Vu4Zyo4Pm4uRSFZTn9In/IWsZlIx41jAcGDQm+5h5WK+/wpbNHW47
        OaUYuzCNFWqHWzMJwQAR7YQYuBgWymQ5Y4guC0Ua2/ISQNZ9KMpAms1d+FlteouqvbBgE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNHp-00069g-5k; Tue, 03 Jul 2018 15:32:13 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNHo-0003WE-My; Tue, 03 Jul 2018 16:32:12 +0100
Date:   Tue, 3 Jul 2018 16:32:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
Message-ID: <20180703153212.GC13744@sirena.org.uk>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20180703132845.26554-1-jbrunet@baylibre.com>
X-Cookie: Dental health is next to mental health.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2018 at 03:28:43PM +0200, Jerome Brunet wrote:
> Add support for the es7241 which is a simple 2 channels analog to
> digital converter.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7lvsACgkQJNaLcl1U
h9D40Qf/TBe4I8pootfIqHDb+wyZwfwj9U1ajEgbwLF8R+hrvuKkR3f7LuB6DfRn
oieN/hPIVQumKtQxjihCxXYS3DhEOPTpXR8qvNowneU5uKXBe/ZrHznXUqWMVFlR
jkLkEhrLzv9XZmsinD96kxiqrVpuhpfNC5+LMsSjELgGCIP4H98uLRcUeNStFZgh
8o2ezljBy0zfVpkfBafJP8UXnhSJ5spMpKmfPC+Eg20/OI4ICHyQfWVAXUNb21In
yCY5MGvgqSx2SpgmjEwAA+Z9DCytf3HFkyqmILpY1qSrQ5RjCy+cb+dcq3GnVP6K
M8ahIzv9qzF++IhN8GQjALhyNQfsXg==
=D2OE
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

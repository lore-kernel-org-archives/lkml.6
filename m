Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A3821A07
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LEOVQOPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A3821A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeHFOB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:01:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50068 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeHFOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OM7nWUw7C1g24oLUWb0sR+wnPK8Y3Em408H5UGkTVP0=; b=LEOVQOPgzehYjCSgcRaQjgyy2
        Ub7viaFeCOw7GigezJQjDcSacO5jjOrMEVMuPxDX7nx5V1WHADzj/dbdMlqudQNbN0nECwIf2j6rs
        fFxBrB/2/Easz8nE5H/1qGYOk4fsjMeHwWmpwM0wcvktnTdJort4TvnJvMyg4Lqjo8w6w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fme4H-0007sY-9q; Mon, 06 Aug 2018 11:52:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 02A231124240; Mon,  6 Aug 2018 12:52:56 +0100 (BST)
Date:   Mon, 6 Aug 2018 12:52:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     valdis.kletnieks@vt.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Message-ID: <20180806115256.GC17525@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
 <20180806113426.GA17525@sirena.org.uk>
 <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
X-Cookie: A song in time is worth a dime.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 06:48:13AM -0500, Gustavo A. R. Silva wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> OK. I'll send a patch for this. But I wonder what's the best approach in this case,
> so the fix can also be applied to stable.

Just send a patch, a fixup can be done when the backport fails.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoNpgACgkQJNaLcl1U
h9Da6gf/dukgSwGIXxOxmgpBKOx6lqhNe2fZpx7a+q15BfKjqHYs6BQAN2HgVFxH
rpqZAEaBqAbwzWl19VCVR6mOg1837QyZuLtydHnQRtiJXl+vvDUCvhu8a/ARWINu
FBYCwHqKKWb8YMsYvzCq5HNYu5v4dIzTeqrTBXrz0XPvJ5Us/r2big1mQXy1jhLl
FqA9wUOtXX/ItN2I5zOkseOlwiMW68fgLkEK3FqnaWWlTEuCpvEE0TA5P8ubFiK5
3y+Em38HkQpeKa9P2MBU2iWldO8wxc02/v5F3zCqDAiUQdNVPC3ahHR8BkQ8Y4Kl
T8pJfB6IFydPp/rAmQBcGML+DegYhQ==
=v3dR
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

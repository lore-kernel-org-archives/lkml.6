Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8482271EB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dDItYa74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8482271EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeF1KPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:15:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40414 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeF1KPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SNrmK1yr+84g5B9kF/FQU+OqGNUp8o7tfzwycjDqmY0=; b=dDItYa741PIV70Vn1nxpE+18w
        43VxCCuqwf4EaPdWBpNO5nSayY7G3S0cDki1zbxGOyOqmygGR1vlENO9p73P3dRCii1qUzkmCTqC0
        qkTMA3Noo8mZCikEAjyFYGxtdo2eouAjsbKzNIDQSQWWqmp8Xzvs4jeKj6G36WV/hWbhQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTxv-0005DN-2n; Thu, 28 Jun 2018 10:15:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTxu-0003mN-Ln; Thu, 28 Jun 2018 11:15:50 +0100
Date:   Thu, 28 Jun 2018 11:15:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu dai
Message-ID: <20180628101550.GC14040@sirena.org.uk>
References: <20180627094818.5885-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20180627094818.5885-1-jbrunet@baylibre.com>
X-Cookie: Money is the root of all wealth.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 11:48:18AM +0200, Jerome Brunet wrote:

>  As you've probably noticed, this patch applies on top Jiada's patch
>  pf4c277b817cc ("ASoC: soc-pcm: DPCM cares BE channel constraint")

That isn't a valid hash...

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0tVUACgkQJNaLcl1U
h9AXqgf/bFZ3U6fQ0m/FOjnECHppZxMEAwcwQztAjy+d7bSmc/LaKUJDrjy6lUyx
VH3WJ4z89OtBUkGEq0CSo2qZfnUHEtZg8EkGFOU35rMnEpNFkSPRwwMynKFDp7KI
Vqsng2rnXiCU25rvmL1wWFMhTr4byacwpX2DfY4H30Ug+NAxIttR6pnSEP303HfI
lu3f5Z2FZJLh8xrKJ6J1Kq9z3npg6nIgjYpozTRK2W43aJioczvI7UFOyCRgJhcR
t2bveMA+s1MiStlyL6x3lxr9XwNJumSjxIRs2YNQzSm1moKVaDfirHio63rAZ/Wu
s8SCDKB9dDs2qnCQJOdWsnIMFhxa6w==
=3BW4
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F3EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34FA20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bKg2I7xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34FA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeICPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:19:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IEKCg5SSdxyYCSOwvKSrp7pcclE2YG83Cyxt4aPmehg=; b=bKg2I7xxFtWvapTutCjnRbNVx
        gwTqoPbtaSK+J+MNk5vMzpQDliwNtyCvDZVCuA6Qd5l/MPvE1MeLpS56aDNHjDnBDXjA7vabBeZxv
        h8zYhcVVquSv/RQ/887TiuV6THunGjiql/2Am2nko0li94nga+nDv59U2l8NGeFjc8flA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwmZj-0000Af-7L; Mon, 03 Sep 2018 10:59:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D302D11227AE; Mon,  3 Sep 2018 11:59:18 +0100 (BST)
Date:   Mon, 3 Sep 2018 11:59:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: fix kernel-doc parameter warning
Message-ID: <20180903105918.GA10302@sirena.org.uk>
References: <6307dcdd-7e4a-d708-eda8-b81edbc8e52c@infradead.org>
 <31c46cf4-6acd-7e00-39e4-e8540f3fda9d@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <31c46cf4-6acd-7e00-39e4-e8540f3fda9d@infradead.org>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 02, 2018 at 07:36:40PM -0700, Randy Dunlap wrote:
> Sorry about missing the Cc's.
> Would you like me to resend it?

Yes, please.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNFAYACgkQJNaLcl1U
h9DtRQf9GHOgaHEAs0iitrL27uEDpQ4eMfeGvV5MDlPggMwioNL0wHyuqMNRMQl+
8DE7gYgQeHlQEFbpCvUmiK6yzIRdMSw+TcYVbdbEvE6yRP7Tx9jvGOx32eQAJHwY
+EW5SHqHRdyWRNq1PPcdiC4kiYaUjYN/n35TZzVZj3NWpftP1L53Ng2iR5ihknhF
z8SP/KbcxncRm/M+DwTJj2awkXlBpUClZIbkOtvOA6qic0YIArLIcY1ans6Caatk
sBq5TKmA2BYG0Jd0iOduOlBnR7vxlMZEBMdtM8f43jbgOrDfWlynaezwccDXzxd7
F/RU+1Lp7PynZ/XadrxpOZRGSP/+Ig==
=jC5o
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

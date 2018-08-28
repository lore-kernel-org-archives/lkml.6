Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70276C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182B72087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="D8xU3OrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1XWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:22:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeH1XWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Hu6RSKzR4pgceCJOqf6lNA6ZJOTC1Of8W4Z7GoS/ps=; b=D8xU3OrJp7tj3CwhZLF4fKYSl
        AmObsRXTZ3prGeqX28y3mkU258eY9PjerU89WEidPhAW+4adg1ocKe+vdzFhP8uDcBY9kW6OOnTpX
        frDKJ/iY84MkUCafI3flrQ0+7RLcMHngwE8BaCpjI39Aii+7vm4Y3QkInU1WHZumuHhmE=;
Received: from 94.197.121.178.threembb.co.uk ([94.197.121.178] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fujfw-0007dv-JB; Tue, 28 Aug 2018 19:29:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4F412440078; Tue, 28 Aug 2018 20:29:02 +0100 (BST)
Date:   Tue, 28 Aug 2018 20:29:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     lgirdwood@gmail.com, mazziesaccount@gmail.com,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] regulator: Support regulators where voltage ranges
 are selectable
Message-ID: <20180828192902.GO2414@sirena.org.uk>
References: <20180822110507.GA6177@localhost.localdomain>
 <20180827121910.GB2448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CoNbBaeZcnNUO34V"
Content-Disposition: inline
In-Reply-To: <20180827121910.GB2448@localhost.localdomain>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CoNbBaeZcnNUO34V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2018 at 03:19:10PM +0300, Matti Vaittinen wrote:

> Other than that - I have BD71847 support almost finished - should I
> send this change as part of that patch set as these helpers would be
> used by the BD71847 patch series?

Yes.

--CoNbBaeZcnNUO34V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFon0ACgkQJNaLcl1U
h9D6IQf/cA8An8ld8frkX/tjiStr7nNIRIbSh8woyanQ9RJxH+A3sf5/OkEgchQS
6lA23E5m4CfsLTcc3F4bdZV6dx1oPT+IIpmzVV9cgdAqkW3J5rGz0WbrKjhehJk4
2dHnh0pYxXuu8BQFcEs1KwV5OyicTnQpTIRxZV0Ca0PKvlEXzOqXrWt4+KwgaZkI
iiXHVvNJdhLjJTtjI1c527GjlP6QrUI17c9mTwSDwu1Krho7s4W+vnV15wgXUMbP
5/9aoBfXxw61QmmUsb0ynfGwzZyXzpcRmRtnm0sLXPpsEKGnf01uGbQov9Rf5X4i
WI8A808IqfnkQan8yiwY8bL7u3BzHA==
=FNfZ
-----END PGP SIGNATURE-----

--CoNbBaeZcnNUO34V--

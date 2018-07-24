Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA57C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E29D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gE5gVCnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E29D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeGXRJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:09:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388449AbeGXRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zBYLb3+w5ra1L6+Hm1DiVHoqOD0d+mqMkRdS7aQg3uM=; b=gE5gVCnf9IE0ENgaENLzNk94a
        aB2V503aNZxqe+6/lU+kpPeI5J9opmXFKGyuZtWdJGfXFBi/W7sHTT2PPLVBNoEcmxNXXBGl5ecSM
        cUc2VsKJOHLjZzmGnuIYZ7sQsa0AVu7t3b3V3UYZemzRi4OqiJfbkW6ZBGzGGV5eWU9P0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhzlU-0005aN-4n; Tue, 24 Jul 2018 16:02:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D8D2D1123A86; Tue, 24 Jul 2018 17:02:19 +0100 (BST)
Date:   Tue, 24 Jul 2018 17:02:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Message-ID: <20180724160219.GL13268@sirena.org.uk>
References: <20180724132541.17039-1-pgwipeout@gmail.com>
 <20180724132541.17039-2-pgwipeout@gmail.com>
 <20180724143634.GD13268@sirena.org.uk>
 <2ae14535-c14f-c50f-c76a-4406f67fc682@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfwNdt5cNUUjB/69"
Content-Disposition: inline
In-Reply-To: <2ae14535-c14f-c50f-c76a-4406f67fc682@gmail.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfwNdt5cNUUjB/69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2018 at 11:52:48AM -0400, Peter Geis wrote:
> On 07/24/2018 10:36 AM, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.

> Copy, should I resubmit?

No, it's OK - I already applied.

--rfwNdt5cNUUjB/69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXTYsACgkQJNaLcl1U
h9Ai8Qf/RJGQcOwXjcpvABiVn1wmCoRrkiXmueWqczSJ/GSU4F6q38txXbk9uL3E
GnDO5cQ39uCtFTVxRMOY2//m7tkcKMFOvolXH1+irYBuu8WGw+fBySOXw8siE+yT
9DmVQvM89Crl2QW2gUqbCRoCH0rq6YJOyK4scLlY7+7edvQP66NWzr46qYezSbCg
GBHP8AoxptMzPexi8ZnrKQB6DGsIeNAHJNibvAv+yiY5ixGBVPgQlGuQDmUQ83Tt
Dr5Zl/k9tk3tURLC5wNCHwoOFH4Etbdfearaq3+GnBz3htisWWDoDjRDqES0LAaN
arm6fX3YdnsP3jzAkAlPE1ThcOIXmQ==
=XWM1
-----END PGP SIGNATURE-----

--rfwNdt5cNUUjB/69--

Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A238C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538435;
	bh=fw77r5/haqirXFIgRiHHi3hxy2ueWOxJPqyM8WRVFMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=usTV2H75ZbgMoSNznFB7P9+1foOiXdD+kBnw5KU9KpIzglABVWt9r+8TPLT0GOcqP
	 hUSnB03VyRbzvmnYsoHZ9A+iSj//hpTb79eqP8278XrEos1whDqMq5BNrJ5xNCcWZD
	 EqjlR479XbkNsS/onHiSujPofjCCvG0PBZL5qsi4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLKO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:27:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeLKO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fw77r5/haqirXFIgRiHHi3hxy2ueWOxJPqyM8WRVFMI=; b=JCfPiGb6AyElYps8f253Q9p92
        QS1UxNuRKCNo2jq1+BriI1RlqBs+7EEYzMcHyqcDb2GH3jP7tc8BlqNsCq5UIjHILFyDMNDNAtCQ5
        8aHULU7MTVsP2+KL1QMSQNJdhH0WDDNaKfeJVwNQJQiijMRzeUjX4Ju6gRz1tu4tfOspk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWj0C-00017D-0y; Tue, 11 Dec 2018 14:27:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AA7CE112540E; Tue, 11 Dec 2018 14:27:11 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:27:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Add i.MX8 boards support for lpspi
Message-ID: <20181211142711.GG6686@sirena.org.uk>
References: <20181204053247.27022-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20181204053247.27022-1-xiaoning.wang@nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 05:33:38AM +0000, Clark Wang wrote:
> Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

This doesn't apply against current code, please check and resend.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyT4ACgkQJNaLcl1U
h9CrnQf/ZBSz5CeqyeIQeBN4+Uh0g0vyBoUuQa1Wil8/mF0B8HoepWmOxryVfPN7
wFBVnyAYvo4MhqRJ9dNnMitMYhf0DmlGJbfluDnXckMV5kqRlyPe7ZsoBy19KvcF
onhR5ZO/WumtuZD2y3p2+3JQq3szRTP5nWPS7MZkTc6dOdwfRMYm0L9ufr0T91EZ
WKkQR/XHeju4xuvQrI1yLnLKJT/ZwYO7Zbu5hCyMVXAjfT3LYaTznxIBu4JOwPfS
9HLmk3I5Ictit8vDrCo495diHTjztal0SOI4aeGcXJIpXRKxCDuuqmuJMKGcaweF
MJNepF3FG1cUhhyJ9blV80/O5k0hLQ==
=c6VF
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--

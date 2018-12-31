Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1321019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546280952;
	bh=3zMcF2KEX4ee17ZLmsSdZXMFVWf6Mq3KQKMusvsRkKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KrGi8zjvwKBFoFMtxTXv5E7Kpb+6JdiXfA1eVYjTEWzTi4MMKit4VbduLBaeawUXN
	 Wd5ZjSweiDg5D6whnqXkXEOP17xY2245MC24Hq3PvwYwJ7ZHmt/dgQD6Q0Sy9colIZ
	 mGvBN8XaRnF5jMOJqERXAFkIXOYz57TIfbiK2Z6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeLaS3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:29:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeLaS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zJ6KP8AYB+QWekcs4ggyM6Q+bcyBYTm1dsxFOhU2ngw=; b=lN52IYZbivr/6e1Iq2bWQUzrM
        fZlDa1/etKF2icV9F20tYcTTuAXWc8rkr3fK6QmNVRLKntXhQqpfzbXyFGXPd36b/8NgEGE6SUDDg
        CKZof7RsVgNYM8amTF7mjTQDdLK77Hz8OXnP94wGyUg6CKbzrHXjQRhQusDbbj0OS4298=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge2JF-0002VJ-95; Mon, 31 Dec 2018 18:29:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5710A440080; Mon, 31 Dec 2018 18:29:04 +0000 (GMT)
Date:   Mon, 31 Dec 2018 18:29:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <benwhitten@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org,
        Ben Whitten <Ben.Whitten@lairdtech.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH lora-next] net: lora: sx1301: Fix radio SPI write
Message-ID: <20181231182904.GJ1846@sirena.org.uk>
References: <20181230084427.32623-1-afaerber@suse.de>
 <CAF3==iuRn2juDJHkqyawxTj7ko0kGMaLdi8QsRpWswKUCS3woA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Content-Disposition: inline
In-Reply-To: <CAF3==iuRn2juDJHkqyawxTj7ko0kGMaLdi8QsRpWswKUCS3woA@mail.gmail.com>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 31, 2018 at 12:14:34AM +0000, Ben Whitten wrote:

> If the regmap_bus provider does need to apply the mask, can we get the
> end device regmap_config and apply it from there?
> Mark what are your thoughts on the route to take?

If you're getting a byte stream in then it'll have the mask applied.  If
you're providing per-register read/write ops no formatting at all will
be done, obviously in that case there's no need to bounce the
information through the config.

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqX+8ACgkQJNaLcl1U
h9Djwgf/f9wfIU7fjZkputX8arBtl//RHJx9zQr8OnNkxm93gfo6DpTHnrW0tVFR
d5lDRzFRJgplNEVUgDjh08lUrbkXO87TywFS5RVgPylRefAEYAqXjKg1zhKMwww1
6lnvmlWF8l5jpikt18Uocb78wfbT05BJxa0Y3NhMIQhbGuqKu6hkwUwxiJmoTpnV
J4cB+SXj6+sW5Jy2YrPttUcsMAoQnfSOZxFgacvEz+rFf1dBTIbQgKSvXrGDzn7F
h+gxVrYV8UedZow9T/FgmVGtVq5QIy6s2VDMUzATWYNJiP1WbafaDq0J7oU+UHKU
gl8jZei0UxcmWZziOX0u7CMXY2+i5A==
=vr6s
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--

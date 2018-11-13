Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06506C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B588122360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ryQapDiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B588122360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbeKNIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:47:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8v2p3trLck42F7f6sGdJAa3jV0A3R268Visna8Cw5eo=; b=ryQapDiGAFWiTpNfhVxxGS2mX
        eyS/bKc+9td83Wd/7TMePy+ilt4VO85k4GuulbcjqxyfRldBM3B+MW2qD/Q95t2XpKKEzBDUCKMEV
        /iimjE4sspQUQzJ8KZNKIMlQYVsWsBl0gr4PYoWcvxkpeYQ8vpgyIeF4GmpxC+H332u+8=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMhSI-0002iU-Bb; Tue, 13 Nov 2018 22:46:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7670C440078; Tue, 13 Nov 2018 22:46:40 +0000 (GMT)
Date:   Tue, 13 Nov 2018 14:46:40 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com,
        tony@atomide.com, nsekhar@ti.com, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jsarha@ti.com
Subject: Re: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio directories
Message-ID: <20181113224640.GP2089@sirena.org.uk>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwXh6gFRjCd3qPCM"
Content-Disposition: inline
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwXh6gFRjCd3qPCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 10:37:45AM +0200, Peter Ujfalusi wrote:
> Hi,
>=20
> This RFC series is on top of the omap-mcbsp cleanup series:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-November/141604=
=2Ehtml

This is all fine by me.

--OwXh6gFRjCd3qPCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrVE8ACgkQJNaLcl1U
h9BLxgf/UXNPlAVXSFIQj/ApSPolYc3LrfDwS5Hgu+VziokQL1xCw3saHmM0/boH
UgrCxR95NaGZfeYX+qxj0p+Mi7lGWlUCQ7pmC7AL64AUOdOX1TgBw7Hhcq4vdYIo
rdwMvX2pryzlBrUcMDIIVULL3eZMW4M06eeIz8nfLFUfMMYK2kDoTCKMeppI6sOm
otNsXZl636421Tl6fs/ql5RysKyRBpy8ujHmzbG9qzlcpg0GedH8psM0Qnsb/vSq
2trDoGZ70sE36ydCLurdXk4mnOeiY1qtfeJwE9U59AmxtEHWKQAKGVdmUBZJdb+Q
p1cVrUTKs0rtNEuTocjiq75aGyjjWA==
=lt85
-----END PGP SIGNATURE-----

--OwXh6gFRjCd3qPCM--

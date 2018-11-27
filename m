Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD9C21473
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oe7bFgcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD9C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeK0WlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:41:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeK0WlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vBYlaESXTGr3tx1K81WTL0zjYBUU+CvSzryrR0d2NBc=; b=oe7bFgcyJT/VAeX9qJcLCQ/uZ
        dn69xG9Pggij941NmJKMcrMTSpG+k9WKEqi/dbAFoKbjmiY0Zm0YJ9BdHZ+QD5DDg3D0/65CYwL1C
        OHux9fUDJAK4qH4nFqQ8OtEk9j0KhqiV9u1i6mVC3LAQZf2h15tTiHWXkgzDuzeTMY4U4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRbm0-0008Ru-TG; Tue, 27 Nov 2018 11:43:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 54BB91125056; Tue, 27 Nov 2018 11:43:24 +0000 (GMT)
Date:   Tue, 27 Nov 2018 11:43:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, ryder.lee@mediatek.com
Subject: Re: [PATCH v2 0/1] add SPI driver support for mt7629
Message-ID: <20181127114324.GA3206@sirena.org.uk>
References: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
X-Cookie: This end up.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 10:29:49AM +0800, Leilk Liu wrote:
> From cf719ac350c36cb58e2013b58f73ad04f6981384 Mon Sep 17 00:00:00 2001
> From: Leilk Liu <leilk.liu@mediatek.com>
> Date: Tue, 27 Nov 2018 10:18:30 +0800
> Subject: [PATCH v2 0/1] add SPI driver support for mt7629
>=20
> v2:
> remove "mediatek,mt7629-spi" compatible according Matthias's advice.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9LdsACgkQJNaLcl1U
h9DaMQf+M5cu0Zb2/dENEP6o5v7mVH7OBjhuL8YgALsv8xX+mjDdgGbEsY6Y3EzR
EWNY63wGZNCCm5Z043Tus5ydXXjYMWTpy5EXSNRk5tH1B97jTxUNMEBHX9qjWvQq
QqVkactN22X6g2zYOfl/cJ1FlCnENgriobKXbWlhmkuA02qJtVjL/o7WrwFETNZp
F37eUSc1/5txuMl4o7jJpg/8eB0VtaHtDqDrN7lFc0aHIDlPlIUFtDPWkA0eDYx9
zcRgnRdoqhG2VMZefG+KTXJJaRlOE5RANRQEbCffpLZDIFYLPThAhM4GdhiRmup1
RMDHEjOcgQX4wEsCnMvm0db4JIMDNg==
=eCFa
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

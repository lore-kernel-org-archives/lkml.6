Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16BCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D0720856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CevtXcq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D0720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeH1WwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:52:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56352 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1WwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h2lLkjf2NqVDC8+4g4O18R5e76eC8lONj+8MLfYYNbk=; b=CevtXcq7xwDuJOD/zAVx7IFD4
        50UyO5g/ui1ehDagCk19XFQgAAi/uV/btzIa6a6GfHT+Fe8X94+l5LjJOy+B/0ul88KOy/wLfGp5x
        5Dc8UW3uE/DozTJqkeLmVpWb1XLAC/WKrmVzuIn7aE6j2wCs2KlXCRACFD59mjjo/JSDU=;
Received: from 94.197.121.178.threembb.co.uk ([94.197.121.178] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fujCD-0007cy-1b; Tue, 28 Aug 2018 18:58:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2782F440078; Tue, 28 Aug 2018 19:58:29 +0100 (BST)
Date:   Tue, 28 Aug 2018 19:58:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix ADI axi-i2s + Xilinx AXI-DMA capture
Message-ID: <20180828185829.GL2414@sirena.org.uk>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xmAKYnxoHNXa3WQ"
Content-Disposition: inline
In-Reply-To: <20180824160430.10222-1-luca@lucaceresoli.net>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xmAKYnxoHNXa3WQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 06:04:29PM +0200, Luca Ceresoli wrote:
> Hi,
>=20
> here is a fix for a nasty audio capture problem when the axi-i2s
> output stream is fed to a Xilinx AXI-DMA.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--4xmAKYnxoHNXa3WQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFm1QACgkQJNaLcl1U
h9CD8Af6A3HHOBqGWXwdQhtR3ULS82h6fZeHIB/KL6AqTMQWIzcVqD6Fob0r3ES3
uTouAuKZX0rRfyu2SBC79q1HYowiezgLal8IAJkVkO0sqyY7QdiT2hJk98kq0k++
8iXapgy693LTv78mVdJ7XYen70ppGCFNP6uODFH6krwC1QqsfthCW/fcb+l4ApKe
YpFD5GNU5b5h4YWkpYBxjfIkA1tJ7WzX0NZADunoHxgoFcOrxgi8r2Gb8Jd/nb3X
qOJzsADS1zA3YxEqjHu9/HdaGZgM/t+2zOAfwAMdAvfZmUz7Tau+a11u473pBiFv
y4PP2CsC6h21DF7/bGtn7Jezbh+nTQ==
=IdRZ
-----END PGP SIGNATURE-----

--4xmAKYnxoHNXa3WQ--

Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE4A2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pxOSIa2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE4A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeKEUk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:40:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKEUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1b4tg8fADitmJmei1CBhjl7H8g2vvsU0HzRc4Y5HMf0=; b=pxOSIa2Tb/2SsZ5F6dC6Vv9f/
        kGTfn4mYKTV82g8Iy96l2yiFHVLyl2SLiNQZ9O23kcS4Cp/ma/1kOpm96VXlge4esZ9uUs3qd9Hei
        QeM2GzeygpZqQlYgOoeAOm9WQ/CiDABotb/iI1biTOKLsjCqpOamVOeeAY6ohRZ+I1umc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJcvs-0008FC-Q3; Mon, 05 Nov 2018 11:20:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7AC7D1124D96; Mon,  5 Nov 2018 11:20:36 +0000 (GMT)
Date:   Mon, 5 Nov 2018 11:20:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: pcm3060: Add control for differential output
Message-ID: <20181105112036.GC5365@sirena.org.uk>
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20181029085913.17298-1-kmarinushkin@birdec.tech>
X-Cookie: Contents may settle during shipment.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2018 at 09:59:12AM +0100, Kirill Marinushkin wrote:
> DAC may be switched between differential and single-ended output.

Isn't this something that'd be better controlled by DT - it's usually
going to be part of the board design?

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvgJ4MACgkQJNaLcl1U
h9AgSQf/bjb+cz0gVa1FFg7KcrHXXzzQha95LA4kVHTYuxOHaFISIMrY/aaTudvI
4h4TrRlY0tGBiAxzbqt6yZcGmh55K5UDQpAY81QHrkBKrxzEP3SLWzNiDZGrlO2f
3Gokdic9Cf5mZ2tV/z+OZ5MMS/NbVWigb1cVmyQgliewpIN6gcnVy0Gtun3Mverr
q2slTHer+7ye3FA5AK905Fv+F1GysBta14KKbISRV4LhMCJ9C9cO7oqV896nRtnZ
ob4nUggUVFhpu86SlbnXvhqyXabI+tv6MCWFKTYkGgdXBGnH2YpgDAOLk6ch2IqZ
0R2fYqU9GG+NKs+LsDwaWAnmBuHYuQ==
=Cpfl
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

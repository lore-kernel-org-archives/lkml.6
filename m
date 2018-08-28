Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491A92087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="czitbLm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH1XZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:25:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YKW1SWav7pSNvb+GKt9MadCJJ/82EVjb2DL1EmLdKKg=; b=czitbLm8HCkndFiBTXFM1Q7eG
        uylOgY7aRkY/SLHbbPUOqHC+588SS8YCfHR5/hq1S/WCuXrsxY3uXQyhRbFCmNIKSaK2AASrfkkW3
        rBk7rxt5hcXwfKhMPfoZGhINkM4XEurUYfrCr/8nL3z02YTnsCVYospdEUAj3IBCh/8u0=;
Received: from 94.197.121.178.threembb.co.uk ([94.197.121.178] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fujhm-0007e1-MM; Tue, 28 Aug 2018 19:31:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6CF68440078; Tue, 28 Aug 2018 20:31:01 +0100 (BST)
Date:   Tue, 28 Aug 2018 20:31:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] ASoC: pcm3060: Add codec driver
Message-ID: <20180828193101.GP2414@sirena.org.uk>
References: <20180821165246.9479-1-kmarinushkin@birdec.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OoKXXPSaVc/Wpb6N"
Content-Disposition: inline
In-Reply-To: <20180821165246.9479-1-kmarinushkin@birdec.tech>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OoKXXPSaVc/Wpb6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 06:52:45PM +0200, Kirill Marinushkin wrote:
> Hello Mark,
>=20
> I am developing sound support for a Linux-based device, with playback and
> capture through the TI PCM3060 codec.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--OoKXXPSaVc/Wpb6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFovQACgkQJNaLcl1U
h9BjNwf/e9TwY5s3mEHxlDdtMsox6KLef85PAw7X2y3gffpMrlVVAd7QqnccmemK
JvHSYSStVjb5d5AYgv9L4dk/CVHl1F4j8aBmD8OhOizecWece7A9YRVJaPrmb2HN
ZB202BQDGYTMNKImx3y/yLUeXdb1bXsy+tDT8DnyXm47CqxtIPst9KlakX6xNX3J
urIpOCy52d/lpui5x8oDBxCEjwVozeg2MZFS76jSVshQbq5nhXqkjzf+GeCX6cUd
eJ5rqEhQDrbIAX2/B4SJrK5lnErCTNmX3pW1TDQtWKTVN5eBrDD+aZCsLH43/OkA
oHOvCgMt6+TFxu8pwj5sgGI8GBLYCQ==
=xsta
-----END PGP SIGNATURE-----

--OoKXXPSaVc/Wpb6N--

Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BD3C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50420869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="faW+f0Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeKET4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKET4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dzJx/94Dhr2d+VPZTwtd1d3FBD2VDyjrmGIjKRJYdo4=; b=faW+f0Gr1hfWf0zdYZaNhg79b
        8LAcMc/G99mjotPYZD2oT50JV+vXYVr88AFZbEBFyOwA6a9w7ZJf/G0uv11wNTTsqqoSg1J2mxHky
        o0AEVcIwQ1FmmQjHHXvuYbL8KR0FmSBvM516ADk9b9fKN3erH3THoxw3WlZIugJ99AYsA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJcFe-0008Cv-2k; Mon, 05 Nov 2018 10:36:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AAA261124D96; Mon,  5 Nov 2018 10:36:57 +0000 (GMT)
Date:   Mon, 5 Nov 2018 10:36:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     sh liu <liush.damon@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8996: fix small typo
Message-ID: <20181105103657.GA5365@sirena.org.uk>
References: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
X-Cookie: Contents may settle during shipment.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 09:30:06AM +0800, sh liu wrote:
> From e9b923690675ca8fa883fd25dcead5b457856735 Mon Sep 17 00:00:00 2001
> From: liush <liush@allwinnertech.com>
> Date: Fri, 2 Nov 2018 08:57:00 +0800
> Subject: [PATCH] ASoC: wm8996: fix small typo
>=20
> atleast -> at least
>=20
> Change-Id: Icc970b438166daef13518b7d1a62b13eb8752f5f
> Signed-off-by: liush <liush@allwinnertech.com>

This patch is corrupted and can't be applied:

> *codec, int fll_id, int source,
>   if (i2c->irq)
>   timeout *=3D 10;
>   else
> - /* ensure timeout of atleast 1 jiffies */
> + /* ensure timeout of at least 1 jiffies */
>   timeout =3D timeout/2 ? : 1;
>=20

It looks like tabs have been replaced by spaces in whatever you're using
to send it.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvgHUgACgkQJNaLcl1U
h9DPNQf8DyEl8ZqUljGGgyyP48lIp5J+gF2eNUOVP+ebotrVxn197W3Fgp2BU0eU
FVcPNAUqBoRdjN0r9CWjL+2+9xCdHyJHbCCE9OnZrNxwY7CFG2RpchJPTyg/K3FC
Z9ZJkItrmsb615X2elTQbtLu3UipFYk4+BZ4/eQLTSOr3SiAGlxDbTNtqkxFdL0q
ktHpqHlIDhIrrBTNGikjCAkrU5vkkrydY53wVyJhDhz0ljsVh8b1rbMEdgXKlYzv
po1CSPMjprfpx4PGIOKRLHv/+3yNJ/KdFOAYpdPe6y3ca95QA80zZ72s5Rs5XXDg
yL+F8NmbSCoCrOZMED5nLhrIjkrSYw==
=1xwh
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

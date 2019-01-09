Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A0D206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547037847;
	bh=N8L1j+H1TmsfJR1dH0YB8nmgBWazIfdW64KOHooclc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7rBYOkXgoP8Gt6qnRAyYkDvFJmAfMxOcAfVBHEu0SyjSTOqiN8Jg5FDzmkBPMwa8
	 +rQqGpn3RjRLiNdEUyvov2vO6CnC8sYigTmoa65YwcowwMq7D5eo2hovYSMWDWwsk9
	 xrRgtIv7uEkdIeGuaQWVwEih6I5va/iggjqdw4Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfAIMoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:44:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfAIMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N8L1j+H1TmsfJR1dH0YB8nmgBWazIfdW64KOHooclc8=; b=NJlM5H2uHMqM0d7s6B1ko7d+3
        QEwLEu36Z+FpGA/rgQp66P/721pMwYYhMfQGSo6Gm2Vbg580ahELFuDJGBGqm+7hnD4zVp+78DRrQ
        i8j9FhBxrJn64AS3V7DtvHzakd8ni0Akl2QuaQ7ueyqOJtwgK3tdqROPd+HVyslhwxRNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghDDB-0007yC-Nu; Wed, 09 Jan 2019 12:43:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 309861127528; Wed,  9 Jan 2019 12:43:57 +0000 (GMT)
Date:   Wed, 9 Jan 2019 12:43:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] spi: lpspi: add the error info of transfer speed
 setting
Message-ID: <20190109124357.GC10405@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-7-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-7-xiaoning.wang@nxp.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 07:47:45AM +0000, Clark Wang wrote:
> Add a error info when set a speed which greater than half of per-clk of
> spi module.

This (and it turns out the subsequent patch which I said I'd apply)
doesn't apply against current code, please check and resend.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw17IwACgkQJNaLcl1U
h9Dpkgf8C0s+n1XGV5l9HeB+IWNq5DrE0cPLhOfoiIouE2WQ+RMBcjl2xbCk66ar
ZPaxLULyiPo+E8aYpRLfuGOskB/biToeFzLdpJ0i8heneVSwfQify+ce2JmXsniM
uElXHf71XYRMPJK0MYAEsnssZdlxiFSisVc/Ear6PSkTYHcO2JP3xh51gMeADaSw
jxcyvfBiFj55g3HlpakvpNt//Fpj5bAGrQeW4MktGbVLopx+PFLFduBDYblqcbqC
fLba3Ib/WqQVctnEJ+zf+U3FEV9ae3mfWBhl9OqZOCRm6HrS2m1CbbXv5gZaVuDo
A2L60N1v3NaGwbaz13N9vdiZJFcJ5g==
=owl/
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

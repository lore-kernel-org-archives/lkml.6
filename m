Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6422087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874143;
	bh=cY29kTzC/ZSc75Iy/hTrbtIwRegtLAaHAWNPAqC4CPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CjXvCOevqJDabGOdARnS7GVVean/LL3I1nkTBLsFouS+sEVQWXWLfWktM9lgZDnnh
	 uPQF3taKNRHnA/Nnd6CcGkVeSayuEwrahK25FGbSghf2wB2N3Y6zRaKmp8ycGWUzRk
	 3SDuNepLZI2kRuXuhiGWgnKNCyQ9KMqJ+7jAwxoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfAGPPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:15:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfAGPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cY29kTzC/ZSc75Iy/hTrbtIwRegtLAaHAWNPAqC4CPk=; b=IT8zXzDfwkthCXfDY82ylNU7Z
        jIe1kP4kpeZMVAX9Mq4OEyAkyDhyQ5Zde7wj38lYJMwGpcR+lc4b4zsLiUb/TeChHF4sJz534jC30
        QrGfrd1LQJrP8UCjZEWU975YiDsnguwaOv81z52tFtmmHpN17xRqlGhufuVOPztFovzsg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggWct-0007N7-Aj; Mon, 07 Jan 2019 15:15:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DD8261127491; Mon,  7 Jan 2019 15:15:38 +0000 (GMT)
Date:   Mon, 7 Jan 2019 15:15:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Message-ID: <20190107151538.GE9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-2-xiaoning.wang@nxp.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 07:47:34AM +0000, Clark Wang wrote:
> Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

This needs a binding doc update to reflect the new clock that is being
added (it's not clear from the changelog that ipg was already being
handled).

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbRoACgkQJNaLcl1U
h9DmAgf/TzYsHsx8PkDjhgE4y/BrKrVNiA77FAnYjkbAYM4yaOMu/o1SIqjU1ciz
lhf9FutknRIeKB8LYTfsL097s2URjO0cvI4ETXf5JmQ2CurLsiATUx4JjhSTXZ2a
keRivDKg/fXwIFzlGOk5qg9alGf1yA5JbXKj67aSzL+W9s3cayBiCzwAMj5EnH3v
aXQjwlI1NNZyQmgrCOvMQn9PwAG5XGZaDmi6P1vp2/I4LyQXwQpAMdBQtrNWpDUb
flKq1SWIULlCD0zOm2VdTz3qJ6SrRscRnqK0FhZ41j1o6MU3Zjrj43NNtQj3NLP0
HmlgRmSH/d2NxohCTJZeNmGfiEsmEw==
=oHpd
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--

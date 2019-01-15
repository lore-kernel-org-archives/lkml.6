Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D1DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41D7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586579;
	bh=s2X22d1LlqDVePqLYmP1rwf2MpuOBw+myHHoyI9YyHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YGUQJNTGcBx9K28lcj0JX+hUR2YTjEz6ktLG8F2OEohFh9fZAwqkbkOwn9A+ia1A2
	 OwOeB4LYFZCqKXvVOgIIHI86we1UwCC4i1SAWmh5jCA474CKizNEBHL5R6vOrAvkLp
	 USoc1itSJuzr1GeA8QobNyyb+OU+3VN/yVrSFX3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfAOVJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:09:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbfAOVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s2X22d1LlqDVePqLYmP1rwf2MpuOBw+myHHoyI9YyHk=; b=mh/agSM4jSnUq0H3YM1nkDfP6
        Sxi82ChGz/VUzNWbZLbq0BDYjphGbgdd/uepAF9i2hamiYBVwQ/LDVEH1onD/txd9bpsoJCPbQnWt
        XrCkSJkaeKvNn97ufjo5VDgHK24QdeK2HoTOYKLHZ0XtCcmI/WHbgaMf86mCqGZk2Q0rY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjVxZ-000327-Hh; Tue, 15 Jan 2019 21:09:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1C9151127848; Tue, 15 Jan 2019 21:09:21 +0000 (GMT)
Date:   Tue, 15 Jan 2019 21:09:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190115210920.GJ5522@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20190115192840.GK5544@atomide.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> Any ideas what's needed? Some triggering mapping data to palmas.c
> driver?

There should be a fix in -next already waiting for me to send it to
Linus, can you check there (a couple actually, in my for-linus branch)?

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+TAAACgkQJNaLcl1U
h9AwIwf8C1ynMQh1N1yNP3/lscQNBS3K8lg9krjtYsdc+zKtloGVvHZLf8rafYsE
gnWZ8hF5cwMEAkCULG7/iW565WQ5p023DMPmNtk6u9jn3mrbsfk7eYJjapwXrDnL
vXwdJwQra2PVqQzlwjye7R2cg8sVHpt93e2tv1wCETqTqTZNLIrt+CV8qn9JniCG
auqMlP/rGMEjNENMh/rslWbpOrVbWnvWOND8h81q4uqFicr67LTSlwBOOkFom1n5
mlkXLgeFQgsqIaf3T8YVg3vyFmcp1ynTvCKLepDAIDdJyyY6AXbSCL6UoMPkyLQc
L6ks69fcLXODh7IT0NQaCZaYamiI2w==
=0Hrj
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--

Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72478C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE772147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550748616;
	bh=8WJA84Y71ETBuCSw34NSPi4z0U9K2FfcMVttm4Akf4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yvPoiemJW1L2JbMRc09aiUtZKuhMqMfXZUNlIbduBPJE1or3USYGCpa9nEtBeRTMo
	 7YC9CXjoXCXO8UHNPe084S9R32yxFaMJWEiXAYsPjTSQDfu4t5NDh3B3r/ZMzChAHH
	 t0gMkntuCicHlQ0TKsPlvWEwnj36I7Qc/lZzMbFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBULaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:30:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfBULaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LKDVrK1yRlvCfIA+bYz65XT9HK+3MV7q52zfEnG1up4=; b=eWB2IGDIWOo7Ds7NVVTZyo00D
        cpcPZIlNxnaTf3BMqjdxgrWLz6orUQ8jcIlvJlXHrq0Ri5wDax/Q4lThCELmZaC5S+74EY+qD/NJ3
        mYVihcKVPTQAciLkqp+NWepJgRjwq0fVe2oirtayJ6Fl5tCXQf83ADVKAWq8/WRzALQ3Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwmYH-00033n-TB; Thu, 21 Feb 2019 11:30:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1B5C11126F39; Thu, 21 Feb 2019 11:30:05 +0000 (GMT)
Date:   Thu, 21 Feb 2019 11:30:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     bbrezillon@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] .mailmap: Add Mathieu Othacehe
Message-ID: <20190221113005.GD5970@sirena.org.uk>
References: <20190213161249.17155-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20190213161249.17155-1-m.othacehe@gmail.com>
X-Cookie: Garbage In -- Gospel Out.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 05:12:49PM +0100, Mathieu Othacehe wrote:
> Some contributions appears as Mathieu Othacehe and other as Mathieu
> OTHACEHE.

Nobody else seems to have picked this up and I don't see any reason not
to apply it so I'll do so.  Not 100% sure why it ended up in my inbox
though!

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxui7wACgkQJNaLcl1U
h9B2+Af/WsumSp2YyltWDt1xxcAJkOLj+Ml8ClG4ni8ENwENemJNr569oyYy8nJd
plDlc2HLiRyLuISmRbV5PGksz7+0/i/2p/WEydrxPvilwfpxqBMGZpgdl0Zkk7cN
5l4B+ReRh0OVnzIvIzIflYufPNsHWmC5Uex3i+7r/Pvf8AwsDNhUJz+uyupS/Bmi
yAPk/XOzqFB8oLTgJXyfPsLdyjDbTp8WRYC05prkCdhV5+IF/hqPgG49DOPAvmqN
yKdXZHoeVFxPaIXmkF7DIDalvNw47Afae4Vbcpsj9JpAmHl+M5VYFU7HCPlGtjiP
vqwQuGW31NMKWNWkWH8GdaWkbtJdsA==
=V68Z
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

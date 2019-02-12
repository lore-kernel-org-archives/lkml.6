Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981CE217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549985658;
	bh=MPfS3yAE4LffhTQ5LbqMKMwK1D32DakL8odo6LErh0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8+paQ6+ZOqnEGmoD4wdfWv74dM0B5DPGuIZ8klIk8/VuGlla2BaQMfdeaEK90cGG
	 UODQZGFdmi3V6lE+cecyxvG8Xsda940q0ydP/wYA6okNnnT28a1UH1djW9fcsGqMyV
	 CvvyFdxUePvGlPMyjTjJwN2ttIbJ6E30ICc5Vs7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfBLPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:34:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MPfS3yAE4LffhTQ5LbqMKMwK1D32DakL8odo6LErh0Q=; b=tRnb1/g9mazclAHsd608t7ZU8
        tVuMUqa/4uo+oms0fu6c070C0tRJmCucF41D4reTZcjG9psPi+gJ27V9J9HcRS3+MbWn3pCdqXckY
        d5GfDHtcNdF+jkw0z2SSg2S6qyAoI/9cgNQbKuz/iM8Ta8NHT5c+1WyZkicbc6D/v87Ds=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gta4W-0005KQ-Up; Tue, 12 Feb 2019 15:34:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 24A931128113; Tue, 12 Feb 2019 15:34:08 +0000 (GMT)
Date:   Tue, 12 Feb 2019 15:34:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [RFC PATCH v1 2/3] regulator: add
 regulator_desc_list_voltage_linear_range
Message-ID: <20190212153408.GE20635@sirena.org.uk>
References: <b07e501c84c77c59f0a2a67c43576373a140f10f.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <b07e501c84c77c59f0a2a67c43576373a140f10f.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 04:18:46PM +0200, Matti Vaittinen wrote:

> Add regulator_desc_list_voltage_linear_range which can be used
> by drivers for getting the voltages before regulator is registered.
> This may be useful for drivers which need to fetch the voltage
> selectors at device-tree parsing callback.

This seems fine.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi528ACgkQJNaLcl1U
h9A2Wgf/WiSjmwLgHQTPyCGf1Sbz8vbqTBhUHH54wARjgAV284XgiCShR+gN36Yy
SgqwuDospXsR2ieWwDSIGaSWGP2ZszxI9IMO+ln7g46IbwEQcfjG6vpehRft05Fp
A3ScY61nkouQttCGUvrZSwnMZLUs4NXm4lQ/9QFZDvt69N3uzZpuOGiieRUfcKPx
EMNiYCmEyOyesYzcyTySRarE6OdIdnCMuGZx8xSWLUf6lAWgUiQzbg1DadB+yjBk
m2kFKmmHl+bHOPTUOKHYJEnXzHZBV4gbFPdnCqaO0+OGxQLFKbGHMrutU/9/sWuc
ikXke/wV8Ta9uTnhnNmaakdDxtR9mg==
=KZNW
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--

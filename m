Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13031C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18DC218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548861517;
	bh=k/8uLhtlJk8cjXf0wAcRsnsi06/XSOcxGradFxBbaoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AjedmyuMZIcXj0y8sAtbtTc/NawgdfNLvKj5oEQv1eEJoImlvIlm4C+HVIHonAmuh
	 2Nr8xgp02m6ObEfmZlRUtaegQ7JuJMkjKTu5UvYseAM7RNyFu8hu7ICfSmQj2WV7KU
	 Nt+MaTyGrO0SHY3LfvtMyTH05RYzEVw9I4b1hy4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfA3PSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:18:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39440 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3PSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gxnR5oWhLd3lQKrlIvE02j5DEvzUXaEu7fAA/lsg4RU=; b=evinLO5P8nPTc9zTahKm3579t
        M4stWoa2c9dkviTq+De8brSVDi9kXAydD0jpzLBDkRdNelg3m2SR8OilKZPYeHpc+IDIQEQ7fhXSj
        iQDXGij6eDgxf6KUjl9Ql+fGFd5vo9wnVXZhxOYj3DaiNNek0jqaYecMBo6uxBLb3pPcc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gordC-0006OH-5B; Wed, 30 Jan 2019 15:18:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9A2E61127D43; Wed, 30 Jan 2019 15:18:25 +0000 (GMT)
Date:   Wed, 30 Jan 2019 15:18:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 5/6] regulator: mt6358: Add support for MT6358 regulator
Message-ID: <20190130151825.GA10665@sirena.org.uk>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-6-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1548839891-20932-6-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2019 at 05:18:10PM +0800, Hsin-Hsiung Wang wrote:

> +static const struct of_device_id mt6358_of_match[] = {
> +	{ .compatible = "mediatek,mt6358-regulator", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mt6358_of_match);

There should be no need for a separate compatbile string here - we
aren't describing the hardware any more than we already did with the
parent node for the MFD, we're describing how Linux currently splits the
software that controls the hardware up.  Just have the MFD instantiate
the regulator driver when it probes.

Otherwise this driver looks very good and clean.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxRwEAACgkQJNaLcl1U
h9Aikgf/Y+gvwbaHHnHQ0m8MNdKRqSYNJudae95ToA35RJTxhcN+utenn65RCAbl
wMdcbp2yfyGBbfGu8AMOG9P+9aF+IIaigPFsLWqo7PMhIz7GwoVW0lqo7viKIXv8
EZe5yLTk9famVTksAOQaDpd3KymoSU5r5keiK+4StsPw3+uc4xAgmOnNrRHBQyCD
1Sjy8egYfQHEKtP0anNEoIqVN6nKGk+cpdXyuTum32aE5P7cUuQrX5sVBVQ+jNlw
kKxIa8Pesrr3VJivGgtrcwIC3UIXEbOPS2MjBKe/qplqeuxqkdfz+3k5DfygC/5T
k0gmxZsGWBc4PlqPX9Q0MLTKsT8h4A==
=iJPx
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

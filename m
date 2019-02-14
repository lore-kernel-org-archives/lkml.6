Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6702229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550155651;
	bh=dMHtbJkMPXU7BFMdN4BrtKMH1r3PCHroPbC7YSnC0kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XEyjt0NO2PjMcsW4tPvVkEevFVCFKhX6v7Umux+N6JEk2NNs0FN67iikUXTCOov+3
	 quKDwTNHI7+gHrK8+DOCiRKNV0+dEUKF1Nx8UuQG1MGpQFd7pFSMAcNd3OgKOu1DG1
	 lxryzF1awlMxg5tmbnFnW4IUrsjZEkHibyncixOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439319AbfBNOra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:47:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436978AbfBNOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dMHtbJkMPXU7BFMdN4BrtKMH1r3PCHroPbC7YSnC0kU=; b=RAoOlAG2bxd6gnAxso2qAWKns
        9Ef1MUMwSZ+9dICH2duQWVffSCmVIoaAVDcg3lz9GxZ/R4vMB72rTrd0EYPTBS5Fc2hhp58h3JXEB
        tB8BszG/2iFB21Zgn+et/lI14EaA9/5WJkLQWgpZ+3KFL2vVdxP2uRNTAnedG3CZ074u0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guIIO-000568-GC; Thu, 14 Feb 2019 14:47:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C9D9B1126F78; Thu, 14 Feb 2019 14:47:23 +0000 (GMT)
Date:   Thu, 14 Feb 2019 14:47:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     sbkim73@samsung.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Message-ID: <20190214144723.GB11988@sirena.org.uk>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
 <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
 <20190214093747.2414-10-s.nawrocki@samsung.com>
 <20190214130747.GA11988@sirena.org.uk>
 <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
X-Cookie: Bones: "The man's DEAD, Jim!"
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 03:32:38PM +0100, Sylwester Nawrocki wrote:

> Hm, looks like we need still to keep that data structure field, but=20
> remaining part of the patch could be applied. Do you want me to=20
> resend it with chan_name removal part dropped?

Please resend.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxlf3sACgkQJNaLcl1U
h9Dd+wf7B7ZIMmY5ipI415Ue3HfBHNnUClUqoTZ3CiLtqZhLt7fWKljOtbB37nnl
JjpDKk5wDvQvPWltRQ7mDFB9NUX3HfxL2Z/XQ9vTcXzNjamou0bYyoUrO3AvDsyW
xeus7Ga6YBMnOee8ZT+jLX74mrFVXn23pcvQY0irJvc7jWM6+oHtInuxjUL3IX4m
dehRi5OlEmoh+vvZLAabm9uz0haw9rsnTsF4wp3OArX+D0nns1TBfwsAJFYsivSA
qg2qgZ0YO3y4BfEVFQzX1nsbW1feuk18Y8AG7nrp/pAsnASRCT39S1IzGkll3mLD
7NjGUiisJtgDrXGYsHmnDC33f7MQeA==
=6Epj
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

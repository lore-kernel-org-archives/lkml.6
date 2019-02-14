Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C567D222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550149675;
	bh=cpze1kxoTjjSex7LPggyA3wVFJ1ebQDgo1qc4EeCexQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kEYAg5yQO+t7lVewg/VIUU4gokX97Nc/20LulumBN7bTppSp73seW/hkk4GcwaUJ
	 W/6r85IiUl8M9C2mInBXiCYxE4cy+7HuDtL+rH2rVoHmw3Iu1rnvPf/V7uUCzdKb7b
	 vp957CWaEn8M3b0h00Ow4Tcu9bcEaLBEZX7cdkwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438701AbfBNNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:07:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfBNNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=izpjn8isCKsios0X7QDdKwFwCN6SPn7U8ozLVor9m3Y=; b=cSpDJzUA1zmZHnBYZacZ2G6B5
        nDTmgTtNY+DyospaBBSQEYJF1anX5poTOertQNHl1lzn/4VZYI4i/mEdG42Nh/H40PXhLrANagLqH
        338NtPtXn5FfrMpeQ+9LGDSTR1fllHJBhX/3abarT6D5aC0uYXMpeOI3vuOacxSZ6HuTw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guGk0-0004Mj-Bo; Thu, 14 Feb 2019 13:07:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 908D21126F78; Thu, 14 Feb 2019 13:07:47 +0000 (GMT)
Date:   Thu, 14 Feb 2019 13:07:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Message-ID: <20190214130747.GA11988@sirena.org.uk>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
 <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
 <20190214093747.2414-10-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20190214093747.2414-10-s.nawrocki@samsung.com>
X-Cookie: Bones: "The man's DEAD, Jim!"
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 10:37:43AM +0100, Sylwester Nawrocki wrote:

>  	u32 maxburst;
>  	unsigned int slave_id;
>  	void *filter_data;
> -	const char *chan_name;
>  	unsigned int fifo_size;
>  	unsigned int flags;

This fails to build:

  CC      sound/core/pcm_dmaengine.o
sound/arm/pxa2xx-pcm-lib.c: In function =E2=80=98pxa2xx_pcm_open=E2=80=99:
sound/arm/pxa2xx-pcm-lib.c:128:22: error: =E2=80=98struct snd_dmaengine_dai=
_dma_data=E2=80=99 has no member named =E2=80=98chan_name=E2=80=99
            dma_params->chan_name));
                      ^~
sound/arm/pxa2xx-pcm-lib.c:129:1: warning: control reaches end of non-void =
function [-Wreturn-type]
 }
 ^

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxlaCIACgkQJNaLcl1U
h9C3Ogf+ItY9J2JK6iL/Ha7cdN8hos0W9+d+WQgO6+Ob+qZZuwzFrS2/jrbmscCy
yMNv2lC5pp9xYmySzGrcrgLyun6nen2Kqmfw9q4fQ7x6KmPmLj7SpncYhi3CcSSz
gGz0C8mqZRZ0LATJrw4Ya4QQ3WTyj1KjwYJdX/YCM7u/KJKR/LVnRVm5KRtVnLwB
L593wWH/0eqPGU3wEoy2JEeE242cvk6egv/tpqagk5cn0n7p0TnXSBqNbl/Rf6KK
EYaj3Bjn2cbVlcaIqoYzugtk5i9QpvMwGAw9ZJEUFqwgl7G380tJSCAgEetH1Pae
zsqOgtBdebYQiN+z4iVaY4sVwGPH5g==
=H9WS
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F33FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B73C222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058656;
	bh=O3fbGWFnY/kBeVVv7gjiGLm5xhmzRzxAFvXvqhwUl4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N+/gsz/KYK/h+yHU4Ovx8mrFDzCukWbps6xVqRK+vg4ju3/252j0NBv+1EGUDaIca
	 ulaXnb1ApK7lZDEF7nr2F2b2ybNIZy+q54mqIU9+JQ0nQpdqSKsZmd383mNFHof55I
	 57iva2oyNgCXQgWVQlo4apW071rKc04r5s2+0UOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391907AbfBMLuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:50:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44902 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfBMLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DFpFApD6OByxzhEPbVIWgdRvHIn3DiwhEVgzJewjjfo=; b=r94SF4Hk1VUEcarK3CeyJVJOY
        7ljhAl3mU3ft93aFA6e+dGSikddzWV898OJvzeLSf3CpgWRwHtBHcei4v2c2qNZ74I+bECyQ8OEyR
        yUqfr8z6u3WlKTR6LCBDGxl84GoGyCEw0jrAu/8G3BCQiRC0POP2rh+50g2VQZ711SdFI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt3v-00044j-Jq; Wed, 13 Feb 2019 11:50:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E42171128158; Wed, 13 Feb 2019 11:50:46 +0000 (GMT)
Date:   Wed, 13 Feb 2019 11:50:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 08/21] ASoC: samsung: i2s: Drop spinlock pointer from
 i2s_dai data structure
Message-ID: <20190213115046.GB7540@sirena.org.uk>
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
 <CGME20190212180506epcas2p43d7efeaec4a4ff63d13e5f79b281707a@epcas2p4.samsung.com>
 <20190212180342.32040-9-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190212180342.32040-9-s.nawrocki@samsung.com>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:03:29PM +0100, Sylwester Nawrocki wrote:
> As we now have the 'priv' pointer in most of the places we can use
> priv->lock directly, dropping extra indirection in the SFR region
> spinlock access.

This doesn't build for me:

  CC      sound/soc/samsung/i2s.o
In file included from ./include/linux/spinlock.h:309,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from sound/soc/samsung/i2s.c:15:
sound/soc/samsung/i2s.c: In function =E2=80=98samsung_i2s_dai_remove=E2=80=
=99:
sound/soc/samsung/i2s.c:1109:23: error: =E2=80=98priv=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98pid=E2=80=99?
    spin_lock_irqsave(&priv->lock, flags);
                       ^~~~

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkBJYACgkQJNaLcl1U
h9BCRgf8C6g91IeZ5Zcqep/EFsANLZTg7cBQGfvyo5yr+WE3Nua7JshkBLE2yT/n
YKyJRAOBg25eFepo6gqzkA0E7z1WwSsT6x4KcinMlOoflE5oyX7EnAv39mxjQwiP
nwrUqxGUyOsh+aNK8b6r2XOpgb1NUhFIoVaLiK3ZRnpQdG16UEpRn6IvT3O+y/p4
7fPABzRIsG27hs7jaHe3/MyfOONsxeIi/COH1QeV9FGJI9hgG9PuwURR2jXJgC9q
ycR9vBOkoMWDYc6jY+slVqKgoUvtiiB823pLpEx787T/Lt6DtIJ71RUeWMz24iZS
9K4/DtsC0Wt+7ADoYMisKkkNNX6d2A==
=YtDk
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

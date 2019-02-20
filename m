Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8511C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3EB21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550681341;
	bh=gcrnrskwdRNjc25R35jBTKG6yYXKXswwhPBgU4uW080=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mIp/XwCSm8H4hcDWjB5+RQXQ5gxZjpMq8E1H186niTRm8XzBmvF6TN2g/195eYjCW
	 /7AUlaDZdw28QdyAhT06GbIaFBpXbeAH4HTtiKf5cV3dnbSC2AUZPQwTekR78WjMzj
	 JVpOx5BAuZqLO/njgQHUXs58+6eY5FGJuUk0iXi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfBTQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:49:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBTQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZOil4hZy+IAWLaBqr+2IU8qhDoyE2lpTO/Iby/vttwM=; b=n7BpE2jIPBuccnO2aOzYNwg9N
        nq1SSZuSlxuiDYxM29VlYg5ePGJ/Qt6bl9bowKj341gVME9u+MeoTLD9VwUpBQkqaODj0xWsKYRbU
        hEw8KqB7eaotOrbzvM73uLr5xu+tb+Fjr3SCkOv+ZvgipJUbClK8HBSDOoRT9G3aEFMcE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwV3E-0005CK-0E; Wed, 20 Feb 2019 16:48:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 626B1112882C; Wed, 20 Feb 2019 16:48:51 +0000 (GMT)
Date:   Wed, 20 Feb 2019 16:48:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: tps65218: Add support for LS2
Message-ID: <20190220164851.GD9878@sirena.org.uk>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1550650552-26013-4-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <1550650552-26013-4-git-send-email-Christian.Hohnstaedt@wago.com>
X-Cookie: Is this TERMINAL fun?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:15:52AM +0100, Christian Hohnstaedt wrote:

> +	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
> +			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
> +			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
> +			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
> +			   NULL, 0, 0, 0, 0, 0),

This doesn't build:

drivers/regulator/tps65218-regulator.c:309:45: error: =E2=80=98TPS65218_LS_=
2=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98TPS65=
218_LS_3=E2=80=99?
  TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
                                             ^~~~~~~~~~~~~
drivers/regulator/tps65218-regulator.c:36:11: note: in definition of macro =
=E2=80=98TPS65218_REGULATOR=E2=80=99
   .id   =3D _id,   \
           ^~~


--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxthPIACgkQJNaLcl1U
h9DsAgf/WkKqcdvfWvkg3h0NefjkVrMRy33gImEH7gvnZESxXvliAIKhh4UabR8r
Alv+8XitzO2SIE8/uZUM8mR2VaBi7hAFADkWUyCT5Ci14uyEEZQE+h4I4TMC1Rpn
Xv9PswEQT1cOeLMOl30TfMuvD+1JQB4sxNvYo08NSj0AkwA9GYjLZPa7UuVBzNx+
U4JAmozNmrVgGyHFEjSJYEmW/XVijlXKVqB5E+22HM/+NykfUpLcGd0Ax/GC4gmk
Hvk/ooXkd3km2y5LmogRQexahL89Sq/bD6aAmX3ObbDyr/kHaglDvw/FxYm1+O6F
t5qdsu65MJcZ9wHB/eoTpZyVLWuQSg==
=3vRS
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E0B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ao4J1O3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E0B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeGQLG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:06:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbeGQLG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bsUK8D3Rf33HVIyVAZgQ/Yrt2BvA+ZfCe0sGDXYPh+I=; b=ao4J1O3dgGFLR5x7il/t7SsGX
        o+KSCqfA4nPpcaj7vPswR2e2bGvOndOKSP6wX5FSqL8ZgM8r6bdV3Il18/xA1IUsNnQc9UtySzZHa
        5Nr870yyV2WUU7vRalmy4L/nTF/BSVKYkrX5T6qhNfpQZifsp11W9j4bQ2CjU//fJuorE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffNJS-0001t5-SH; Tue, 17 Jul 2018 10:34:34 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffNJS-0002JC-7Z; Tue, 17 Jul 2018 11:34:34 +0100
Date:   Tue, 17 Jul 2018 11:34:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, jagan@amarulasolutions.com,
        djw@t-chip.com.cn, jacob-chen@iotwrt.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: Re: [PATCH v1 3/7] Documentation: spi-rockchip: add description for
 px30
Message-ID: <20180717103434.GA8555@sirena.org.uk>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531813747-8804-4-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1531813747-8804-4-git-send-email-cl@rock-chips.com>
X-Cookie: Paralysis through analysis.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 03:49:03PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
>=20
> Add "rockchip,px30-spi", "rockchip,rk3066-spi" for spi on px30 platform.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltNxjcACgkQJNaLcl1U
h9DddAf/ZhXQY60brHxYGhfzQMhjXm+A6Gw/eRa3+bM/zfnLUPej7OAaLnh6KH5T
fTbPHzwa137TOXy/TrJvFmJymK5h7vBGJMAqZ53j08G+2/ghSzBpNaLZ9zgQeuvy
+2bbwRnk7s6H42dukgDomTy98UAh2zh3E9CueNH4Ev+FyLD5nxQVlYnzjhr7msFN
ppwPrc7R26rv9S4wtd9g4CHKvlTOPrwM+L0LXCjg7DtS41HZtGouxGS0/eB/TPkQ
vZS92+kGvcJs4+fiP/oK6g2EJSO6bQtFg8LZj9ejIouxiJj+FOGCEdquzQxI8dGg
jCqMB/asqioX1//AlCtsC6Wd8Yvm9A==
=hLie
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

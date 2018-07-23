Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F14ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A6A20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LnKxaq5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbeGWUNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:13:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbeGWUNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rH5t7SDpri+RVAZb7JtkSMKTmlYOY70IduPRYU7Jiiw=; b=LnKxaq5UzeIx9fGoSzqcpGA49
        u+Cw63u+jiloiZhMD6XCBK7t6KmnvgIezryTQt3U5h3HPZt5kffEiKSB0KeaLWnFBnnsCN+xhgxGt
        xKwuwAkxdb6ZRRX1nXh1BoYcCl98Yw63JP8m0W5lRZi1cvtlNInAxp0YcKiWh+c3w7z10=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhgDg-0004Wx-Mi; Mon, 23 Jul 2018 19:10:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5655E112387B; Mon, 23 Jul 2018 20:10:08 +0100 (BST)
Date:   Mon, 23 Jul 2018 20:10:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [PATCH v2 3/6] dt-bindings: sound: rockchip-i2s: add description
 for px30
Message-ID: <20180723191008.GL13981@sirena.org.uk>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
 <1532337924-4185-4-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Content-Disposition: inline
In-Reply-To: <1532337924-4185-4-git-send-email-cl@rock-chips.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 05:25:21PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
>=20
> Add "rockchip,px30-i2s", "rockchip,rk3066-i2s" for i2s on px30 platform.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWKA8ACgkQJNaLcl1U
h9BhLgf/Y0UU7Id4l6ICoIlmMMIaggZlIIZfIWDu4AXODkAXnewyj9blyVs+cdVm
u5Frz8gAdH51Jm7o3t+JKQcHdl5yYEGi9Yf8Ob3KhbgpuBma3jUY6krtczVDaGdN
r1QkRRCEmAw0Bxl6olyHG8sq4gFcp1Ixo1/WydCWG4vGr1ryZmsFjZDw1j9N10nJ
9oHwx3ZqaRUiJAFttkrhSxrYlAK11KHfFjb2Luj6c7tnNATE69+kXkKSlRv/6Y+v
PM3VEPiSGV7yIDYu6qCnzobhCG+MbkxF8Th5dEu2CjAxdtm7bZfe6kLcuPcBmY64
WxWcdNYvUCqwYV1EpA4OzaR4zYnYPg==
=Am74
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--

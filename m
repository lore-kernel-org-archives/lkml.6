Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D6C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537334;
	bh=k9+lkKG8yN0yLdK+Cr7Ps0U5iepdHWVE+KWdMwMCRWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EvN2ddH8KhjPxXvDGvEHBLMrfLalXV31EO9NJJGaauV25g2X3cj+VgbikpA0znT/3
	 qmZcJ3MVNt2lhTK3nSwgv2dF5wEBmcjCDUUetJxHugh1f10ydL5/ZIEKC1roymFFAk
	 BFsWw/ITiQQ381WRhd/BKoMTp2+LLNLuTOH/+RAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLKOIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:08:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLKOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k9+lkKG8yN0yLdK+Cr7Ps0U5iepdHWVE+KWdMwMCRWM=; b=pBtpXAuON8rh9S+HsN0vzqU6T
        nUw3a+uzWA7dkwdBo5MhLrxuwV+CxrFJffmGYytwsEj3qZf/KQeLMqqV0hHOloPVdJqdFXaVtLOGC
        NWxLLmR6Uz4dXT9mZmwKfUtD/PaN8AWtJzoCAXuJBbkcIbX9+DIIP2qLLzroqyTGpoGk8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWiiH-00015y-RI; Tue, 11 Dec 2018 14:08:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 844F5112540E; Tue, 11 Dec 2018 14:08:41 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:08:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] add PM functionality for act8945a PMIC
Message-ID: <20181211140841.GE6686@sirena.org.uk>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 11:57:06AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This series implements PM functionality for act8945a PMIC and use that su=
pport
> on SAMA5D2 Xplained board.

This doesn't apply against current code, please check and resend.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPxOgACgkQJNaLcl1U
h9AZaggAg505D8Xn+NVX6TOio7dzQKgtGEcOGq1ELTca1YDIqxRkcrZXN20OkbOu
FGbA3VzRfqQgzyQN/giexD32gQE3IOsN6/IX46z9mgJKVnWLyPf7DXp1Pd+mjdzM
aRQSgTQF6+/2iZfqLQU4kXZKMcgwwfURZCWqQgKlZfmtOV7ZYdMYBcjhskej1Avg
LWytAL54VzJtKhgBGFXHQZb45D3cKczTHfU87NJyvSl+75/BbZ57kesTfkvapZgb
oiYtmMaXeHJeDneHiQYy66G9MrAN9R1H/9donQaUI1R6i+hvchHF0jcbT62rVH43
o8gUvui0EsTbuO9AcdPlaUFcDXcNyQ==
=J34S
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

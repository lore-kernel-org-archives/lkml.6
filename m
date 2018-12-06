Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251C3C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9B720850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127842;
	bh=AW7PYIp+9O1RtGuIvmVgL3cebdwB1FMoYgCvLRwOZyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EM0ZY38JZ9AxQAQulo2m29nArWssTJV+f7LguOykdcG4Tq+qnPoo2lQq8gNjoy5y1
	 K+6Jvy+PQxJblVimCXBEvHw1REpjYQIDAWt4W9RXNdUW5suYoGgAanzuhhckPuVopl
	 WEnJOenZr/PMFWI9cFmfw4ZwzY5GafhJFbO61cMo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9B720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLFUYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:24:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33196 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AW7PYIp+9O1RtGuIvmVgL3cebdwB1FMoYgCvLRwOZyo=; b=M9/hvARMtKKzLGv9wXfbBiLOE
        MyVq0P4XE3Jq3wcyDPdWfr60aaIOMNFSaRzZmqNLci5lmfBokiC3AmelsgUe3g0vF/2ux12MmeQfX
        Ltvb7Fx9CrWfJycnBmHUTkcq7XF0kZycs6YpksYnIXzhzWZLC22bC2TveCE+68kpE9lbc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0Bg-0001fX-Tp; Thu, 06 Dec 2018 20:23:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 764BD11252F7; Thu,  6 Dec 2018 20:23:56 +0000 (GMT)
Date:   Thu, 6 Dec 2018 20:23:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        dgreid@chromium.org
Subject: Re: [alsa-devel] [PATCH v2 1/5] ASoC: qcom: sdm845: Add board
 specific dapm widgets
Message-ID: <20181206202356.GE3084@sirena.org.uk>
References: <20181128090037.257359-1-cychiang@chromium.org>
 <a6401825-6ca4-d187-5626-4843c660c7fb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <a6401825-6ca4-d187-5626-4843c660c7fb@linaro.org>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 02:18:25PM +0000, Srinivas Kandagatla wrote:

> Am not sure why are you sending patches that are already applied to https=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=3Dfor-n=
ext
>=20
> It just wastes other people time in looking at something which is already
> applied.
> Also it looks like you have not picked acked-bys on some of the patches!

I've applied the patches with acks, please resend anything else that
needs applying.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhVsACgkQJNaLcl1U
h9AFcgf/YwR4tIgN43bL0L0pFZzYILi0HDhYxOnPXjuJw36pSk8zWEDWgaw545y2
DPik2niXxq9q9TY78W3g4mx6HvAwbkKAKNrMU903H99Y5q/aaoNTHkwFCkzsElPe
ArioextoNV4nV3bQJ+epDvxMwcEwQLhEgvqs8vaI0P7BgKHyc4C+qpXS5sqk3j1p
tSWFql47B2UT4T/ZePfGJuqcyqHpgXs/zvIAbmY3XWkyJVwWi2T71BQvxpKQEJLV
b/wbHXj7ZMIK0wDjs89giEQzIAprF4dOWoj2PP9mu/kzdXZORPzJSqIBXOt0UGaJ
oOki1M2Crg5lsQ77fFKH/9y5Xu33mg==
=2i0x
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

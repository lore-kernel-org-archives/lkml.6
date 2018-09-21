Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5973C2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pMQMoUs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5973C2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390999AbeIUXUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:20:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIUXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F1bi4/JaU8RMuusTSrnwdTafSYC84/kpl580wMlyg84=; b=pMQMoUs67KRhKcMFD2mKubh2w
        um25Khpbcz0P6t2eP0Xgdxf6kpEv7HJoF8Iqt4ydeb+88eT3wJBvc6cwQTQyYAVq7LtqdWj16SV5s
        BLztMtW6BhgmQhF3t+MxuJ0ZTLwyZN6xd2g+YWZOlf61+YpTDcbJCTZkH2dVLek+L2lsE=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3PFi-0000ih-2B; Fri, 21 Sep 2018 17:30:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F11CD440078; Fri, 21 Sep 2018 18:29:59 +0100 (BST)
Date:   Fri, 21 Sep 2018 10:29:59 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180921172959.GG20825@sirena.org.uk>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 11:27:46AM +0300, Matti Vaittinen wrote:
> BD71847 is reduced version of BD71837. DVS bucks 3 and 4 are
> removed as is LDO7. Voltage ranges of some regulators are
> expanded.
>=20
> Add initial support for BD71847 with BD71837 driver.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/rohm-bd718x7.c            |   70 +--
>  drivers/regulator/bd71837-regulator.c | 1055 +++++++++++++++++++++++----=
------
>  include/linux/mfd/rohm-bd718x7.h      |  271 ++++-----
>  3 files changed, 879 insertions(+), 517 deletions(-)

This looks OK to me - Lee, the patch is almost entirely a regulator one,
are you OK with me applying it?

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulKpcACgkQJNaLcl1U
h9Ds+Af+Lj7+qfn9ha/iNYcNJJyfbCS97JSlbC2n5I0h1L/B3wO2ZTUj153Q2vxC
vrpjpex/2m5i99Xg1a/fIV1y09dM4M8Ets6lLxYmmUeZ/1LRUR80/rsX/UjqS0J6
+TZZ+PO/vUPNHXW38DfyoEyeG/znETXQQdHrktZWFn4fKgDXZVC2BwePGdOYEynC
b5AL3auAx62FvwO4m2oW7vSegj2QIBuQbZx8o1C9/YpjwHI1RYCjdY2NBtsHklH0
/x/uOdmmtUP/8MoAkG7uDZyliJD+rn2QVrUxVOlcpnCvI+8XfAnDO0OjVF/0ijaW
P5pa+noqz28U+7dSALRdMR1/1237tA==
=C2rq
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

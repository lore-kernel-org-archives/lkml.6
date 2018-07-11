Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ADCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0268120883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KRIFtajF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0268120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeGKJgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:36:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbeGKJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ww6a5SORxHYI+HyV5fWwLPNSwngxlsWB34EgYy9s6MQ=; b=KRIFtajFBI762w+vpPXYQ4RhF
        4Gi6HJhuzv6FU88435Ak9wwUSnYoAJfmqKiicmuRv2Quww65ru6HV6RKonst6Mha2ogryqTsE7wCQ
        wOrQ3Jmc+tPvWCc6kFMGQ1EYyr+/CPe3ddJRkYWks9ppvmMwcf6t+sW9q4WUz23IfkSYI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUH-0002lJ-V1; Wed, 11 Jul 2018 09:32:42 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUH-0002z8-7b; Wed, 11 Jul 2018 10:32:41 +0100
Date:   Wed, 11 Jul 2018 10:32:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 2/2] regulator: uniphier: add regulator driver for
 UniPhier SoC
Message-ID: <20180711093241.GA6561@sirena.org.uk>
References: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180710174451.GE8104@sirena.org.uk>
 <20180711113134.497A.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20180711113134.497A.4A936039@socionext.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2018 at 11:31:35AM +0900, Kunihiko Hayashi wrote:
> On Tue, 10 Jul 2018 18:44:51 +0100 <broonie@kernel.org> wrote:
> > On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:

> > This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
> > if the disable value is set and errors otherwise which would be a good
> > fix for that.  Could you do a patch for that?

> Although I'm worried that the register have a value that is neither
> enable_val or disable_val, the "is_enabled" function returns whether
> the regulator is enabled or not, so I can apply regulator_is_enabled_regmap().

Yes, I think it's a good thing to add that check - it's possible that
there'll be some other value in there and it's better to be careful.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltFzrgACgkQJNaLcl1U
h9AW/wf9HMopIpYBQZqBzow6CX663DkLtJAlY/aVrzTaU1fupxzxrJiBwBAWZ5ss
+AV8zLdYjfvUcn5MXinafJ3Xx13pGkGnIYGm3f32z97jDAFb4+fxjjKL+Tc4Lozz
LV8+r7HRK3qB0kha7eqix8bydqByDFgLzvmIo0LOn+BqpIvKEE0nNLobTJe9swXG
S7brcJnRxmCGsVmNYejryIafIYPdrxiuWOoPXwj3qYX2oLB/aSDGDd8oOq6xnwQg
86HEfg1H7QeGnKOFCZBUJqoQuvMxtWr2QuqVX7u5htETFeTBstzPg/MmNdu8QQ0S
vLXOdgRNutcLlxTDDg1PKLXxJjMQkQ==
=A5ZE
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

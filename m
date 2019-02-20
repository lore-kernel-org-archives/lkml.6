Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E632C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E892147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550680814;
	bh=Y666nKxXhm2en+DQp6xn25DUgCZDiFBHH+YRC+0fH50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GdiuSRIdKXPV62mLvJpWLmrH+Iql1UaRV7qlGi/wpWMLSQXd77QzaV8fcjJGV8HEl
	 agCEgEX3qZJWMRhgn4nWD/6l48yfbq8SBZT/7ACWwhUHuWZH9nUUjkTNTLmd6RpJwQ
	 +thDffTl00eascVljj7jjOXXaIWF58mOYzIAUAUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfBTQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:40:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WCATRz+NDxj7Sc/JJ6H0eVWIi6f6Ucu2gcMtnbqCsEA=; b=I6Khlen0+4jqPzi+jSzkIrrQk
        qTH1ZraXjxhPpGmNGuMd6F8iBxpQsKvnHaK9u7jyM5stqi+i7bRxjjRaAUjk4wD7/5KEcBddbAYdY
        dOssfJWX079LJvAqPxMJPW8pukC/gZg6bmp/CWan1vXg8ZRgiOvwuv42fxjBn4dlX2vS0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwUui-0005Bn-5P; Wed, 20 Feb 2019 16:40:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 61331112882B; Wed, 20 Feb 2019 16:40:03 +0000 (GMT)
Date:   Wed, 20 Feb 2019 16:40:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: tps65218.c: fix LS3 issues
Message-ID: <20190220164003.GC9878@sirena.org.uk>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Cookie: Is this TERMINAL fun?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:15:50AM +0100, Christian Hohnstaedt wrote:

> - Fix list of valid LS3 currents from mA to =B5A
> - Fix selection of min/max microAmps of LS3.
>   Selecting one of the configured values as max value now really
>   selects it instead of the next lower one

This is two separate changes so should have been two separate patches,
that way things are easier to review since it's clear what change does
what and if there's a problem with one change the other doesn't need to
get held up.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtguIACgkQJNaLcl1U
h9AF0Qf/fl2EYOJDIhIr5YJ368Jm/dHKVxTRIjwETYMpyWf2QvKsdU4NnUdnxDiB
PEkmQJA8Z0qy0DTcrd97md6/HpozZMf3G2zY8nZP42URa/V8wn/eXnAIUIHi8Nro
cI8sL+/1Bk6tl0b/0kcK0uu6m116D77y9ZMGf/nXHBKByePKC7VrnjFH8TPkT7mF
HT8hT1ePV4u1xiKiazDsRmCN5T057AbmP60H/+PiZnO3ASdYGPgqIFzyIJVmMtbm
4q2gDdP1abbb8Ia2vF0s2R93/CTXNclHcXpNTHAYhkaT8zycg4vU4cpxoMOYNw6w
bFUOtyDlKyGgIHMh+aOLG/kFhlEcxA==
=Toz0
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

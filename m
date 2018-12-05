Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9012C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AC1206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vK3A+gCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AC1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeLEPmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:42:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeLEPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=55TyeFlz7u/hxwRqrO82wv5l5zx8oe5HJY1pGRhm6Ns=; b=vK3A+gCAaIsS9kce6mnQqFZ/S
        oa+Hh1qy8eER5w9q5O3/K3rPU9wzovoc6mbsgxXVV1dOhFhiIW5i+a9En+QgxkVRXs/iizfzQTMbe
        TwkMWQ8yH7N1v7HSFcciiu2wyfxHY2lkZ/vRPBtPcWHNjMG2IWtLCkn6RvUeh/YIY1qzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUZJl-0005kV-JZ; Wed, 05 Dec 2018 15:42:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 245B6112533F; Wed,  5 Dec 2018 15:42:29 +0000 (GMT)
Date:   Wed, 5 Dec 2018 15:42:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
Message-ID: <20181205154229.GG6205@sirena.org.uk>
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
 <20181204214313.GA7847@bogus>
 <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
 <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:28:51AM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:02 AM Kirill Marinushkin

> > Mark already applied this patch, with a slightly modified subject:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commi=
t/?h=3Dfor-next&id=3Dfd7de6370cb62b147185834d60069568a21acacd

> Humm, I wonder why I didn't have Mark's "Applied ..." email for it?
> Otherwise, my scripts rely on the subject matching which breaks when
> maintainers edit subjects.

Probably due to some problem contacting patchwork, the CC list comes
=66rom patchwork so if that (or the network to it) is unstable then the
scripts can't get anything that's not in the actual commit.

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH8eQACgkQJNaLcl1U
h9DWJAf+OJOWPgoV+KEapu9aBDq3wx+p4krlactixoGKLRZdy1B4LbFyTjHAPom/
S8FqictKN1mSH0ukT2pYUoGz6YfrFV4q0pzX8+VQvvBjh97x+f9HvG1WC3AVwUgQ
Z9SkBEUfDxU3j2i4HSALDvcraf/+Dr6G7o/dTSOaQcfu9sLvk4lrcSap8HTOL90q
EvYclU6B5xMPaA4WIKWqd5B7h9+REDDF+THSQrOY5O5SWjOtT+z+WQlHYCg3vDD+
E4MZOYYKtYDR0xK1dC8iVA56c7j1IeRZHYg984xNvWca4A/fo6VfRAGeTupyQiNI
5M0XAglUr8vBXx1o4W/smtSPjwTm6A==
=VSjm
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--

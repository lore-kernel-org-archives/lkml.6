Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51A2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="T8TVKuKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF51A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJQTkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:40:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HG9GSZEuonoGV4830TNe+t/gDDBbrA/JPM4unkwWhLc=; b=T8TVKuKQrX0BhBzXtGhWPitez
        FRcySzXtCFCvb6G4387VMG8e83FvJ8LNWRuMUQ2AgNQyO3MUwMhHtQytLjeuOA4V4bId/fUSlTvbd
        5vbkv/AYAHjGQiYt48sHdT5ccAhQuOefZ/RjY8OqnADMZNgn8C8q7HWbHDt5zhYpFpwNA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCkG1-0000yK-9b; Wed, 17 Oct 2018 11:44:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C287D11224C4; Wed, 17 Oct 2018 12:44:56 +0100 (BST)
Date:   Wed, 17 Oct 2018 12:44:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Message-ID: <20181017114456.GD24097@sirena.org.uk>
References: <20181016104730.4598-1-marcel@ziswiler.com>
 <20181016115852.GE7449@sirena.org.uk>
 <1539773488.6233.22.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <1539773488.6233.22.camel@toradex.com>
X-Cookie: No passing zone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 10:51:30AM +0000, Marcel Ziswiler wrote:
> On Tue, 2018-10-16 at 12:58 +0100, Mark Brown wrote:

> > These ASoC patches appear to have absolutely no relationship with the
> > rest of the series.  Is that the case or is there some dependency I'm
> > missing?

> Not outside of all being Tegra specific stuff, no. If you prefer I may
> send them as a separate series.

It's fine this time but do try to avoid doing that please - if things
aren't related just send them separately.  Bundling them up into a
series creates confusion about dependencis and can result in things
getting held up due to problems in the unrelated bits of the series.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHILgACgkQJNaLcl1U
h9Dlnwf9Hvnm9dwWcAvUbfoH4cnxb+vYi5ve2/b/BwWLnNBVP1U/Ri4IWtMRjtdp
j01Y22pkqYROWXj3IPlPW2D4gBZNwFCL+JqxpJhE4JjEeSplUf0LaZHOUAxJ9Wja
co27D6T/C5Jd4bX8Bo70FaVRFic2F5Gw9PAy50MeWMVPLmH7JS37BU51FZCv4yzl
TNhFFX/BkUOxEZCtp7s4yWJewuUQL55/2QvyD15EVvmWglYWNvF+3DkJigvZ9pqy
Dm50cnpeKZPg2u7gAQ4bYuylmlcBAJav+0s4hJZv6pTVVxZW/NVEmODb8Dk1CE1B
saKQisMyB9gRbUGvzWB1K95XcHgk1Q==
=14T+
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

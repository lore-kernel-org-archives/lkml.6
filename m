Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF10C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4122620870
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EoDG6iK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4122620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIGWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:38:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeIGWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sP02+WZAEVNeUjreRYYGutrxK3DGZ/il9YWD1m4STNY=; b=EoDG6iK2R2ntKJF1QsOORvF37
        8866VyYJI8mvjR7BTAo9gLXhDGuHYMz72CEHDoRlufNlEPYf/F/gGR7wseTn5fpn0AsyZW1N84+WN
        NJkLkgaJryVUvELf7IhgXBY/nppotKDRBiUCnjV9Bdp8ii6Q+sYHdDNwN7GZb4L9lYlbg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyKzU-0005mj-MP; Fri, 07 Sep 2018 17:56:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 341901122A6D; Fri,  7 Sep 2018 18:56:20 +0100 (BST)
Date:   Fri, 7 Sep 2018 18:56:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     ryans.lee@maximintegrated.com, lgirdwood@gmail.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Message-ID: <20180907175620.GL17459@sirena.org.uk>
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk>
 <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
X-Cookie: Do not fold, spindle or mutilate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 10:52:24AM -0700, Grant Grundler wrote:
> On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:

> > Note that this isn't causing a warning upstream, presumably due to an
> > implicit inclusion that isn't present in the v4.4 kernel that you appear
> > to be using, or gets missed due to config differences.

> Ok. Is this just an observation or are these reasons to not accept the
> change?

An observation, you should already have a mail about it being applied. =20

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSu8MACgkQJNaLcl1U
h9Da1Qf/av+NNGne88nxbWrscrd10NjysRVgLpRfdYyyU3iPXln43RiTKN0+Wqxk
DM/K9kXyRW/5vbm0KYK6O5obBPnWfWB5rUI/QVKNLzObfUIni+Zj53otfo1giJCF
MkApUDrhUwCOf8V1A8tgwFO91Qg62QWMzs04bq2mrpw7quHQAXcBQjp/vBWldtAn
fSUaurW7o/fpWD3C1o4dTPqayqf43/m5T/k0c1QJ/pKDwGtL5QBdGucyrRjULORR
rD2jgaGoxwMMcySfcPvqVzM0EM286Vi0vh62oBojRns4zOAxf9owbBnpAAf1MBqY
Evgn2+d60flDCXXVhVxPSTNzgcppHw==
=ETFg
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--

Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C068DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6769120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549630441;
	bh=8m5tpTCepklztt4xsob/L8NlVzc7xaB4GjjppTmRTSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IWu5ahtgX/INOS+/72o6mJaiY6LJiPfhQL25dzrDxtXaRrR3r/uKiElp8qb46T00q
	 Mt5SPy9mKMSckSoQ41+FD3ss7Epb+Dvuu6PeTYRUUGd0AitubcuWW1OJ9PYlH0q7x8
	 SPAJCZj1s1yjPkDLteKml9MSKYQJpEVSDHgSWTeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBHMx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:53:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37212 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iLz3P+K/nygNyOnAM4k9nvDorKA9EmT4eY/OOc8zWqQ=; b=D1BFO892+3M49UvcdhbzrEJU1
        N2VyuRXPxjzBHMelp/N+Q+CDB+Dl8TmkMFZZ0pU2EKqb0qHPrlubzmLvcUwRJC2VCVqHe0SFSbcc2
        5f3q67YXmNfwz0XVdX3UfQFo/a941HFPpJ4tkv2yFIWNkvSgDJy6tSVBrmYANcaXboY8s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5fF-0001Hg-T5; Fri, 08 Feb 2019 12:53:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 69B1F1127F30; Fri,  8 Feb 2019 12:53:53 +0000 (GMT)
Date:   Fri, 8 Feb 2019 12:53:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190208125353.GD6695@sirena.org.uk>
References: <20190208131823.0fd205b5@canb.auug.org.au>
 <s5hy36q91e2.wl-tiwai@suse.de>
 <s5htvhe8yic.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <s5htvhe8yic.wl-tiwai@suse.de>
X-Cookie: Mickey Mouse wears a Spiro Agnew watch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 08, 2019 at 09:39:39AM +0100, Takashi Iwai wrote:

> > Mark, could you apply it on your tree?

> And I already took back the API change from for-next branch for
> avoiding the bisection breakage.

> > Or let me pull your tree into mine.

> ... so Mark, please send a pull request to me for ASoC merges, so that
> I can apply the API change.

Done.  This sort of thing is why I like having lots of topic branches :/

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxde+AACgkQJNaLcl1U
h9DH7wf/Uv7GKN1wnpS+irjMF6ZRcYl87X/066NhS7w9eJO4/I8cLX8h3DnYnRTO
RExacVMnwzIhxVWpdHTzj+2iW5nxAntxQUMfcw+lzMCpe8q3Lv1RCOpuVHAd5KPa
VybTUcXWDNLzufBsmzqTobm/yJUCdcvG8WgG0rKjojjUGDDf+WsP0Kjbei/cVocP
bsA2dulaIq5nhqDbVXaPlRFQOJ+q4bMbFsrn6Qzgif6dSIr39AsOIovYlXHIzKLt
jRmU5/GYRhmj57d8sp2Y8JZDB7w1gloJoI/hlDoudtkrynVKJugyDhy/ufDnj1rj
3TQ4KG21mf3aPd11oHVwoL/chmvwiA==
=+3WI
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

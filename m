Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45539C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9121A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="A6LV0Hwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C9121A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeHFNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:43:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47028 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbeHFNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QVXoDPwgOj0IIecW1ODu45ik4lv53/kKCWFMwUrOlLo=; b=A6LV0HwdDg3/pV3Pv1/7zp4Dv
        607OkC2cHMfxjIsTOfXyNCrthupBCaEDXd86ZKhWpSEgk14nxOJB2MzcSzaNWCQHS3X7WO8vT8GIt
        tCNChqjfRSgj0/pl+9+JBlg0/Xah4xWIsnlH6D+VD7oMYw0Ri2jQD31+QhJcWPWTiCrwY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fmdmM-0007on-Vf; Mon, 06 Aug 2018 11:34:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 93A611124240; Mon,  6 Aug 2018 12:34:26 +0100 (BST)
Date:   Mon, 6 Aug 2018 12:34:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Message-ID: <20180806113426.GA17525@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <39703.1533318918@turing-police.cc.vt.edu>
X-Cookie: A song in time is worth a dime.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2018 at 01:55:18PM -0400, valdis.kletnieks@vt.edu wrote:
> On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
> > On 08/03/2018 11:45 AM, Mark Brown wrote:
> > > Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
> > > noticed.

> I wonder if nobody uses it because any attempts to do so get an error? :)

No, nobody ever physically wires up an OPCLK.  If one was there it'd be
unavoidable.

> > I see. I wonder what's the best approach in this case. Should that code be
> > removed instead of 'fixed'?

> I'm thinking that's a spot that needs a 'break;' added.

Yes.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoMkEACgkQJNaLcl1U
h9Apqgf+J0nzjGBWmBrdQrw3Oij0LLWled8F5vK8DW/8xwLlhyo1NMaCrBzBldoI
1V5ualL+zq8IJTBEZUp4Y8reRsF0xUBZi5hGdyq67j2mU+PVz13NEXRl0L6cddDr
a8stUW107ah26XtHfEBFS+/Pgitkldml4R4TMgLhspZqn9rILrF8JZ0zCmGocqg5
rKIHzYU7D79DDgpIXK3scrkFTQW9rZNqrR9ZdZNiDeHQCLKOv0WRn4P819eM7SrV
fyKuixESDLPHC9BNBd7eIMq4tw03RdvgKMirpwsLIPyzccwXHNAuY8rABgLwRHOE
AJbTIs7Mpl0BacNDNn5BDQdEOopMEQ==
=yaI4
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

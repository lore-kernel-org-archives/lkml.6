Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6742DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3382E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990191;
	bh=Gs8QNVyr12LwnX3nDEr8WikT0LclhdrDnMCy3/DVpiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yc3fvfFJG8MzRv9xNzjy+Z9nBdn+Ng6x/HhhnvSyQ16T8BioAPy/7fIvjioIyrnvK
	 VenW0KfvcNuKff2v1N2isCwNPDbqFeDpLGyAez4+hUR+Xmr+2Ol3LEH3AcWsACygRv
	 7rlO1Tx4OT4XKrzD4CkOvE7u69IKlo/EDS2kei3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfBLQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:49:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49044 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ltyMI1FR9wXzP0Sg9dSkZ6eWigBzhyAQrSd0PssNcWA=; b=mzKHNJiOBnkPN9O58piOZuGwx
        QXZpxLWW8uzKltAyBctwJ1EZr9OuxXVEfZ17pi6LUYreOBo2PnWc640L+rrwA5gjAhmpyfbS0BXKc
        5SWcGdRmVjyIXMRTYyX7hrM4z6uXsfwgrJapUJdR2VxGyHnFotPo672kC2nMDJDJQxFT0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbFd-0005bU-0Y; Tue, 12 Feb 2019 16:49:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6870E1128113; Tue, 12 Feb 2019 16:49:40 +0000 (GMT)
Date:   Tue, 12 Feb 2019 16:49:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Message-ID: <20190212164940.GI20635@sirena.org.uk>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <20190212144359.GD20635@sirena.org.uk>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 02:43:59PM +0000, Mark Brown wrote:

> Mason had submitted a new verison a couple of weeks ago and there'd been
> no replies on the new version so I'd thought that all the prior issues
> had been addressed.  I guess that's not the case?  The thread on the
> version before was a bit long but seemed to peter out, though looking at
> the archives it seems the main issue was that Mason stopped replying.

Following some IRC discussion with Marek and Sergei I've dropped these
for now.  The interaction with the HyperFlash support seems unclear
still and might be a bit more than a simple refactoring, worst case
it'll be binding incompatible though hopefully not.  Mason, if you could
work with them to figure out the MFD that'll be needed the driver looks
fine from a SPI subsystem point of view.

Sorry about the confusion for everyone here.

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi+SMACgkQJNaLcl1U
h9C84Af/cS7fCpLU+Lf+jhGYKtuIzQ+L2S3hPAMWRwg7OoBXok3jTyMHLs3Tin9e
ev69K6yi+yIObemPTHA0K74u7LHtNbe3qZhGmuJ864+3FpPecUbgqmnrGd9eBENH
S28tgG0rORO+IfzwxjvfIFfRdL4Btqra5UbtIyJRvMPM4XXRiIE/iHX4z87XtRkt
QOS8nYfasrQQsF0tUEi2xSWdXMTIss9uilYc/Y6EXlaPw1BgmLu9dn7i/YI6ox8e
wi35bMH12U8lDvlgu/izyZOXO3asTCzhIwhtaP+JYMtmd6NX7CjDBSjcDpiOSuEq
vHOxR7tEKoAn3ZW/5zTy0msgWxf2gQ==
=ykMc
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--

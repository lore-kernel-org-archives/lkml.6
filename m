Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464BC2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549982650;
	bh=NimxK33LgnlIe82zRyz8rcBUqquKZf6SQ+47CDpwDsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUtI8lJ9lzerggZR0ktY0lAtPDkbR8h4NZUqL0DptdkcSm6GFW/BpAZo3YEsJOuBi
	 ZYU3TX31CpayevWCG8McKHvwqv7K40CK1bkWckMoQcaArI/6f4IUtBCTDDflw/ba2h
	 a3CmjFiS8w2py33rbKhcS9oUFvhJwfTQXIhJcDyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfBLOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:44:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35784 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfBLOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VdUMJMPfmd7CVWgmSlFs/CqCotbmfz3h3GhpnUrZs54=; b=Nnsyn3Xqlfn5dxrbeGLeoRsbc
        xJk4Y26c10ozucROTaYLXbxXzuapBFl25yuDtbMJHHzKpkPF6t1Zoa76p/mGfwOVfPntX5M42p2ZJ
        ulYRytqMGQUzNSqVxIRhmihzqwkGNo0eOaY4QAGSOSOAncPEeLjWaVw3pGypY2DSqi/MU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtZI0-0004s0-3f; Tue, 12 Feb 2019 14:44:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9DA351128113; Tue, 12 Feb 2019 14:43:59 +0000 (GMT)
Date:   Tue, 12 Feb 2019 14:43:59 +0000
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
Message-ID: <20190212144359.GD20635@sirena.org.uk>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 03:33:12PM +0100, Marek Vasut wrote:
> On 2/12/19 3:22 PM, Mark Brown wrote:

> > Please add any relevant lists and maintainers to the CCs when replying
> > to this mail.

> How did that happen when there were still comments and open topics ?

Mason had submitted a new verison a couple of weeks ago and there'd been
no replies on the new version so I'd thought that all the prior issues
had been addressed.  I guess that's not the case?  The thread on the
version before was a bit long but seemed to peter out, though looking at
the archives it seems the main issue was that Mason stopped replying.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi264ACgkQJNaLcl1U
h9AFBQf+InV2NQw09IwJftrVq6O+axOUZvzplV30iug74PogmmP4Um4nY7LxWIqL
m3DJjb5leTEYHkn8oPLj5LP/X7+kaIOBkH/+b+IuCDnEV1YMsKh7uZILX5TXdHH1
GVDdp6E6wotMDarZSK2h1w08ote9kc4XGbuULxkYzPqKHSdqGWQBknh5D0TGU7Mx
sRq8r15vXFIW+RlJIN+r+CIWj8eyqEdezi+FNlqDY0bGRrwBlGxtZb/XneenmE84
zV5QlKPYUeRgVgJGCFHylh8ca/0lC0M+x79lv4pntAXkZ3f4H3LKX3rGKDfDPc1x
crJRcDiEUKJGrJjiWx1pP/zMdLmx3w==
=6Yyo
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

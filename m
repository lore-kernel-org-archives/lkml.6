Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1968C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547832540;
	bh=2siYX7/y5FZ7VUQHcrz6CCCX+G6ycROtSDFIm9TdxRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DI51RUu94WIYS4dWkGkSWo/NzFnHJxJ0YGhetwxyt5aHEaL8bwYkfDohg0IHNxs4o
	 rSsiXVdkSte4UwJAG6OXgreo35fpu/lVEs8J3ZKkZFHXyLeozRZgIFgs2kAQivOxyJ
	 3OtLKDF3SLGnrouc3ec2KEE0DWWLaXJlVDWNwixU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfARR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:28:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfARR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2siYX7/y5FZ7VUQHcrz6CCCX+G6ycROtSDFIm9TdxRY=; b=V4wK1Opz0rnKfoS5guYfC7Gc2
        fW4QKXf299Lh8YaPPq0WR5+POWQF1HgN3WQ0U0xWoK9G2vqEHBR/Nq3xXwZbBvoIiL7mBeMjJa/wm
        0smO44bu/ucUwRY1GhoqnGiku7NTv+Ak1nHoLFnUAlf9mMdW731p59l9BbRRq082895/8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkXwt-0005Eu-Lq; Fri, 18 Jan 2019 17:28:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EC3C911276E7; Fri, 18 Jan 2019 17:28:54 +0000 (GMT)
Date:   Fri, 18 Jan 2019 17:28:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] regulator: lochnagar: Remove redundant MODULE_ALIAS
Message-ID: <20190118172854.GC6260@sirena.org.uk>
References: <20190118113631.23706-1-ckeepax@opensource.cirrus.com>
 <20190118113631.23706-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20190118113631.23706-2-ckeepax@opensource.cirrus.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 11:36:31AM +0000, Charles Keepax wrote:
> The module alias has no effect as the driver can only be loaded through
> device tree at this time.

It also does no harm...

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCDNYACgkQJNaLcl1U
h9CyNgf9FotB1DQahteUKuvmJNNjQOuUk1YtGJV7SJf4O0FOqoMKgz8u9H3lskOe
jEwLl/+i4HwFT5x29q8vWsu+Xqz3lLMLpEdX+WddYQyYR1ASN6gHY39R9TKUQwEl
lJ4sPGGjzVydY35NQh0AqN67tLVdLIS++iSEfa4Rm9+iyF1XkqS+U5YhHFBvXslj
yYRUZ3ljNE/qSqdyqR1XAGsNL9dsJ9tZJSSiFFaLQo4jJQZCMU0yF0e8TbbrKeDI
pssN3dsowW9UUe0oEcRBpLjLAXVMgf5la/ljxc+z8R6VvD3EPom/zQZfni1xGErI
t5Ssyze4VIS5nbEekdUPYa0n9Ns/2w==
=JtL2
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

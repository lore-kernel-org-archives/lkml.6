Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CCC2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549904333;
	bh=5gE+sldJ+cJUl+bxpbxtliDsZaPs9BxUcltFjN0KCdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wtuOdjdfF5PZt7eIwpvezwmlvtKJB+ghJIsdBvmM7PQwTfJ0vnyzAi/SGP/LgXPOb
	 PD1lXn5AkE35uc2Wj0ihx9YOF+AsvuariXqcplwPAqVAQ2/30b5MmrIu6PJrMFngQC
	 SqC90Uvu+EtW/LLEBxA4OlHjHdyzNBodIyKdvuNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfBKQ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:58:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfBKQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rv54XH4oqkQQn5ow0gBegq6P16nCT1DvfLnU46oU21w=; b=e+xbBr0hpxPzJIBwYq2b13hCa
        QcT9wjjFD8xld3E2vGM7lNmCpSAfFqCCgoJrQwR9JlB3fVJ56bnMj0J4kj4cWjV/qAxI6Rz3k9Pz4
        TQ/AsiuYbf0nrShe5mxe7O7fQMQqMwBehmD74Hqwfsu3cg5rrqUnxwyKUWAV84piNF4Es=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtEur-0005IR-FA; Mon, 11 Feb 2019 16:58:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BCAE211280BD; Mon, 11 Feb 2019 16:58:39 +0000 (GMT)
Date:   Mon, 11 Feb 2019 16:58:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 066/352] ASoC: sunxi: sun50i-codec-analog: Add
 support for cpvdd regulator supply
Message-ID: <20190211165839.GF22391@sirena.org.uk>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141850.315232314@linuxfoundation.org>
 <20190211143924.GD22391@sirena.org.uk>
 <20190211165008.GB21634@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20190211165008.GB21634@kroah.com>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2019 at 05:50:08PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 11, 2019 at 02:39:24PM +0000, Mark Brown wrote:

> > This is more a new feature than a bug fix, it doesn't look like obvious
> > stable material.

> Normally we take "new quirks and device ids", and given that this is a
> tiny 2 line patch, that seems to fit that requirement.

It's definitely not a quirk, it's changing from completely ignoring a
supply to actively managing it at runtime which if it has any effect on
existing systems is more likely to break something than fix it.  It's
not like the fixes for build problems which can't be triggered in old
kernels, it'll start us things we never used to do.

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhqb4ACgkQJNaLcl1U
h9CnCAf/bT5TUqOGA736QqtbTP63wZmfa0D6nfq93+xIfR7p2/W42Jg0RmwTYjdY
6CWqH+atFnlJy+lMkRSXlqtiDU1VLI5XCeQquGX/cpPrAUNs3BYBEBqvTFolRAvz
KBeEEJOJHEp0yV0hi3+73j2TVbWxlzGMbiyOKfM24PyRS2fURhnSrVtsuCJWpKJY
yAgp4SboWkwB4cCW7D6aZqvnBKyXjJi1Z+vNQ0Qg1SjzcLrZC/MGz1mVbsPXr3HD
QgE2h0fEYm04+8Fc2J+E94bNPTfSN7F6L+v3Q7Yo8BikAKykKmTJ+xyFPL1f9My6
t6ZnNR4Xn5ePw9FQQ+yPZHC9DCkS2Q==
=7DMV
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

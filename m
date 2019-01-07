Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0985C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD93206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546889049;
	bh=olevA/aSuFYkCP0vcQFnZHbcHPy9J4pvLkm/089vy4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gX2umI1xL2hZg/r9rUBJDn7XCDrNLbn6/1xvsMkshYbB/yA0ad094gdf58lcDgoXK
	 dT+fz8dVO/Acc0MRdGqWkKnoF+JtWbLdi1UrPHGrPQkQDihlOy7l1D93epooxekqdo
	 0axTFBW36Dks7b1PopfooqWjlkBHQEmTGBXPwxlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfAGTYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:24:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=olevA/aSuFYkCP0vcQFnZHbcHPy9J4pvLkm/089vy4s=; b=jYajrNR0zlEYrSQKwzHPAdInw
        AbJwhoG1QB/Ywh0O9d+GxFopNoDve/b5HhCAcBbzq8pErcOwvkWnWtbnQeCuUaY99+aZAKzTOPl17
        surf8O++qDiogzpRIuZJ+oJExdjaHXWKsNztaBO12Ygx01AVE9O02CLOCgdWHavnSoO18=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggaVG-0007yu-IX; Mon, 07 Jan 2019 19:24:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1D1E41127491; Mon,  7 Jan 2019 19:24:02 +0000 (GMT)
Date:   Mon, 7 Jan 2019 19:24:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20190107192402.GW9570@sirena.org.uk>
References: <20181226070317.72022-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ItroYk2LVxvwOvi/"
Content-Disposition: inline
In-Reply-To: <20181226070317.72022-1-cychiang@chromium.org>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ItroYk2LVxvwOvi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 26, 2018 at 03:03:15PM +0800, Cheng-Yi Chiang wrote:

> Note: This patch is merged to mfd tree for-mfd-next branch already.
> But this is still needed on sound tree for-next branch in order to
> compile cros_ec_codec driver.

Is there a tag I can merge?

--ItroYk2LVxvwOvi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzp1EACgkQJNaLcl1U
h9CO1Qf9ES+ybSf19Za28W75SnfW++LEqVwGgisWplt8MBo2fOOjywLrbG0nwXWe
hyuunCw9zeppMCfE6GR6r3t4CpP9iacBqpl4mjolLt4yUCvYZE5p56z04OhrGbJX
0HWU4qTkLaugX6QKFy4M0CWZqtbfRWisjTd8xUylewUhsKr8Z/rglWLE3KtD+NnL
nQp2sL/9ovIDxBi4bSDSF7q8SHvQVcVrzR+gWj1wufmuSa3xWPXshN8+GG7HkvBU
7KZ3i3656iQJUfQbC2Z3BR3ybXRuJdcJ/stHc4mPN7uQ+nAoydbURIITiddY0MjY
gvwBCufgp0YLhuLBhpqmqYl23gKtyA==
=lqSK
-----END PGP SIGNATURE-----

--ItroYk2LVxvwOvi/--

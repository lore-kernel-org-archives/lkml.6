Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA073C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A321218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549026329;
	bh=hN+aFxOHnal7p+l8rpZp5Bo4Gh/s6nGBO5AZ9TLrGCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gUdHP3hUDHj59bOPVikJCxBeREGbcaR+cq07/9ICWcyN3BGgvMfQsnwUjgzBQK1Zv
	 1I99DyoAYSCOxAIdfq9AqlUETARUBEYc+Y4OYrRdwtQ9nbgg+aRw/db4refOizzfc6
	 vU6gr7i8jFsqkDmIQ4VdYJs1mtKhdltn5DwPu+ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfBANF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:05:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47762 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfBANF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sgQRooGZozZW3iAo+OQkbQNFgu3wdNLM7Zl+zazJbcU=; b=k25pvIROhtP8FI0S0PiHssWb4
        H1tw5zUIVaFbHQVWdaL8AhiIjovj5dFZDflGcptpkEy35Q8r/S5O3PQq0aDfNB6dbGSXTnwhYNcU+
        0JgfXAYc30zqApCwgPzGBM/KCeY+5c1DCqU+4YOnKJLriuYnKWDTfOMfsYSmZeiXKgEIg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpYVU-0005Da-3W; Fri, 01 Feb 2019 13:05:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 44DD2440082; Fri,  1 Feb 2019 13:05:19 +0000 (GMT)
Date:   Fri, 1 Feb 2019 13:05:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Message-ID: <20190201130519.GH20797@sirena.org.uk>
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 08:05:30PM +0800, Baolin Wang wrote:

> On Spreadtrum platform, we use one mfd driver [1] to populate the
> SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
> use sc27xx to be compatible with different PMICs' devices, otherwise
> it will be difficult to define the mfd cell arrays in mfd driver. Do
> you have any good suggestion? Thanks.

You can just list all the individual device names in the of_match_table
for the MFD and then it can bind to any of them.  You can always map
them onto the same behaviour in the MFD driver if they are identical
=66rom a software point of view.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxURA4ACgkQJNaLcl1U
h9CmfQf/YnVOFQBR/ZdKkjt44v9jtogltQorJrsUP4SjfNU6eEDwFekGutld//0B
ymGkp7vX9jhWfoLvSl/U8R8iHdhuiI9n/0nE5ryQAPoPc9/CFTpDi+V3F5eR0OR4
CvahpdUXfPJ81Z5NjIFfpeAw086b1kzrceNnPLk9+r6L1jZSu6g4i5r+b8nLGUih
2I3PngIQvW+RKpXm8cpQLnIbyuec7nsQM2yoZi2Lsf4MM3u5saLEVakirb5vND7c
M/Y8uhtiKXQIzeOvi3LtZWMorRulBycpDIT9FjQLvUMDFVQrbtrCIGcaBGnWyq19
bV2dEgsE4ucI6gbuDOn9xMxpO7tUgA==
=zaWr
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

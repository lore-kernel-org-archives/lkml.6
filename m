Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873422075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550837985;
	bh=F455PO0OW0plalxs/JD2W/cYvqi+CMQRu8M5bTLK3GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L1UlMyhgIhioBajVYFqyZZSZukQXFHyS/PKP9qJ9SCsZjPA5NBwFsfBV3tpnAfjcV
	 5UFRkMreO9I+jc0emdf7JkHLHwthHoznFG63ZyiqqVZucvayGlP8fCs0+H840VQh9F
	 yeTiDCxaftPyif3LPYMJWOkt6jn50v33PRZHPsjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBVMTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:19:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F455PO0OW0plalxs/JD2W/cYvqi+CMQRu8M5bTLK3GE=; b=HRAHXwzL4v6S+6h6TsU7hOPen
        rtAfgUKpWfILq3PHAQsNPs2p2UCsJCnX89HahrqGnOPq0P8gwN1LLfaXFmSRTh4g92JYQFuqsQzyW
        auKzwMdkknOKkRko5H6dwuukUOctXgcvhJ3HrvtBm1lnBdN8y6ulryn7jPnqDcUmWtPV4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gx9nk-0003U0-Bx; Fri, 22 Feb 2019 12:19:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C72BA1126F5E; Fri, 22 Feb 2019 12:19:35 +0000 (GMT)
Date:   Fri, 22 Feb 2019 12:19:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: tps65218: Add support for LS2
Message-ID: <20190222121935.GA9271@sirena.org.uk>
References: <20190220164851.GD9878@sirena.org.uk>
 <1550824734-26581-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1550824734-26581-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Cookie: Adapt.  Enjoy.  Survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 22, 2019 at 09:38:54AM +0100, Christian Hohnstaedt wrote:
> Re-use the "tps65218_pmic_*_current_limit()" functions of LS3
> and calculate the different required bit-shift by counting the
> trailing 0s in "struct regulator_desc.csel_mask"

Can you please also resend the DT bindings change?

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxv6NcACgkQJNaLcl1U
h9APRQf/ZsC38d/MqWb5znW9wtYJGyGhggsCmdUJk8xXgHQ4tuubEBjwVunMnP7g
S/mvtzwcaOHDzAwMM+xXZzjzIJi5pAR43pRKfl/F6Gv4GS+eQ2B80Igpbd9rZxcy
zF5mYgaG/mqWLljEURy8OFhmc64w+5nQJ6YYMP4br/yx5CueQs4gBTnBB5sViyCo
E2P2HeMv778M7P+9piczgG2CO4Ifb58wgH/qJTa212PFsjR9ZgC78Lwh2HIauM+0
XiWdN9XxUUpkpRUQC0sAxRO6KPtRDdXJ5xvg58SxmYArxKwtOZ6IPat7CdgIr+12
tCB0p0yRUhMtC8iQA0VWeFvnpepHDQ==
=b1HD
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

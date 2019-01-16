Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E66C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C932F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547644912;
	bh=0h4fXiB422XIVi8xxqXNfKhz7PB/keGojDsDhKn7bIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pD/ysoE84vrsO6c3Ue/ElcXidG8hPUUvKNycyheTVGuP4YGPx8jtko8Xvp0AoWiVc
	 wYCiZlVILvmkV17h3AD5/JE0b6OEB6cI4BDB7QfgAVsSQ8ZBFPWyhLKb5lgrHCr2/f
	 NnZKiEzeuEtXFZsm+XMTty8OcaMPsDhhoHm6ovY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbfAPNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404226AbfAPNVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:21:47 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621DF20651;
        Wed, 16 Jan 2019 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547644906;
        bh=0h4fXiB422XIVi8xxqXNfKhz7PB/keGojDsDhKn7bIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXSq4g09Zk9qNYslA5maR1vv/nf5xkALvO6lXlJXEkvyPCKZLIL/Ijcz31pymw7JG
         T1mxoyW+i/moExwW77HU8iWcbN+7nPNhwy3bHkXf/3uwnhbsKlAGuMX9vHWoGh/EzC
         5M53Ff405vAmWi7TvbQn8EbqcP1g0WUT7GDl84eY=
Date:   Wed, 16 Jan 2019 21:21:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
Message-ID: <20190116132117.GA17702@dragon>
References: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:41:59AM +0000, Abel Vesa wrote:
> Enable all the i.MX8MQ configs necessary to boot.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.

Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D621738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547060536;
	bh=xEQ+uwwNmBSO6YrILiY5f68pgyJrj4JJtuMkMHixFL8=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=ctnHLJXnyg51HVwdEX/BdaiJMBrha53zbcCQ87RYgc39XNEjJ5yrT3VvA+21QfM7c
	 FoHBn86tmseRxds9dEaPiDwOAHaa7VA+c0owJmF/QT5ltJxlSKG8xFkWU8qT/LAHpE
	 P0s4gg5ni/UESEGmt8nLAmbIMMsTcU34hXWcWC3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfAITCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfAITCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:02:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06A520859;
        Wed,  9 Jan 2019 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547060535;
        bh=xEQ+uwwNmBSO6YrILiY5f68pgyJrj4JJtuMkMHixFL8=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=x4HtUP4r7Z7S1AaBRHjJuFXknL1dERwBJBqbT2EiHPNM03S2+VH9WATY3XsXGGp0J
         hTDwO0PvTGlpsR2Ws4O/Bf6gGCEtsraPnoksvunuYuDgWKH+s1D3xk8KmFyIJPVwUK
         DFaug8z2azAcZM5nP3iplrlQeZIIRYqn6AEdG/kY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] clk: imx: Make parent_names const pointer in composite-8m
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com> <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
Message-ID: <154706053417.15366.4490138181504807265@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:02:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-14 07:30:09)
> The parent_names needs to be pointer to const pointer to const char.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next


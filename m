Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96BF214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547060545;
	bh=HoPdtmHSu5EfuKil8L6NypIgFclfuIWpMTEokFWABvY=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=np9Oe/RKL6I9daHIKxq7jtmWlXg/Oq49XDcBOs0Dnl74BFr9BrWMCdsg1ftgE2Mre
	 EafaOOd9LXMI5YN0P2gUuCtNJmVIUoQ5f0XjhUrbFumXCMlcAXx2Kn/C1irdVYTrob
	 aV8kGTZv1KABnNZR4k+SqKUKDfErYYCGZTGxQVs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfAITCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfAITCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:02:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EADD20859;
        Wed,  9 Jan 2019 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547060542;
        bh=HoPdtmHSu5EfuKil8L6NypIgFclfuIWpMTEokFWABvY=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=pNCaQ07iMef6k5zaN1Q2Ai4OM/mafjtexQQbVtt9i0Iiul7sXyLmAF7Hdd64EVIz3
         XRlVJQiaFGrx9nU1Wz196KDQWRRdPz2X9BWc74BDl3Zm+KrNwMzd0piyEwKg3x2LUM
         dNg67moAuWRjK4g8wxuLJqiJ4LV4E7eAXVBF6e+I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] clk: imx8mq: Make parent names arrays const pointers
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <1544801400-18951-4-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com> <1544801400-18951-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <154706054135.15366.13853192559274325540@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:02:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-14 07:30:11)
> The arrays containing the mux selectors need to be of const pointer
> to const char.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next


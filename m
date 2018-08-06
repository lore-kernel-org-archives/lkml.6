Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D325C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E65D20685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E65D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbeHGAA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:00:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45742 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbeHGAA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:00:57 -0400
Received: from ip5f5a8513.dynamic.kabel-deutschland.de ([95.90.133.19] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fmnNw-0003H0-AE; Mon, 06 Aug 2018 23:49:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rockchip tree
Date:   Mon, 06 Aug 2018 23:49:50 +0200
Message-ID: <1644264.7NhfmVZyFD@phil>
In-Reply-To: <20180807072902.62d6b279@canb.auug.org.au>
References: <20180807072902.62d6b279@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am Montag, 6. August 2018, 23:29:16 CEST schrieb Stephen Rothwell:
> Hi Heiko,
> 
> Commit
> 
>   508fc689cfe5 ("clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399")
> 
> is missing a Signed-off-by from its committer.

thanks for noticing this mistake. I've fixed the commit to add the
missing Signed-off-by ... I blame the heat of the last weeks ;-)


Thanks
Heiko




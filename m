Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A073F21836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545027427;
	bh=SQEacMbIpdQgq3IAWpihIN3mPnxozMxpmYjnQ46vABo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgWLfkYlptd9KaTXPo3JK2HwfJVaPHpb0uQ71jdUrXARRioWrA/gLvIIAgpsWkcSY
	 oEVeoYoFIx5jZFBmu4u75zgWSUYirjXbbZh3PCQzGjwcptXPfCsyZ8AtIWsdXwLLTs
	 jKavb49XmF9DMRmMrTry3mZ8lIXjBtY45TkYUqvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeLQGRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQGRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:17:05 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBAF2084A;
        Mon, 17 Dec 2018 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545027425;
        bh=SQEacMbIpdQgq3IAWpihIN3mPnxozMxpmYjnQ46vABo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emp+pC0oN2+r9PuqVPvwOyv+OMAq31bCtzHxmHQRjqQJVjmC5miJ9bgl5jsF4gmZq
         JYn2nKHXIWMRADkCPOHRrVvHGE4gwGT6aYZUiSWtnJ6yO5/23YRK2YAYwJBu8izzDl
         /Iq2cm4KMzrvNLny7yqFjnFob2/NxaFwuatPc4TQ=
Date:   Mon, 17 Dec 2018 11:46:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, Wen He <wen.he_1@nxp.com>,
        Jiaheng Fan <jiaheng.fan@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-qdma: add MODULE_LICENSE
Message-ID: <20181217061657.GF2472@vkoul-mobl>
References: <20181210205520.2956776-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210205520.2956776-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-18, 21:55, Arnd Bergmann wrote:
> The newly added driver lacks a MODULE_LICENSE tag, which now produces
> a warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-qdma.o
> 
> Add the license according to the SPDX specifier.

Applied, thanks

-- 
~Vinod

Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249AC20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRu9ulnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249AC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeICPub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeICPub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:50:31 -0400
Received: from localhost (unknown [106.200.199.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3251420867;
        Mon,  3 Sep 2018 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535974247;
        bh=x9Xd8wylwcgQa7zfwiVNn6Mogl+2gsU3ApJiJyC2xps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRu9ulntbPDe4+jJqwVD5IPNUV49tvyLIolor4yKv6FyZBmQ/aPSW3JHtt31F79GP
         iRDBBdGjFfVYIKVN4y5dSNe5ojL8HKUHojlB4VPbWUx0fOFQWFo+WvVLVpwV8Wkr2a
         H2+Y1i8uGPGa10+ycbYPfoPBLduDD+blq8Tf+E4A=
Date:   Mon, 3 Sep 2018 17:00:38 +0530
From:   Vinod <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@spreadtrum.com,
        broonie@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] dmaengine: sprd: Support DMA link-list mode
Message-ID: <20180903113038.GI2322@vkoul-mobl>
References: <6ce34813e7b3eb25390c6854ee1bc6b618075f20.1535454372.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce34813e7b3eb25390c6854ee1bc6b618075f20.1535454372.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-18, 19:09, Baolin Wang wrote:
> From: Eric Long <eric.long@spreadtrum.com>
> 
> The Spreadtrum DMA can support the link-list transaction mode, which means
> DMA controller can do transaction one by one automatically once we linked
> these transaction by link-list register.

Applied, thanks

-- 
~Vinod

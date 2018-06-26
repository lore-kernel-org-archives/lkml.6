Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA5C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E053A2644F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E053A2644F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbeFZCh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:37:28 -0400
Received: from sauhun.de ([88.99.104.3]:48818 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754175AbeFZCh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:37:27 -0400
Received: from localhost (unknown [91.73.131.157])
        by pokefinder.org (Postfix) with ESMTPSA id D19D456A487;
        Tue, 26 Jun 2018 04:37:25 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:37:24 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: smbus: kill memory leak on emulated and failed DMA
 SMBus xfers
Message-ID: <20180626023723.dwsr2b4tdsi6duax@ninjato>
References: <20180620094323.8447-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620094323.8447-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:43:23AM +0200, Peter Rosin wrote:
> If DMA safe memory was allocated, but the subsequent I2C transfer
> fails the memory is leaked. Plug this leak.
> 
> Fixes: 8a77821e74d6 ("i2c: smbus: use DMA safe buffers for emulated SMBus transactions")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


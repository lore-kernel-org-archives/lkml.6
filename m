Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AE4208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AE4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbeHASdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:33:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390188AbeHASdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:33:02 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF242108A9056;
        Wed,  1 Aug 2018 09:46:26 -0700 (PDT)
Date:   Wed, 01 Aug 2018 09:46:24 -0700 (PDT)
Message-Id: <20180801.094624.1369542003568924077.davem@davemloft.net>
To:     ioana.ciornei@nxp.com
Cc:     corbet@lwn.net, laurentiu.tudor@nxp.com, stuyoder@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: dpaa2: Use correct heading adornment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180731154553.3648-1-ioana.ciornei@nxp.com>
References: <20180731154553.3648-1-ioana.ciornei@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 09:46:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Tue, 31 Jul 2018 10:45:53 -0500

> Add overline heading adornment to document title in order to comply
> with kernel doc requirements.
> 
> Fixes: 60b9131 staging: fsl-mc: Convert documentation to rst format
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Applied, thanks.

Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C5D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C5D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeGRHFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:05:51 -0400
Received: from nautica.notk.org ([91.121.71.147]:37462 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRHFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:05:51 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 80515C009; Wed, 18 Jul 2018 08:29:35 +0200 (CEST)
Date:   Wed, 18 Jul 2018 08:29:20 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v9fs] Pull request for linux-next
Message-ID: <20180718062920.GA7302@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to request that you add the following tree to linux-next:

  git://github.com/martinetd/linux 9p-next

9p has seen some renewal of interest recently and I'd like to help take
a bit of the burden off Andrew, who suggested getting this included in
linux-next here[1].

This branch contains 9p filesystem & network patches that I have
gathered recently after they have been reviewed, and will keep pushing
patches there.


I've tried to respect the rules I've found, but please tell me if I
missed anything:
 - all patches have the author's Signed-off-by tag,
 - been posted to the v9fs and linux-kernel lists,
 - have been reviewed,
 - have been tested (*cough* a bit, I need to improve the process),
 - and are destined to the 4.19 merge window


[1] https://sourceforge.net/p/v9fs/mailman/message/36370423/

Thanks,
-- 
Dominique Martinet

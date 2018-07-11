Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B092CC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0F20C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0F20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390827AbeGKXn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:43:57 -0400
Received: from nautica.notk.org ([91.121.71.147]:48147 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbeGKXn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:43:57 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0B4FDC009; Thu, 12 Jul 2018 01:37:15 +0200 (CEST)
Date:   Thu, 12 Jul 2018 01:37:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] 9p: Use IDRs more effectively
Message-ID: <20180711233659.GA5684@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711210225.19730-1-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wed, Jul 11, 2018:
> The 9p code doesn't take advantage of the IDR's ability to store
> a pointer.  We can actually get rid of the p9_idpool abstraction
> and the multi-dimensional array of requests.
> 
> v2: Address feedback from Dominique.

Thanks, I've picked them up for 4.19
 ( git://github.com/martinetd/linux 9p-next as per mail on
 v9fs-developer list, "Current 9P patches - test branch")

This shouldn't stop anyone else from doing more reviews/test, I'm doing
this 9p-patch-gathering on no autority and I've only checked very basic
things for now.

-- 
Dominique Martinet

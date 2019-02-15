Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CEA21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfBOT7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:59:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:59:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0D0914F08CC4;
        Fri, 15 Feb 2019 11:59:01 -0800 (PST)
Date:   Fri, 15 Feb 2019 11:58:59 -0800 (PST)
Message-Id: <20190215.115859.1771867883703859279.davem@davemloft.net>
To:     alexander.duyck@gmail.com
Cc:     jannh@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAKgT0UeOGPQO0viM0w3JD71357uj7uuZ+wX2tCUTP6u_ZQG78Q@mail.gmail.com>
References: <20190214.142100.1155290437338631379.davem@davemloft.net>
        <CAG48ez0bFsKPBubARtjs+NQmRiUAbPEGbNjXPJaceuDa9Dd7OA@mail.gmail.com>
        <CAKgT0UeOGPQO0viM0w3JD71357uj7uuZ+wX2tCUTP6u_ZQG78Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Feb 2019 11:59:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 Feb 2019 10:35:18 -0800

> I'll take care of it. I'm kind of annoyed that you resubmitted this to
> netdev before anyone had a chance to even provide review comments
> though.

He was only following instructions from Andrew Morton.

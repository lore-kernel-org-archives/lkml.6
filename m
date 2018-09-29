Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86499C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555B120882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555B120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeI2RDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:03:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2RDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:03:53 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE6B7D6B;
        Sat, 29 Sep 2018 10:35:57 +0000 (UTC)
Date:   Sat, 29 Sep 2018 03:35:56 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] dma mapping fix for 4.19-rc6
Message-ID: <20180929103556.GA19120@kroah.com>
References: <20180929005447.GA3397@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929005447.GA3397@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:54:47PM -0700, Christoph Hellwig wrote:
> The following changes since commit bfb0e9b490bc15f243009359745a9d8a94089dc4:
> 
>   Merge tag 'usb-4.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-09-25 17:54:55 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.19-3

Now pulled, thanks.

greg k-h

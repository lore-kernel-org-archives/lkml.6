Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96BC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF32083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AF32083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIBBxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:53:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeIBBxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:53:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6A1F9F0;
        Sat,  1 Sep 2018 21:40:32 +0000 (UTC)
Date:   Sat, 1 Sep 2018 14:38:02 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Greg Hackmann <ghackmann@google.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE}
 use-after-free
Message-ID: <20180901213802.GA9143@kroah.com>
References: <20180831202250.GB30176@kroah.com>
 <20180831202738.78559-1-ghackmann@google.com>
 <4717fe98-b0af-ea32-b5bb-27d527ad8fe0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4717fe98-b0af-ea32-b5bb-27d527ad8fe0@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:30:01PM -0700, Greg Hackmann wrote:
> On 08/31/2018 01:27 PM, Greg Hackmann wrote:
> > Change-Id: Ia0542dd8134e81cd5e1412e126545303c766f738
> 
> Sorry, please disregard the Change-Id line.  This is what I get for
> forgetting to re-run checkpatch after amending my commit message.  :/

Can you please resend with that fixed up.  Having to hand-edit patches
on my end is a royal pain...

thanks,

greg k-h

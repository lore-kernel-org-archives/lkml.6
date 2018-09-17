Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A476ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA8A214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA8A214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIQOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:14:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeIQOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:14:40 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1202AD2;
        Mon, 17 Sep 2018 08:48:14 +0000 (UTC)
Date:   Mon, 17 Sep 2018 10:48:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     georgi.djakov@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
Message-ID: <20180917084812.GB21981@kroah.com>
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com>
 <5B9F4683.7010706@huawei.com>
 <20180917065428.GB26155@kroah.com>
 <5B9F54AF.7010208@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B9F54AF.7010208@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 03:15:59PM +0800, zhong jiang wrote:
> On 2018/9/17 14:54, Greg KH wrote:
> > On Mon, Sep 17, 2018 at 02:15:31PM +0800, zhong jiang wrote:
> >> On 2018/9/16 22:31, zhong jiang wrote:
> >>> Fix the following compile warning:
> >> +to  Andrew and Greg
> >>
> > +me for what?  Nothing is here :(
> The drivers/interconnect/core.c is not updated since 2017. I think the maintainer
>  is busy with other things.  Therefore,  I hope that you or Andrew and pick up the
> patch. :-)  . if you can not do this.  I am sorry for disturbing you.

I can do that, but again, I do not see any patch here in this email at
all, sorry.

greg k-h

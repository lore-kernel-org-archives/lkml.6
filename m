Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE65CECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6536220883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6536220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIQMUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:20:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeIQMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:20:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E9E7516;
        Mon, 17 Sep 2018 06:54:30 +0000 (UTC)
Date:   Mon, 17 Sep 2018 08:54:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     georgi.djakov@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
Message-ID: <20180917065428.GB26155@kroah.com>
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com>
 <5B9F4683.7010706@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B9F4683.7010706@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:15:31PM +0800, zhong jiang wrote:
> On 2018/9/16 22:31, zhong jiang wrote:
> > Fix the following compile warning:
> +to  Andrew and Greg
> 

+me for what?  Nothing is here :(

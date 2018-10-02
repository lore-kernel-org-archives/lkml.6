Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0123CC64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40FC2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40FC2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJCDWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:22:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:22:51 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78896CCE;
        Tue,  2 Oct 2018 20:37:41 +0000 (UTC)
Date:   Tue, 2 Oct 2018 13:37:40 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZKx5ZCb?= <hangdianqj@163.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Barry song <21cnbao@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Re: [PATCH] tty:serial:imx: use spin_lock instead of
 spin_lock_irqsave in isr
Message-ID: <20181002203740.GB2397@kroah.com>
References: <20180827144904.17226-1-hangdianqj@163.com>
 <20181001085212.wu7eba4eh7koy5jx@pengutronix.de>
 <5205c4b4.20a1.166326bb238.Coremail.hangdianqj@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5205c4b4.20a1.166326bb238.Coremail.hangdianqj@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 09:36:50AM +0800, 钱君 wrote:
> 
> 
> I have changed the description content, please refer to the patch file, thanks a lot

I can not apply patches from attachments like this, please resend it
properly and I will be glad to review it.

thanks,

greg k-h

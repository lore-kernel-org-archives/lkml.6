Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1FC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37DF20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37DF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeG1QTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:19:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeG1QTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:19:40 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48A11C75;
        Sat, 28 Jul 2018 14:52:52 +0000 (UTC)
Date:   Sat, 28 Jul 2018 16:52:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     Todd Kjos <tkjos@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: goldfish: Retire pdev_bus
Message-ID: <20180728145246.GC12252@kroah.com>
References: <20180719230633.243666-1-rkir@google.com>
 <CAOGAQerLXMqLOvEat_vTQYPJkO-g4UkbbhYwLpoVeNpxYE4qyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQerLXMqLOvEat_vTQYPJkO-g4UkbbhYwLpoVeNpxYE4qyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:56:12PM -0700, Roman Kiryanov wrote:
> Hi Greg,
> 
> the get_maintainer script gave only the mailing list. Do you happen to
> know if I need to mail my change somewhere else?

Yeah, I can take them through my char/misc tree, please resend them so I
can take them.

thanks,

greg k-h

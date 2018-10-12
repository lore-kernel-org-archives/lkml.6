Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE6E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3mxTJm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeJLSXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJLSXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:23:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0645120868;
        Fri, 12 Oct 2018 10:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539341515;
        bh=yrGpgoKZc3GC2wCHcm7dD21NvoZqUA7y87dzC2wXJ1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3mxTJm5czQ4ugLUHhkN1lmf2UOjIEPxN0Ps5bY3B4r72mRaQA7QWyq3iShzUmZWr
         +qrr1yILk+Y3sqhwhW3GohQgH+L8lRdvRhrHezGJjsKgFUjxmMLD1IltqwYyYKF7al
         ibtL2i1F+FENWGJ2rBSkXWox6yPcAcvRtVBqcaGY=
Date:   Fri, 12 Oct 2018 12:51:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [git pull] Input updates for v4.19-rc7
Message-ID: <20181012105152.GB19643@kroah.com>
References: <20181011235736.GA68543@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011235736.GA68543@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 04:57:36PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem:
> 
> - we added a few scheduling points into various input interfaces to
>   ensure that large writes will not cause RCU stalls
> 
> - fixed configuring PS/2 keyboards as wakeup devices on newer platforms

That feels like a really "late" contribution, I hope it goes well :)

Now merged, thanks.

greg k-h

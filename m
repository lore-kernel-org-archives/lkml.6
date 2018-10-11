Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790AC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E259D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdQZ374J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E259D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJLBNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeJLBNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:13:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFE42098A;
        Thu, 11 Oct 2018 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539279910;
        bh=PD3LMQkBMPzCAAPVvHU9cDZVHy0PLKZpzdYz42IZ1hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdQZ374J7WeNOffn5qir52G0qQH8p9R56CAD4q7lXPEJbqMqWuM297RrozXv0cRLj
         A6mZ/WSsQMl4MU+SfLQXYq/nprs/Rg93tkDjLgrQ8UoAyqW3/XTXeo2zIehSh+MS9d
         99CHXfYAHG0lt1QQVN2D3uE0Sj1yxvpg4FvdtTO4=
Date:   Thu, 11 Oct 2018 19:45:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] cgroup fixes for v4.19-rc7
Message-ID: <20181011174508.GB23310@kroah.com>
References: <20181011155915.GP270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011155915.GP270328@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:59:15AM -0700, Tejun Heo wrote:
> Hello, Greg.
> 
> One cgroup2 threaded mode fix for v4.19-rc7.  While threaded mode
> isn't used widely (yet) and the bug requires somewhat convoluted
> sequence of operations, it causes a userland visible malfunction -
> EINVAL on a valid attempt to enable threaded mode.  This pull request
> contains the fix.
> 
> Thanks.
> 
> The following changes since commit ac0657edb13ac7971569aa88cc6f27ea26deb883:
> 
>   Merge branch 'fixes' of git://git.armlinux.org.uk/~rmk/linux-arm (2018-10-04 09:48:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.19-fixes

Now merged, thanks.

greg k-h

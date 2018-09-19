Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4045CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDED12098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDED12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbeISLRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:17:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeISLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:17:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27C67B78;
        Wed, 19 Sep 2018 05:41:07 +0000 (UTC)
Date:   Wed, 19 Sep 2018 07:41:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Darren Hart <dvhart@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.19-2
Message-ID: <20180919054105.GA9185@kroah.com>
References: <20180918223852.GA10584@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918223852.GA10584@wrath>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:38:52PM -0700, Darren Hart wrote:
> Hi Linus and Greg,
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.19-2
> 
> for you to fetch changes up to ff0e9f26288d2daee4950f42b37a3d3d30d36ec1:
> 
>   platform/x86: alienware-wmi: Correct a memory leak (2018-09-10 13:45:43 -0700)

Now pulled, thanks.

greg k-h

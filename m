Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0182064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0182064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJBXXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:23:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeJBXXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:23:12 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC0B8194B;
        Tue,  2 Oct 2018 16:38:57 +0000 (UTC)
Date:   Tue, 2 Oct 2018 09:38:50 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [GIT PULL] SoundWire updates for 4.20-rc1
Message-ID: <20181002163850.GA11549@kroah.com>
References: <20181002142327.GA19792@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002142327.GA19792@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 07:53:27PM +0530, Vinod wrote:
> Hey Greg,
> 
> Here are the SoundWire updates (again) for 4.20-rc1/5.0-rc1
> This brings in the multi-link streaming support and rst format
> corrections. The changes are in linux-next for quite some time.
> 
> Please consider pull to receive:
> 
> The following changes since commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:
> 
>   soundwire: Fix acquiring bus lock twice during master release (2018-08-27 09:49:48 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-4.20-rc1

Now pulled, thanks.

greg k-h

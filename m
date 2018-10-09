Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29495C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EEA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q73nQlTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EEA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeJIO35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:29:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02867214C4;
        Tue,  9 Oct 2018 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539069267;
        bh=k/BKH3JtX9HJdJmMosvmJUx+nJhBt0N3ma4mBZ9CaIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q73nQlTAhZQ9xfAX0ovgV4B3QwXWyeJS7ChuSTf1kkW0Y23YH/z7+jFPCOhIYRxzC
         CMiyRcBmS47Coht6VEC280qYw+eysJr04tVyhium7mZPXWxoVszRxkq47+2gOpF2tP
         6pm1SV4riCCEnoPTCfNCM5TWpi+jtr5/XUird8hU=
Date:   Tue, 9 Oct 2018 09:14:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shuah@kernel.org
Subject: Re: Linux 4.19-rc7
Message-ID: <20181009071425.GD8617@kroah.com>
References: <20181007154529.GA4493@kroah.com>
 <CAKocOOOY7tmTt1JVv2NuF_KxGKj43MsEnEt9bH2P0EzQh7f++A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKocOOOY7tmTt1JVv2NuF_KxGKj43MsEnEt9bH2P0EzQh7f++A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:43:05PM -0600, Shuah Khan wrote:
> On Sun, Oct 7, 2018 at 9:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Hi all,
> >
> > Yet again, it's time for a kernel -rc release.  This one is bigger than
> > -rc6 was, for a variety of unrelated reasons it seems.  Lots of
> > different trees being merged this week, much more so than the previous
> > one.  Highlights include two sets of networking fixes, lots of different
> > driver subsystem fixes, arm and arm64 and x86 and riscv and powerpc64
> > fixes, as well as scheduler, iommu, and vfs fixes.  Not a huge quantity
> > overall, just overall a lot of different things.
> >
> > Given the current rate of change, and looking at the travel/conference
> > schedule happening this month, it seems like we will be having a -rc8
> > just to be sure 4.19 is solid as well as not having to be in the middle
> > of a merge window during a conference week.  Please go test and make
> > sure any remaining problems are sent in in time.
> >
> > thanks,
> >
> > greg k-h
> >
> Compiled and booted on my test system. I haven't seen any new issues compared
> to 4.19-rc6

Great!

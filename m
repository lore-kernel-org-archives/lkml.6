Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD34C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28023205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28023205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH3JDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:03:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeH3JDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A0BADFFD;
        Thu, 30 Aug 2018 05:02:51 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03156A9F09;
        Thu, 30 Aug 2018 05:02:48 +0000 (UTC)
Date:   Thu, 30 Aug 2018 13:02:44 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Intel Wireless 8265/8275 (rev 78) issue
Message-ID: <20180830050244.GA2307@dhcp-128-65.nay.redhat.com>
References: <20180829065442.GA3488@dhcp-128-65.nay.redhat.com>
 <87bm9ltd0z.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm9ltd0z.fsf@purkki.adurom.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 05:02:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 05:02:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/18 at 06:20pm, Kalle Valo wrote:
> Dave Young <dyoung@redhat.com> writes:
> 
> > Not sure if this is a known issue, I'm seeing this with latest mainline
> > kernel on Fedora rawhide.
> >
> > The wireless networking is not stable, I can not access network any more after
> > downloading some big files or just browsing some web pages about some
> > time.  I do not see this when I work in office.  So this maybe relate to
> > wireless router.
> >
> > "Can not access network" means ping timeout, can not open web pages etc.
> > But the wireless connection looks normal at least from the
> > NetworkManager icon it is still connected.
> >
> > The router I used at home is an old ASUS WL520gc.  I can confirm I can
> > reproduce this with another ASUA router WL-500gP v2 
> >
> > My laptop model is Thinkpad T480s.  It is painful I can only use
> > wireless,  any hints how to make it work will be appreciated!
> 
> Not everyone use Fedora so providing info which kernel versions work and
> which don't would help. Does Fedora usually add their own patches/hacks
> to kernel or is it a stock release from kernel.org? Also have you
> verified that this isn't a problem in user space, for example by
> downgrading the kernel to an older version?

I sometimes use self-built upstream kernel, sometimes use Fedora
kernels, none of them works well.  Since I got this new laptop about
less two months, this issue happens from the very beginning, not sure if
there's any old release works for me.

Thanks
Dave

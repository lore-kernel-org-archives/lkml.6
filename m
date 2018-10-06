Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1DC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61BC21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61BC21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJFQ3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 12:29:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeJFQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 12:29:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 180CC6766;
        Sat,  6 Oct 2018 09:26:59 +0000 (UTC)
Date:   Sat, 6 Oct 2018 02:26:56 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20181006092656.GA18832@kroah.com>
References: <20181005.222027.1089846249951010801.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005.222027.1089846249951010801.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:20:27PM -0700, David Miller wrote:
> 
> I know this is really soon after the previous net pull request, but I want
> to get this in for the BPF 32-bit right shift truncation fix.
> 
> 1) Fix truncation of 32-bit right shift in bpf, from Jann Horn.
> 
> 2) Fix memory leak in wireless wext compat, from Stefan Seyfried.
> 
> 3) Use after free in cfg80211's reg_process_hint(), from Yu Zhao.
> 
> 4) Need to cancel pending work when unbinding in smsc75xx otherwise
>    we oops, also from Yu Zhao.
> 
> 5) Don't allow enslaving a team device to itself, from Ido Schimmel.
> 
> 6) Fix backwards compat with older userspace for rtnetlink FDB dumps.
>    From Mauricio Faria.
> 
> 7) Add validation of tc policy netlink attributes, from David Ahern.
> 
> 8) Fix RCU locking in rawv6_send_hdrinc(), from Wei Wang.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit cec4de302c5ff2c5eb3bfcb0c4845a095f5149b9:
> 
>   Merge gitolite.kernel.org:/pub/scm/linux/kernel/git/davem/net (2018-10-03 16:09:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

Now merged, thanks.

greg k-h

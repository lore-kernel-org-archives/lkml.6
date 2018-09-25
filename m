Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E66208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E66208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeIYRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:37:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbeIYRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:37:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D24BE10EC;
        Tue, 25 Sep 2018 11:30:28 +0000 (UTC)
Date:   Tue, 25 Sep 2018 13:30:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Keys: fix C++ reserved word issue
Message-ID: <20180925113026.GA1696@kroah.com>
References: <20180925094147.GC21972@kroah.com>
 <alpine.LRH.2.21.1809250738020.27047@namei.org>
 <31929.1537870620@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31929.1537870620@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:17:00AM +0100, David Howells wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > I'll wait a few days on this one...
> 
> Can you at least apply the reversion patch?  UAPI is currently broken by the
> change that needs reverting.

Yes, as that's obviously correct.  I think you should wait for your
patch 2 here until 4.20-rc1, as this isn't a "fix" that is required at
this point in time.

I'll just go cherry-pick that one patch, thanks.

greg k-h

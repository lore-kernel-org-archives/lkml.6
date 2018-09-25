Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B83AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C758A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C758A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeIZAQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:16:26 -0400
Received: from namei.org ([65.99.196.166]:32980 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIZAQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:16:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w8PI7djK030229;
        Tue, 25 Sep 2018 18:07:39 GMT
Date:   Wed, 26 Sep 2018 04:07:39 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Keys: fix C++ reserved word issue
In-Reply-To: <20180925113026.GA1696@kroah.com>
Message-ID: <alpine.LRH.2.21.1809260407160.29804@namei.org>
References: <20180925094147.GC21972@kroah.com> <alpine.LRH.2.21.1809250738020.27047@namei.org> <31929.1537870620@warthog.procyon.org.uk> <20180925113026.GA1696@kroah.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Greg KH wrote:

> On Tue, Sep 25, 2018 at 11:17:00AM +0100, David Howells wrote:
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > I'll wait a few days on this one...
> > 
> > Can you at least apply the reversion patch?  UAPI is currently broken by the
> > change that needs reverting.
> 
> Yes, as that's obviously correct.  I think you should wait for your
> patch 2 here until 4.20-rc1, as this isn't a "fix" that is required at
> this point in time.

Ok, I'll queue this for the merge window.


-- 
James Morris
<jmorris@namei.org>


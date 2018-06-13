Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AB51C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25E208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25E208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935847AbeFMPHJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:07:09 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45434 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935190AbeFMPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:07:07 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 6BBFD40F1C;
        Wed, 13 Jun 2018 17:07:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id kkCdIfa7gE1Y; Wed, 13 Jun 2018 17:07:04 +0200 (CEST)
Date:   Wed, 13 Jun 2018 17:07:02 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        linux-api@vger.kernel.org, ebiederm@xmission.com,
        seth.forshee@canonical.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/6 v1 resend] statfs: handle mount propagation
Message-ID: <20180613150702.GA5403@mailbox.org>
References: <20180525124825.23875-1-christian@brauner.io>
 <20180613140625.GA31082@mailbox.org>
 <20180613142454.GA1845@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613142454.GA1845@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:24:54PM +0200, Greg KH wrote:
> On Wed, Jun 13, 2018 at 04:06:25PM +0200, Christian Brauner wrote:
> > On Fri, May 25, 2018 at 02:48:19PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Hey,
> > > 
> > > This is v1 of this patchset. All changes from v0 to v1 are non-functional.
> > > Specifically, the commit messages and justification have been extended as
> > > requested by Linus and Al.
> > 
> > Hey everyone,
> > 
> > Just a ping whether the requested changes have made this series suitable
> > for inclusion. Would be excellent if someone could do another review. :)
> 
> It's the middle of the merge window, no new code gets accepted right
> now, so just wait until next week at the _earliest_ before worrying

Ok, sorry. It was just that this was sent out before well over a month
ago and I was just worried that it had been overlooked.

Thanks!
Christian

> about someone reviewing this.
> 
> thanks,
> 
> greg k-h

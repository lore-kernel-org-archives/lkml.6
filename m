Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C0D5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D78208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Rrt1gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D78208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935804AbeFMOZT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935560AbeFMOZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:25:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4257C208AF;
        Wed, 13 Jun 2018 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528899917;
        bh=lBIXBHmr+u7W965idY+/GMhN/3o8zy0gGrIyRaGPmEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1Rrt1gbZeWS6ZkBKo91wt8vaDo3Ylc0R8j65w/R1Z6LstE1zc8XFYjtOX6sL9djO
         hsKVMM3Nfi1jVWAzCXVe22KoWrntVMLnBKj7z8yEhZEtGz81y7IcOLdf7agqm9Qygf
         6rbZlN7ExcQ2frX4G52lTU+KCD2rkOKKjQI+qrLA=
Date:   Wed, 13 Jun 2018 16:24:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        linux-api@vger.kernel.org, ebiederm@xmission.com,
        seth.forshee@canonical.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/6 v1 resend] statfs: handle mount propagation
Message-ID: <20180613142454.GA1845@kroah.com>
References: <20180525124825.23875-1-christian@brauner.io>
 <20180613140625.GA31082@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613140625.GA31082@mailbox.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:06:25PM +0200, Christian Brauner wrote:
> On Fri, May 25, 2018 at 02:48:19PM +0200, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Hey,
> > 
> > This is v1 of this patchset. All changes from v0 to v1 are non-functional.
> > Specifically, the commit messages and justification have been extended as
> > requested by Linus and Al.
> 
> Hey everyone,
> 
> Just a ping whether the requested changes have made this series suitable
> for inclusion. Would be excellent if someone could do another review. :)

It's the middle of the merge window, no new code gets accepted right
now, so just wait until next week at the _earliest_ before worrying
about someone reviewing this.

thanks,

greg k-h

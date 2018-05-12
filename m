Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeELHO0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 03:14:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeELHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 03:14:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52EC760618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        0-Day Mailing List <lkp@lists.01.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: a new pending-fixes branch
References: <20180512143523.250ab803@canb.auug.org.au>
Date: Sat, 12 May 2018 10:14:19 +0300
In-Reply-To: <20180512143523.250ab803@canb.auug.org.au> (Stephen Rothwell's
        message of "Sat, 12 May 2018 14:35:23 +1000")
Message-ID: <87603t1h2s.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> As an outcome of some discussion, I have added a pending-fixes branch
> to linux-next.  This branch contains Linus' tree merged with branches
> containing only fixes pending for the current release.  The branch is a
> strict subset of linux-next each day (as so rebases like linux-next
> does).
>
> It would be good if this branch could be tested by the 0-Day service
> and any other testing that people do - in the hope of sending fewer
> "fixes causing bugs" patches to Linus.
>
> There is not intention that bug fixes for Linus' tree should
> necessarily be tested in linux-next before being forwarded, but
> (especially for slightly less urgent bugs, at least) it seems like a
> good idea.
>
> I currently have 55 branches of bug fixes included.

Is there a list of branches you use available somewhere? I would like to
check that wireless-drivers is included.

-- 
Kalle Valo

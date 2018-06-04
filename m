Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFDTHc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:07:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:07:31 -0400
Date: Mon, 4 Jun 2018 12:07:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: vdavydov.dev@gmail.com, shakeelb@google.com, viro@zeniv.linux.org.uk,
        hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v7 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
Message-Id: <20180604120702.ef69c28585fe925f9a55e130@linux-foundation.org>
In-Reply-To: <0e725889-c42f-0557-ef41-76e4c87a3c9b@virtuozzo.com>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
        <0e725889-c42f-0557-ef41-76e4c87a3c9b@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018 15:45:17 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Hi, Andrew!
> 
> This patchset is reviewed by Vladimir Davydov. I see, there is
> minor change in current linux-next.git, which makes the second
> patch to apply not completely clean.
> 
> Could you tell what should I do with this? Is this OK or should
> I rebase it on top of linux.next or do something else?

A resend against 4.18-rc1 would be ideal, thanks.

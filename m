Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeBEKat (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:30:49 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:38485 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBEKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:30:43 -0500
Date: Mon, 5 Feb 2018 11:30:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/rt: Make update_curr_rt() more accurate
Message-ID: <20180205103038.GI2249@hirez.programming.kicks-ass.net>
References: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 11:18:41AM +0800, Wen Yang wrote:
> rq->clock_task may be updated between the two calls of 
> rq_clock_task() in update_curr_rt(). Calling rq_clock_task() only
> once makes it more accurate and efficient, taking update_curr() as
> reference.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

Thanks!

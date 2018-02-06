Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeBFH0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:26:37 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33240 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:26:30 -0500
X-Google-Smtp-Source: AH8x2254PWSBqIQfJhQ3dGj0TsxmI4kCqXv9X6efUXh538hrF+qKoKaSYJ88RFuTs5Kf/pToQ1opjA==
Date: Tue, 6 Feb 2018 08:26:26 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/deadline: Make update_curr_dl() more accurate
Message-ID: <20180206072626.GZ19535@localhost.localdomain>
References: <1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/18 09:55, Wen Yang wrote:
> rq->clock_task may be updated between the two calls of
> rq_clock_task() in update_curr_dl(). Calling rq_clock_task() only
> once makes it more accurate and efficient, taking update_curr() as
> reference.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

- Juri

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDYHGn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:06:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYHGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:06:38 -0400
Date: Wed, 25 Apr 2018 09:06:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Li Bin <huawei.libin@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH] sched: fix typo in error message
Message-ID: <20180425070628.GY4043@hirez.programming.kicks-ass.net>
References: <1524634900-1861-1-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524634900-1861-1-git-send-email-huawei.libin@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Again.. if only people would use google, they'd find at least 3 other
people having tried this patch :/

On Wed, Apr 25, 2018 at 01:41:40PM +0800, Li Bin wrote:
> -			pr_err("BUG: arch topology borken\n");
> +			pr_err("BUG: arch topology broken\n");

Not a typo:

  https://www.urbandictionary.com/define.php?term=borken

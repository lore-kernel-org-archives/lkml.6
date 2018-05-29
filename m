Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeE2Kuc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:50:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeE2Kua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:50:30 -0400
Date: Tue, 29 May 2018 12:49:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 13/13] atomics/treewide: make test ops optional
Message-ID: <20180529104959.GA12180@hirez.programming.kicks-ass.net>
References: <20180523133533.1076-1-mark.rutland@arm.com>
 <20180523133533.1076-14-mark.rutland@arm.com>
 <20180529091047.kg3et36pxzwohhat@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529091047.kg3et36pxzwohhat@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:11:19AM +0100, Mark Rutland wrote:
> Peter, does your ack still stand if I fold in the below?

Yep, thanks for the cleanup.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeBSKoO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:44:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:44:12 -0500
Date: Mon, 19 Feb 2018 11:44:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: gaurav jindal <gauravjindal1104@gmail.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]sched: completion: use bool in try_wait_for_completion
Message-ID: <20180219104404.GQ25201@hirez.programming.kicks-ass.net>
References: <20180214103002.GA15068@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214103002.GA15068@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:00:02PM +0530, gaurav jindal wrote:
> Use bool in place of int in the function try_wait_for_completion.

I can see that from the patch; what you failed to describe is why you've
bothered to do the patch.

Which doesn't apply because of whitespace damage; please re-read the
documentation on how to send patches.

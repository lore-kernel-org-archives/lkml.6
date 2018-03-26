Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeCZIex (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:34:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeCZIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:34:50 -0400
Date: Mon, 26 Mar 2018 10:34:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/3] drivers/irqchip: update supports_deactivate static
 key to modern api
Message-ID: <20180326083443.GH4043@hirez.programming.kicks-ass.net>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325191056.24598-3-dave@stgolabs.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10:55PM -0700, Davidlohr Bueso wrote:
> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);

again...

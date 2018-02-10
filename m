Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBJONf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:13:35 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:35359 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:13:34 -0500
Date: Sat, 10 Feb 2018 15:13:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, ak@linux.intel.com,
        kan.liang@intel.com
Subject: Re: [RFC perf] perf: try schedule more hw events, even when previous
 groups failed
Message-ID: <20180210141330.GR25201@hirez.programming.kicks-ass.net>
References: <20180208235948.2222416-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208235948.2222416-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 03:59:48PM -0800, Song Liu wrote:
> Please share your comments and suggestions on this.

Like I said last time: No, we're not going to do this. Find that thread
if you want more detail.

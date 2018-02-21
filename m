Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965663AbeBUNpn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:45:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933649AbeBUNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:45:40 -0500
Date: Wed, 21 Feb 2018 14:45:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V4 1/5] perf/x86/intel: Fix event update for auto-reload
Message-ID: <20180221134535.GL25201@hirez.programming.kicks-ass.net>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
 <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
 <20180221103247.GL25181@hirez.programming.kicks-ass.net>
 <cac32cb6-e99a-2df7-e756-0498cf06598d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac32cb6-e99a-2df7-e756-0498cf06598d@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 08:43:47AM -0500, Liang, Kan wrote:
> Right, I forgot that the drain_pebs_core() also has auto_reload support.
> Sorry for that.
> I will re-send all patches.

No need, already collected the lot.

Thanks!

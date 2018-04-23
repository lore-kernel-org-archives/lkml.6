Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeDWBDt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48073 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753825AbeDWBDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:03:48 -0400
Date: Sun, 22 Apr 2018 19:03:44 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/7] Various Spectre-v1 fixes
Message-ID: <20180423010343.GG16083@dhcp22.suse.cz>
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420131407.721875616@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-04-18 15:14:07, Peter Zijlstra wrote:
> These fix a number of perf, x86 and sched cases where we have user controlled
> array dereferences.  All were found by Dan's recent Smatch update.

Do we want to mark all of these for stable?
-- 
Michal Hocko
SUSE Labs

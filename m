Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeBFVZP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:25:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33090 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbeBFVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:25:14 -0500
Date: Tue, 6 Feb 2018 22:25:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] Update blocked load
Message-ID: <20180206212507.GO2249@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 08:23:04PM +0100, Vincent Guittot wrote:
> This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
> 56eb46798b33 ("sched: Clean up nohz enter/exit")

So what will update the blocked load after we wake from a total idle?

I don't see anything here that would do that (yet?).

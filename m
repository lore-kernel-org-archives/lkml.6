Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeEaHsj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:48:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:48:35 -0400
Date: Thu, 31 May 2018 09:48:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: mingo@redhat.com, Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix missing clock update
Message-ID: <20180531074825.GE12180@hirez.programming.kicks-ass.net>
References: <20180530160809.9074-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530160809.9074-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 06:08:09PM +0200, Juri Lelli wrote:
> A missing clock update is causing the below warning:

Thanks!

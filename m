Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeC2Bon (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:44:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeC2Bom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:44:42 -0400
Date: Wed, 28 Mar 2018 18:32:24 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Message-ID: <20180329013224.tfryvl6lv5i72jwm@linux-n805>
References: <1522246852-17501-1-git-send-email-longman@redhat.com>
 <1522246852-17501-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1522246852-17501-2-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Waiman Long wrote:

>+config DEBUG_RWSEMS
>+	bool "RW Semaphore debugging: basic checks"
>+	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER

Why depend on RWSEM_SPIN_ON_OWNER? Doesn't everyone benefit from this?
For example, DEBUG_MUTEXES does not need it.

Thanks,
Davidlohr

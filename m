Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeC2POI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:59994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeC2POH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:14:07 -0400
Date: Thu, 29 Mar 2018 08:01:48 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Message-ID: <20180329150148.ydmsymzupgi5v7ql@linux-n805>
References: <1522246852-17501-1-git-send-email-longman@redhat.com>
 <1522246852-17501-2-git-send-email-longman@redhat.com>
 <20180329013224.tfryvl6lv5i72jwm@linux-n805>
 <1b8d58b1-faf3-f210-7356-9d67930a2efb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1b8d58b1-faf3-f210-7356-9d67930a2efb@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Waiman Long wrote:

>Because it checks the owner field which is present only if
>RWSEM_SPIN_ON_OWNER is defined. Mutex is different in the sense that the
>owner field is always there no matter if MUTEX_SPIN_ON_OWNER is set or not.

Ah right; that's after Peter's mutex rewrite iirc. No objections from me.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

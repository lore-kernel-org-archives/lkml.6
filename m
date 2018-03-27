Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeC0QHB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:07:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56547 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeC0QG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:06:59 -0400
Date: Tue, 27 Mar 2018 08:54:42 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Message-ID: <20180327155442.plqx3aohmjkhepvb@linux-n805>
References: <1522091848-18426-1-git-send-email-longman@redhat.com>
 <20180327060655.25zjgqlgbfsp6b3p@gmail.com>
 <72b8a73c-bfc0-5884-199d-349ee3311802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <72b8a73c-bfc0-5884-199d-349ee3311802@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Waiman Long wrote:
>I can add a patch to rework lock debugging configuration code. D

Please in the same patch, just a v3.

Thanks
Davidlohr

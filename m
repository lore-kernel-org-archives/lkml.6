Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeEORsz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:48:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752392AbeEORsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:48:53 -0400
Subject: Re: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-2-git-send-email-longman@redhat.com>
 <20180515174646.GK12217@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <92ec74fd-23d0-366c-d135-54be350b3efe@redhat.com>
Date: Tue, 15 May 2018 13:48:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515174646.GK12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 01:46 PM, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 01:38:03PM -0400, Waiman Long wrote:
>> +#define WSEM_ANONYMOUSLY_OWNED	((struct task_struct *)__RWSEM_ANONYMOUSLY_OWNED)
> typoed and unused..

Sorry about the typo. I know it is not used. I include it for
completeness purpose. I will remove it in the next version.

Cheers,
Longman

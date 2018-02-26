Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeBZEFM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:05:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752247AbeBZEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:05:09 -0500
Subject: Re: [PATCH v8 0/6] vfs: Use dlock list for SB's s_inodes list
To: Dave Chinner <david@fromorbit.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>, Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <1509475860-16139-1-git-send-email-longman@redhat.com>
 <20180226024701.GO7000@dastard>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4449fb7f-28de-62d2-2101-355096617e41@redhat.com>
Date: Sun, 25 Feb 2018 23:05:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180226024701.GO7000@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2018 09:47 PM, Dave Chinner wrote:
> Hi Waiman,
>
> What's happened to this patchset? Any plans to repost a more recent
> version?
>
> FYI, I just ran a workload that hit 60% CPU usage on sb inode list
> lock contention - a multithreaded bulkstat scan of an XFS filesystem
> with millions of inodes on SSDs. last time I ran this (about 18
> months ago now!) I saw rates of about 600,000 inodes/s being scanned
> from userspace. The run I did earlier today made 300,000 inodes/s on
> the same 16p machine and was completely CPU bound....
>
> Cheers,
>
> Dave.

I was planning to repost the patchset with the latest change last
November and then Meltdown/Spectre happened. I was drafted into
backporting fixes to RHEL6. Hopefully, I can finish up the work in early
March and work on my upstream patches again.

Cheers,
Longman

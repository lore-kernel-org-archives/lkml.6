Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeBMPuj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:50:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933440AbeBMPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:50:38 -0500
Date: Tue, 13 Feb 2018 07:50:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Export kthread_data()
Message-ID: <20180213155033.GA16684@infradead.org>
References: <1518187941-29275-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518187941-29275-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 09:52:21AM -0500, Waiman Long wrote:
> When multiple kernel threads are created to cooperatively work on
> a common task, we may need a convenient way to access data that are
> specific to each kthread.
> 
> The kthread_data() function fits this need.  However, it was not
> visible to kthreads started in a kernel module. To solve this problem,
> the kthread_data() function is now exported allowing kthreads from
> kernel modules to use it.

Please send this along wit hthe actual user of it.

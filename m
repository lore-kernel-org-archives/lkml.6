Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBWDQ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:16:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42042 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBWDQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:16:56 -0500
Date: Fri, 23 Feb 2018 03:16:54 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs/dcache: Avoid the try_lock loops in
 dentry_kill()
Message-ID: <20180223031654.GX30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-5-john.ogness@linutronix.de>
 <20180223022242.GV30522@ZenIV.linux.org.uk>
 <20180223031214.GW30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223031214.GW30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:12:14AM +0000, Al Viro wrote:

> 	/* retain_dentry() needs ->count == 1 already checked)

... obviously not even compile-tested ;-)

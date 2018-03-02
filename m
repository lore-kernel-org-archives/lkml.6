Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeCBXqH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:46:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935015AbeCBXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:46:06 -0500
Date: Fri, 2 Mar 2018 15:46:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] checkpatch: warn for use of %px
Message-Id: <20180302154604.c6c8cc14d06124f36de136d9@linux-foundation.org>
In-Reply-To: <1519700648-23108-1-git-send-email-me@tobin.cc>
References: <1519700648-23108-1-git-send-email-me@tobin.cc>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 14:04:04 +1100 "Tobin C. Harding" <me@tobin.cc> wrote:

> Hi Andrew,
> 
> This is a resurrection of a patch set from last December.  There was
> some confusion (on my behalf) as to how patches to checkpatch got into
> the mainline.  Are you willing (and able) to take patches to
> checkpatch.pl?
> 
> Patch 1 through 3 are cleanup/refactoring patches.
> 
> Patch 3 makes checkpatch emit a warning for usage of specifier %px.
> 
> You may remember that the initial idea for this was from yourself, v1
> requested permission to use 'Suggested-by' tag.  I didn't get comment on
> that so v2 removed the tag.  (I'm not totally across when one should add
> the 'Suggested-by' tag.)
> 
> v3 was an Epic fail, not testing final patch series before submission.
> 
> Joe, I removed your 'Acked-by' tag because the patch you originally
> acked is different after rebasing.  I kept the Co-Developed-by tag
> because the code you wrote is still there I just had to massage it a bit
> since the check for deprecated %p[Ff] has been added since we did v2.

I prefer not to include tags which aren't listed in
Documentation/process/submitting-patches.rst, but I now see that some
bright spark added Co-Developed-by: to
Documentation/process/5.Posting.rst, so the two files are a)
duplicative and b) out of sync.

Co-Developed-by is a little more specific than signed-off-by, but not
usefully so, I suggest...

Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053E7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DCD222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbfBKPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:39:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:46208 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbfBKPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:39:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A99F130D;
        Mon, 11 Feb 2019 15:39:13 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:39:11 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] Documentation: Fix grammatical error in
 sysctl/fs.txt & clarify negative dentry
Message-ID: <20190211083911.22f64578@lwn.net>
In-Reply-To: <1549570542-2471-1-git-send-email-longman@redhat.com>
References: <1549570542-2471-1-git-send-email-longman@redhat.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 15:15:42 -0500
Waiman Long <longman@redhat.com> wrote:

> Fix a grammatical error in the dentry-state text and clarify the usage
> of negative dentries.
> 
> Fixes: af0c9af1b3f66 ("fs/dcache: Track & report number of negative dentries")

Linus, perhaps you'd like to take this one directly?  It seems that the
above-reference comment went in directly, so I can't apply this fix now
without back-merging 5.0-rc5 or so...

Thanks,

jon

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/sysctl/fs.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
> index 58649bd..ebc679b 100644
> --- a/Documentation/sysctl/fs.txt
> +++ b/Documentation/sysctl/fs.txt
> @@ -80,7 +80,9 @@ nonzero when shrink_dcache_pages() has been called and the
>  dcache isn't pruned yet.
>  
>  nr_negative shows the number of unused dentries that are also
> -negative dentries which do not mapped to actual files.
> +negative dentries which do not map to any files. Instead,
> +they help speeding up rejection of non-existing files provided
> +by the users.
>  
>  ==============================================================
>  

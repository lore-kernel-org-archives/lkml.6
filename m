Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20382C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF4920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLFWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLFWPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:15:25 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791EB20868;
        Thu,  6 Dec 2018 22:15:24 +0000 (UTC)
Date:   Thu, 6 Dec 2018 17:15:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] Uprobes: Fix kernel oops with
 delayed_uprobe_remove()
Message-ID: <20181206171521.6bcc3622@vmware.local.home>
In-Reply-To: <20181206135457.d934354e6c1fb5ab4f5c81cc@linux-foundation.org>
References: <20181206124719.1fa76d92@vmware.local.home>
        <20181206135457.d934354e6c1fb5ab4f5c81cc@linux-foundation.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 13:54:57 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

	  
> >     Acked-by: Oleg Nesterov <oleg@redhat.com>
> >     Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> >     Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
> >     Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> >     Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >   
> 
> No cc:stable?

Fixes is still in this -rc release.

-- Steve

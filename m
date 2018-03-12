Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeCLWmt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:42:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:42:48 -0400
Date: Mon, 12 Mar 2018 15:42:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/6] proc/sysctl: Check for invalid flags bits
Message-Id: <20180312154245.a3b759d2542ac7e09a5a267a@linux-foundation.org>
In-Reply-To: <42c1606b-304e-8cd5-d532-68a403a99dce@redhat.com>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
        <1520885744-1546-3-git-send-email-longman@redhat.com>
        <20180312135204.d56f7f1e64c96cf20786eb28@linux-foundation.org>
        <42c1606b-304e-8cd5-d532-68a403a99dce@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 18:12:47 -0400 Waiman Long <longman@redhat.com> wrote:

> On 03/12/2018 04:52 PM, Andrew Morton wrote:
> > On Mon, 12 Mar 2018 16:15:40 -0400 Waiman Long <longman@redhat.com> wrote:
> >
> >> Checking code is added to check for invalid flags in the ctl_table
> >> and return error if an unknown flag is used.
> > Why?  What's wrong with the old code, what value does this change add,
> > etc.
> 
> This is an additional checking code requested by Luis.

Readers of this patch will wish to know why it exists.  That doesn't
tell us!

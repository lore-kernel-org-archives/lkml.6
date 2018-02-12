Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeBLRHG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:07:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbeBLRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:07:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19DF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Feb 2018 12:07:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tracing/fgraph: Missed irq return mark for leaf entry
Message-ID: <20180212120701.68407807@gandalf.local.home>
In-Reply-To: <20180211105135.6imp6wpawftfqd3f@intel.com>
References: <1517413729-20411-1-git-send-email-changbin.du@intel.com>
        <20180211105135.6imp6wpawftfqd3f@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2018 18:51:36 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> Hi Rostedt,
> What abount this fix? Thanks!
> 

Thanks for pointing this out, it was lost in my INBOX.

-- Steve

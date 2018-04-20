Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDTS30 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbeDTS3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:29:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1EA217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 14:29:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <songliubraving@fb.com>
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Message-ID: <20180420142922.08ad9e64@gandalf.local.home>
In-Reply-To: <20180420180847.418760-1-songliubraving@fb.com>
References: <20180420180847.418760-1-songliubraving@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 11:08:47 -0700
Song Liu <songliubraving@fb.com> wrote:

> For uprobes.c sisde, igrab() is not necessary. So we removed it and

You don't need to send another patch, but what is the above sentence
suppose to say?

-- Steve

> added comments on requirements to callers of uprobe_register().

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeCFWC7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeCFWC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:02:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Mar 2018 17:02:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: nuke clear_ftrace_function
Message-ID: <20180306170254.684be2fc@vmware.local.home>
In-Reply-To: <8096dab2-2efc-076d-4f5c-b6c9da6a0554@huawei.com>
References: <1517537689-34947-1-git-send-email-xieyisheng1@huawei.com>
        <8096dab2-2efc-076d-4f5c-b6c9da6a0554@huawei.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 19:30:28 +0800
Yisheng Xie <xieyisheng1@huawei.com> wrote:

> hi Steven and all,
> Ping, for month passed, do you have any comment about this patch?

Sorry you got me in the midst of traveling and other issues.

This patch looks fine, I'll queue it up. I'm currently working on some
code so I wont be pushing anything till it's all finished.

Thanks!

-- Steve

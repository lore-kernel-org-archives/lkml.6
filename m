Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966370AbeBNAqF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966220AbeBNAqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:46:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F051217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 14 Feb 2018 09:45:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] kprobes: improve error handling when
 arming/disarming kprobes
Message-Id: <20180214094551.7ef89492ae84806a0178c8ec@kernel.org>
In-Reply-To: <20180213172119.yurad3j3wyhapt74@gmail.com>
References: <20180109235124.30886-1-jeyu@kernel.org>
        <20180119160607.5ed19168be13d27cf7f94531@kernel.org>
        <1e95213f-1b57-00a4-46a3-70e9a9013994@redhat.com>
        <20180213172119.yurad3j3wyhapt74@gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 18:21:19 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
> > Was this patch ever picked up in the tip tree?  (Maybe I'm not looking
> > in the right branch?)
> 
> Sorry, had a bit of a backlog: I picked up the two fixes/improvements now, and 
> they will show up in tip:perf/urgent once they go through some local testing.
> 
> Thanks!

Thanks Ingo!

-- 
Masami Hiramatsu <mhiramat@kernel.org>

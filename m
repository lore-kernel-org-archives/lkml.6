Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA73601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeFFRUK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932977AbeFFRUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:20:09 -0400
Date: Wed, 6 Jun 2018 13:20:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add ppc support for kprobe args tests
Message-ID: <20180606132006.7bcd1d38@vmware.local.home>
In-Reply-To: <20180606203752.7768487691f4a85a56f82978@kernel.org>
References: <20180606093154.10408-1-naveen.n.rao@linux.vnet.ibm.com>
        <20180606203752.7768487691f4a85a56f82978@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shuah,

Can you take this in your tree?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Wed, 6 Jun 2018 20:37:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed,  6 Jun 2018 15:01:54 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Add powerpc support for the recently added kprobe args tests.  
> 
> Thank you for adding powerpc support!
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>

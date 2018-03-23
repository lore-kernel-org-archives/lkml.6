Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCWPO6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbeCWPO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:14:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019B92183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 11:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix a potential NULL dereference
Message-ID: <20180323111454.0fe97917@gandalf.local.home>
In-Reply-To: <1521811393.27781.2.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20180323113735.GC28518@mwanda>
        <1521811393.27781.2.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 08:23:13 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:


> Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Thanks for catching this!


Thanks Dan, applied.

-- Steve

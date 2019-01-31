Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31835218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAaReU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfAaReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:34:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C92D88E67;
        Thu, 31 Jan 2019 17:34:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8A5F5D9D6;
        Thu, 31 Jan 2019 17:34:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 31 Jan 2019 18:34:18 +0100 (CET)
Date:   Thu, 31 Jan 2019 18:34:14 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
Message-ID: <20190131173414.GA5402@redhat.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
 <20190116084452.773833d4@gandalf.local.home>
 <20190121125756.b06de37c0c52b1b882b3df67@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612BA4B9BCAD@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B9BCAD@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 31 Jan 2019 17:34:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31, Reshetova, Elena wrote:
>
>  > [ Cc'ing Masami as he maintains uprobes (we need to add uprobes to
> > >   the MAINTAINERS file ]
> >
> > Thanks Steve, I think it is maintained mainly by Srikar and Oleg.
> > Srikar, Oleg, could you update MAINTAINERS file to add UPROBES entry?
> > And ack this change?
>
> Srikar, Oleg, could you please take a look on the change, if possible, it is
> really a trivial one in this case.

this one https://lore.kernel.org/lkml/1547637627-29526-1-git-send-email-elena.reshetova@intel.com/
I guess...

Yes, looks obviously correct, feel free to add my ACK,

Oleg.


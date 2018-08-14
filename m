Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BEC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AE02174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AE02174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeHNCwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbeHNCwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:52:23 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3F320C01;
        Tue, 14 Aug 2018 00:07:46 +0000 (UTC)
Date:   Mon, 13 Aug 2018 20:07:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, oleg@redhat.com,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
Message-ID: <20180813200745.2d0d5bb3@gandalf.local.home>
In-Reply-To: <20180813085612.GE44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
        <20180813085612.GE44470@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 01:56:12 -0700
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:51]:
> 
> > Simplify uprobe_register() function body and let __uprobe_register()
> > handle everything. Also move dependency functions around to fix build
> > failures.
> >   
> 
> One nit:
> s/to fix build/failures/to avoid build failures/

I pulled in this patch with the above update to the change log.

> 
> 
> 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---  
> 
> 
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, I added your ack and Song's Reviewed-by tags.

-- Steve

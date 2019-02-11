Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD4218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBKU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfBKU2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:28:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2462218A4;
        Mon, 11 Feb 2019 20:28:43 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:28:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
Message-ID: <20190211152842.6a2a7794@gandalf.local.home>
In-Reply-To: <20190211152725.65d0ed18@gandalf.local.home>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
        <20190201172150.GA1853@linux.vnet.ibm.com>
        <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
        <CAGXu5jJdeQ5DOZj_nPkWWBn8y0fRg2UEUGhd_seHL=KmKJey2g@mail.gmail.com>
        <20190211152725.65d0ed18@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 15:27:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Feb 2019 12:21:32 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > > Looks good to me.
> > > >
> > > > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>    
> > >
> > > Thank you very much Srikar!
> > > Would you be able to take this patch to integration?    
> > 
> > Steve can you pick this up with Srikar's Reviewed-by?  
> 
> Yep. And I'll also add Oleg's acked-by. (Currently doing my "urgent"
> patches now).
> 

Or is this something that can wait till the next merge window?

-- Steve

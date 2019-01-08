Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C711C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064132183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfAHD0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfAHD0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:26:37 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2972173C;
        Tue,  8 Jan 2019 03:26:35 +0000 (UTC)
Date:   Mon, 7 Jan 2019 22:26:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 01/13] work-simple: drop a shit statement in
 SWORK_EVENT_PENDING
Message-ID: <20190107222634.381bfbd0@vmware.local.home>
In-Reply-To: <20190108030623.GA6619@jagdpanzerIV>
References: <20190107195252.599921907@goodmis.org>
        <20190107195331.608898679@goodmis.org>
        <20190108030623.GA6619@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 12:06:23 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (01/07/19 14:52), Steven Rostedt wrote:
> > Subject: [PATCH RT 01/13] work-simple: drop a shit statement in SWORK_EVENT_PENDING  
> 
> 						shift?

Yes. And I noticed this typo after I sent out the list. It appears that
Sebastian's keyboard has a faulty 'f' key, as he has made this typo
more than once.

-- Steve

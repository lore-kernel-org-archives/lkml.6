Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF4C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E48206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfAHJAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:00:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:00:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ggnFb-0004yk-2g; Tue, 08 Jan 2019 10:00:43 +0100
Date:   Tue, 8 Jan 2019 10:00:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 01/13] work-simple: drop a shit statement in
 SWORK_EVENT_PENDING
Message-ID: <20190108090042.x4bghetwa2vu2r3e@linutronix.de>
References: <20190107195252.599921907@goodmis.org>
 <20190107195331.608898679@goodmis.org>
 <20190108030623.GA6619@jagdpanzerIV>
 <20190107222634.381bfbd0@vmware.local.home>
 <20190108044719.GA19275@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190108044719.GA19275@jagdpanzerIV>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 13:47:19 [+0900], Sergey Senozhatsky wrote:
> On (01/07/19 22:26), Steven Rostedt wrote:
> > > On (01/07/19 14:52), Steven Rostedt wrote:
> > > > Subject: [PATCH RT 01/13] work-simple: drop a shit statement in SWORK_EVENT_PENDING  
> > > 
> > > 						shift?
> > 
> > Yes. And I noticed this typo after I sent out the list. It appears that
> > Sebastian's keyboard has a faulty 'f' key, as he has made this typo
> > more than once.
> 
> I think Sebastian can configure his emacs to interpret a long
> spacebar hold as 'f' key [0].

Thanks for the hint but Sebastian is a vim user. Might be a reason to
migrate.

> [0] https://imgs.xkcd.com/comics/workflow.png
> 
> 	-ss

Sebastian

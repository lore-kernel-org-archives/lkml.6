Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A358C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AA92192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395368AbfBOPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390784AbfBOPg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:36:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC5421924;
        Fri, 15 Feb 2019 15:36:27 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:36:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Message-ID: <20190215103626.61e7d466@gandalf.local.home>
In-Reply-To: <20190216000814.c76e09f4b7597e6892326524@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190216000814.c76e09f4b7597e6892326524@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2019 00:08:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Tom,
> 
> On Wed, 13 Feb 2019 17:42:55 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying that basic action combinations fail as
> > expected.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>  
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks Tom and Masami,

I'm currently in the process of testing these patches (I already
reviewed them, they look good), and will post to linux-next when the
tests are complete (if there's no issues found).

-- Steve

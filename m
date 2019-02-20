Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA432C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784DE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfBTSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBTSyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:54:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4C720859;
        Wed, 20 Feb 2019 18:54:13 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:54:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Message-ID: <20190220135412.52a244e7@gandalf.local.home>
In-Reply-To: <1550688315.2027.20.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190220121748.7aa83459@gandalf.local.home>
        <1550684302.2027.6.camel@kernel.org>
        <20190220125625.77802cac@gandalf.local.home>
        <1550686231.2027.14.camel@kernel.org>
        <20190220133316.587f3941@gandalf.local.home>
        <1550688315.2027.20.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 12:45:15 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > OK, so this has nothing to do with your patch set. I've tested
> > everything else, and I'm ready to finally push my tree to linux-next.
> > 
> > I'm thinking that we should get rid of xfail, as it's really
> > confusing,
> > and I don't understand its purpose. But that shouldn't stop pushing
> > your patches.
> >   
> 
> OK, I'm fine with removing it, if it's too confusing.  IIRC Masami
> suggested it to highlight that not all actions and handlers can be used
> together, so I guess I'll hold off on a patch removing it until he can
> chime in...

Yeah, its a different issue. At the very least, we should change the
color of XFAIL to green.

-- Steve

Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB979C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBEA222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394487AbfBMTf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfBMTf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:35:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2333F2146E;
        Wed, 13 Feb 2019 19:35:25 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:35:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v14 06/15] tracing: Add hist trigger snapshot() action
Message-ID: <20190213143523.1e387566@gandalf.local.home>
In-Reply-To: <20190213142551.0b89604e@gandalf.local.home>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
        <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
        <20190213142551.0b89604e@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 14:25:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> I noticed this because we hardcode the size in memcpy. Should hard code
> it above, otherwise it looks like elt_data->comm may be something other
> than TASK_COMM_LEN.


Hi Tom,

My comments on patch 5 and 6 are the only comments I have on the
series. Could you address them and post a v15, and I'll pull them in
and start testing them?

Thanks!

-- Steve

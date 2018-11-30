Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeLAHHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLAHHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:07:47 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22F72082F;
        Fri, 30 Nov 2018 19:57:23 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:57:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 7/9] tools/lib/traceevent: traceevent API cleanup
Message-ID: <20181130145722.3f961ea0@gandalf.local.home>
In-Reply-To: <20181130143736.7b3fbd5f@gandalf.local.home>
References: <20181130154403.150474900@goodmis.org>
        <20181130154647.891651290@goodmis.org>
        <20181130191856.GC19230@kernel.org>
        <20181130143736.7b3fbd5f@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:37:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
 
> What branch are you applying it against? Just to make sure I'm testing
> the same thing you are.

Nevermind, I just downloaded your repo.

BTW, should I be basing these patches off of your repo or tip/perf/core?

-- Steve

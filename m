Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B902082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B902082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeLDQqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbeLDQqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:46:34 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDEAB206B7;
        Tue,  4 Dec 2018 16:46:33 +0000 (UTC)
Date:   Tue, 4 Dec 2018 11:46:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181204114631.23ffe10c@vmware.local.home>
In-Reply-To: <20181204134122.GB19069@kernel.org>
References: <20181203102200.GA104797@gmail.com>
        <20181204134122.GB19069@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 10:41:22 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Dec 03, 2018 at 11:22:00AM +0100, Ingo Molnar escreveu:
> > Go over the tools/ files that are maintained in Arnaldo's tree and
> > fix common typos: half of them were in comments, the other half
> > in JSON files.  
> 
> Steven, Tzvetomir,
> 
> I'm going to split this patch into different subsystems, will have you
> in the CC list for the libtracecmd ones, so that it becomes easier for
> you guys to pick these fixes,

Thanks Arnaldo, much appreciated.

-- Steve

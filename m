Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D270C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2492089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2492089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH1X1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbeH1X1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:27:15 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE242087E;
        Tue, 28 Aug 2018 19:34:07 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:34:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180828153405.7e44d040@gandalf.local.home>
In-Reply-To: <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
        <20180820044250.11659-2-ravi.bangoria@linux.ibm.com>
        <20180822123943.GD2080@linux.vnet.ibm.com>
        <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 12:07:30 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> Hi all,
> 
> What's our plan with this work? Will this be routed via Steven's tree?
> 
> 

I can start pulling these in and testing them.

Thanks,

-- Steve

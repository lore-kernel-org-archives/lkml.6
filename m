Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B43C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D33C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D33C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJOWaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbeJOWaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:30:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9FD020842;
        Mon, 15 Oct 2018 14:44:38 +0000 (UTC)
Date:   Mon, 15 Oct 2018 10:44:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
Message-ID: <20181015104436.1d4a6c3c@gandalf.local.home>
In-Reply-To: <b7525282-b27a-a34c-d503-61fe99673c9f@kernel.org>
References: <CGME20181013022112epcas3p239547464b27b1d750b5628900a89f857@epcas3p2.samsung.com>
        <20181012222106.7f38b667@vmware.local.home>
        <b7525282-b27a-a34c-d503-61fe99673c9f@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 07:39:13 -0600
Shuah Khan <shuah@kernel.org> wrote:

> On 10/12/2018 08:21 PM, Steven Rostedt wrote:
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Now that ftracetest has over 80 tests, it is difficult to simply scroll
> > up the console window to find the failed tests when it reports just two
> > tests have failed. In order to make this stand out better, have the
> > color of the word "PASS" be green, "FAIL" and "XFAIL" be red, and all
> > other results be blue. This helps tremendously in quickly spotting the
> > failed tests by just scrolling up the console window.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Great. Scroll feature is going to be a great help. I will take this
> for 4.20-rc1

Great.

> 
> FYI. Please don't use shuah@kernel.org address for sending patches.
> shuahkh@osg.samsung.com will become absolete due Samsung IT changes.
> 
> getmaintainers should give you right address.
>

OK, Thanks for the update. I have to update my address book (as that's
what I used).

-- Steve

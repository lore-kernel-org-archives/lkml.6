Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79843C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527B22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfBUP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfBUP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:29:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D952A2075A;
        Thu, 21 Feb 2019 15:29:12 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:29:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        KAUSTUBH RAJENDRA WELANKAR 
        <f20160095@hyderabad.bits-pilani.ac.in>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] doc: trace: Fix documentation for uprobe_profile
Message-ID: <20190221102911.1ae9e16b@gandalf.local.home>
In-Reply-To: <1550557168-12345-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1550557168-12345-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 11:49:28 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> uprobe_profile has filename and number of probe hits information for
> each uprobe event. The documentation erroneously talks about probe
> mis-hits. Update the documentation to the correct information.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Reported-by: KAUSTUBH RAJENDRA WELANKAR <f20160095@hyderabad.bits-pilani.ac.in>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Applied. Thanks Srikar,

-- Steve

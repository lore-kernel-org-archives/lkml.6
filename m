Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E07C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6F20643
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbeLVRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389615AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8D321A55;
        Sat, 22 Dec 2018 12:24:49 +0000 (UTC)
Date:   Sat, 22 Dec 2018 07:24:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [for-next][PATCH 05/24] powerpc/frace: Use
 ftrace_graph_get_ret_stack() instead of curr_ret_stack
Message-ID: <20181222072447.5b3f2bd0@vmware.local.home>
In-Reply-To: <87d0ptj3dy.fsf@concordia.ellerman.id.au>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.041890777@goodmis.org>
        <87d0ptj3dy.fsf@concordia.ellerman.id.au>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 20:51:21 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:


> I did test the previous series you posted and I think everything was OK
> running the ftracetest suite (I got one or two fails but I think that
> was because of missing CONFIG options).
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks! I'll add your ack.

-- Steve


Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB789C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC032080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC032080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJ3XwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeJ3XwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:52:11 -0400
Received: from vmware.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933AD20823;
        Tue, 30 Oct 2018 14:58:21 +0000 (UTC)
Date:   Tue, 30 Oct 2018 10:58:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 17/19] selftests: ftrace: Add synthetic
 event syntax testcase
Message-ID: <20181030105815.36974eb4@vmware.local.home>
In-Reply-To: <20181030132824.218056-17-sashal@kernel.org>
References: <20181030132824.218056-1-sashal@kernel.org>
        <20181030132824.218056-17-sashal@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 09:28:22 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> [ Upstream commit ba0e41ca81b935b958006c7120466e2217357827 ]
> 
> Add a testcase to check the syntax and field types for
> synthetic_events interface.
> 
> Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox
> 
> Acked-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Why are you adding selftests for old kernels to test a feature that
wasn't added until 4.17?

-- Steve

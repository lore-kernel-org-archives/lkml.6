Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C2ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49252098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49252098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJREib convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbeJREib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:38:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1562098A;
        Wed, 17 Oct 2018 20:41:05 +0000 (UTC)
Date:   Wed, 17 Oct 2018 16:41:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
Message-ID: <20181017164103.4fb8692f@gandalf.local.home>
In-Reply-To: <20181016170220.31156-1-daniel.diaz@linaro.org>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 12:02:20 -0500
Daniel Díaz <daniel.diaz@linaro.org> wrote:

> If test is being directly executed (with stdout opened on the
> terminal) and the terminal capabilities indicate enough
> colors, then use the existing scheme of green, red, and blue
> to show when tests pass, fail or end in a different way.
> 
> When running the tests redirecting the stdout, for instance,
> to a file, then colors are not shown, thus producing a more
> readable output.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Shuah, can you pull this into your tree?

Thanks,

-- Steve

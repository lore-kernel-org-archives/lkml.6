Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC8C5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5BA21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5BA21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJQCZv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:25:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A36E20645;
        Tue, 16 Oct 2018 18:34:05 +0000 (UTC)
Date:   Tue, 16 Oct 2018 14:34:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
Message-ID: <20181016143404.6847beb4@gandalf.local.home>
In-Reply-To: <037e072a-5695-1343-35d1-37b9450581d4@kernel.org>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
        <037e072a-5695-1343-35d1-37b9450581d4@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 11:43:29 -0600
Shuah Khan <shuah@kernel.org> wrote:

> On 10/16/2018 11:02 AM, Daniel Díaz wrote:
> > If test is being directly executed (with stdout opened on the
> > terminal) and the terminal capabilities indicate enough
> > colors, then use the existing scheme of green, red, and blue
> > to show when tests pass, fail or end in a different way.
> > 
> > When running the tests redirecting the stdout, for instance,
> > to a file, then colors are not shown, thus producing a more
> > readable output.
> > 
> > Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> > ---  
> 
> Hi Daniel,
> 
> Thanks for the patch. Steve is working on adding this functionality. Please
> see the latest linux-kselftest next for the patch.
> 
> Steve just sent an update to the patch to fix an issue. Please test and see
> if that solves the problem you are trying address with this patch.
> 

Hi Shuah,

I think this patch actually addresses the issue of my last patch, and I
haven't sent another one.

I'm waiting to hear from Masami if it fixes the issues he saw.

-- Steve

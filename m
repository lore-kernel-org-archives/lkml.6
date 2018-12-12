Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E70C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0B620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeLLNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeLLNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:51:00 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8BF2086D;
        Wed, 12 Dec 2018 13:50:59 +0000 (UTC)
Date:   Wed, 12 Dec 2018 08:50:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jannh@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/2] seq_buf: Make seq_buf_puts() null-terminate the
 buffer
Message-ID: <20181212085057.5add880c@gandalf.local.home>
In-Reply-To: <20181212084532.093fbf2c@gandalf.local.home>
References: <20181019042109.8064-1-mpe@ellerman.id.au>
        <87imzzvvlh.fsf@concordia.ellerman.id.au>
        <20181212084532.093fbf2c@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 08:45:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 Dec 2018 22:21:46 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Hi Steve,
> > 
> > Friendly ping :)
> > 
> > Do you mind picking this one up for 4.21 ?
> > 
> >  
> 
> Thanks for the reminder, I've been swamped lately. I'll take a look now.
> 
>

OK, I applied both to my local queue, and it will reach linux-next
probably some time at the end of this week or early next week. It needs
to wait till I'm ready to run my local changes through my test suite.

Thanks!

-- Steve

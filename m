Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65721C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E93217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeLRD6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:58:19 -0500
Received: from ozlabs.org ([203.11.71.1]:51857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLRD6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:58:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JklD2KcDz9s0n;
        Tue, 18 Dec 2018 14:58:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jannh@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/2] seq_buf: Make seq_buf_puts() null-terminate the buffer
In-Reply-To: <20181212085057.5add880c@gandalf.local.home>
References: <20181019042109.8064-1-mpe@ellerman.id.au> <87imzzvvlh.fsf@concordia.ellerman.id.au> <20181212084532.093fbf2c@gandalf.local.home> <20181212085057.5add880c@gandalf.local.home>
Date:   Tue, 18 Dec 2018 14:58:08 +1100
Message-ID: <87a7l3trjj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Wed, 12 Dec 2018 08:45:32 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Wed, 12 Dec 2018 22:21:46 +1100
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> 
>> > Hi Steve,
>> > 
>> > Friendly ping :)
>> > 
>> > Do you mind picking this one up for 4.21 ?
>> > 
>> >  
>> 
>> Thanks for the reminder, I've been swamped lately. I'll take a look now.
>> 
>
> OK, I applied both to my local queue, and it will reach linux-next
> probably some time at the end of this week or early next week. It needs
> to wait till I'm ready to run my local changes through my test suite.

Sure, no rush. Thanks.

cheers

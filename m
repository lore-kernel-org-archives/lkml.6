Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7D32145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7D32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeIYJ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:28:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56490 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeIYJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:28:16 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9922D10009340;
        Mon, 24 Sep 2018 20:22:52 -0700 (PDT)
Date:   Mon, 24 Sep 2018 20:22:52 -0700 (PDT)
Message-Id: <20180924.202252.1960552216624164256.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     allen.pais@oracle.com, pombredanne@nexb.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: viohs: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
References: <20180905220351.GA48213@beast>
        <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Sep 2018 20:22:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 24 Sep 2018 20:17:55 -0700

> On Wed, Sep 5, 2018 at 3:03 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> allocates a fixed size array for the maximum number of cookies and
>> adds a runtime sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
>> RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Friendly ping. Dave, can you take this?

I'll try to get to this soon, kinda backlogged at the moment.

Sorry.

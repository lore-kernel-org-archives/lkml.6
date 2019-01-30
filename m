Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE14C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E027E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfA3Bgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:36:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfA3Bgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:36:36 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13EF13635;
        Wed, 30 Jan 2019 01:36:36 +0000 (UTC)
Date:   Tue, 29 Jan 2019 17:36:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/ubsan: default UBSAN_ALIGNMENT to not set
Message-Id: <20190129173634.ee579795b227b141efc8bd30@linux-foundation.org>
In-Reply-To: <8bc73bbf-6c12-7fd1-3253-676731bf5ae5@virtuozzo.com>
References: <20181217150326.30933-1-anders.roxell@linaro.org>
        <8bc73bbf-6c12-7fd1-3253-676731bf5ae5@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 22:01:16 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> 
> 
> On 12/17/18 6:03 PM, Anders Roxell wrote:
> > When booting an allmodconfig kernel, there are a lot of false-positives.
> > With a message like this 'UBSAN: Undefined behaviour in...' with a call
> > trace that follows.
> > 
> > Reworked so that when building a allmodconfig kernel that turns
> > everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> 
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 

Confused.  Why does allmodconfig result in UBSAN warnings?
 

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7365BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7252416F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7252416F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeGCSaw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:30:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934466AbeGCSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:30:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C214ACBB;
        Tue,  3 Jul 2018 18:30:49 +0000 (UTC)
Date:   Tue, 3 Jul 2018 11:30:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: /tmp/cctnQ1CM.s:35: Error: .err encountered
Message-Id: <20180703113048.75989ea95833e9a2325687ec@linux-foundation.org>
In-Reply-To: <CAOesGMgGmr4o92subyJMGGbv7CxFYH_zKV01aWK4TwnEgzHTUQ@mail.gmail.com>
References: <201806301538.bewm1wka%fengguang.wu@intel.com>
        <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
        <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org>
        <20180630111210.ec9de2c2923a0c58b1357965@linux-foundation.org>
        <CAOesGMh6yVYKQ+dJbAsJWU=7wrfwW1cBwVbGoKNiG96_Mh6ebA@mail.gmail.com>
        <CAOesGMgGmr4o92subyJMGGbv7CxFYH_zKV01aWK4TwnEgzHTUQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 10:50:46 -0700 Olof Johansson <olof@lixom.net> wrote:

> > Solves it on my builder at least. Would be good to get this in.
> >
> > Acked-by: Olof Johansson <olof@lixom.net>
> 
> Since this doesn't seem to be in your queue at the moment, I've
> applied it to our set of fixes for 4.18 in arm-soc, I'll send to Linus
> at end of week and it'll be in -next as of now through there.

I queued it on June 30:

http://ozlabs.org/~akpm/mmots/broken-out/arm-disable-kcov-for-trusted-foundations-code.patch

but whatever.  If it turns up in -next I drop my copy.

Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D6F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D6F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHaXCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:02:49 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:58241 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726704AbeHaXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:02:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6ECAF181D3368;
        Fri, 31 Aug 2018 18:54:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: move36_5cdee059c6229
X-Filterd-Recvd-Size: 1797
Received: from XPS-9350 (unknown [172.58.30.189])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Aug 2018 18:53:58 +0000 (UTC)
Message-ID: <e4bb6b7be9eac45f2f0c83cc23e75a3a8e0f07e9.camel@perches.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        asmadeus@codewreck.org
Date:   Fri, 31 Aug 2018 11:53:56 -0700
In-Reply-To: <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
         <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
         <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:43 -0700, Nick Desaulniers wrote:
> I don't think minimal supported versions are required for these clean
> ups, and would not block these patches from landing on that.

Nor would I, but it's one of those symmetry things.

Likely, someone would eventually complain if their old
icc/clang compiler failed to produce a functional kernel.

If the minimum versions aren't really known and nobody
notices, then it really doesn't matter.



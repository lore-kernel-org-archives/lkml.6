Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D364C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055BF23E6C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055BF23E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeGCBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:09:25 -0400
Received: from ozlabs.org ([203.11.71.1]:56681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbeGCBJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:09:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41KQxs5qllz9s3R;
        Tue,  3 Jul 2018 11:09:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: Build regressions/improvements in v4.18-rc3
In-Reply-To: <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de>
References: <20180702140050.1660-1-geert@linux-m68k.org> <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com> <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de>
Date:   Tue, 03 Jul 2018 11:09:17 +1000
Message-ID: <87601xgm6a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> On 02.07.2018 16:09, Geert Uytterhoeven wrote:
>> On Mon, Jul 2, 2018 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> JFYI, when comparing v4.18-rc3[1] to v4.18-rc2[3], the summaries are:
>> ...
>
> Both of the following are simply happening because of old compiler which is being used:
>
>>> [Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]

It's GCC 4.6.3. Are you saying that's not supported anymore?

I can update to 8.1.0 if that's more useful.

cheers

Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D1F208B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D1F208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeGDE5E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:57:04 -0400
Received: from ozlabs.org ([203.11.71.1]:35661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932258AbeGDE5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:57:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41L7y51w7wz9s52;
        Wed,  4 Jul 2018 14:57:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: Build regressions/improvements in v4.18-rc3
In-Reply-To: <74980be1-0684-09ef-9e31-cb8f0db13139@bell.net>
References: <20180702140050.1660-1-geert@linux-m68k.org> <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com> <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de> <87601xgm6a.fsf@concordia.ellerman.id.au> <74980be1-0684-09ef-9e31-cb8f0db13139@bell.net>
Date:   Wed, 04 Jul 2018 14:56:57 +1000
Message-ID: <87sh4zlht2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John David Anglin <dave.anglin@bell.net> writes:

> On 2018-07-02 9:09 PM, Michael Ellerman wrote:
>> It's GCC 4.6.3. Are you saying that's not supported anymore?
> See <https://gcc.gnu.org/> for supported releases.

Thanks, but I mean "supported by the parisc Linux port".

Allegedly the kernel builds with GCC 3.2:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst#n32


But in reality each arch has a different minimum version they actually
care about.

cheers

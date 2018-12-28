Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2D7218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeL1DE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:04:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeL1DE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:04:58 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 490DFACC;
        Fri, 28 Dec 2018 03:04:57 +0000 (UTC)
Date:   Thu, 27 Dec 2018 19:04:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
Message-Id: <20181227190456.0f21d511ef71f1b455403f2a@linux-foundation.org>
In-Reply-To: <CAKv+Gu_e=NkKZ5C+KzBmgg2VMXNKPqXcPON8heRd0F_iW+aaEQ@mail.gmail.com>
References: <20181226023534.64048-1-cai@lca.pw>
        <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
        <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw>
        <CAKv+Gu_e=NkKZ5C+KzBmgg2VMXNKPqXcPON8heRd0F_iW+aaEQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 16:31:59 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Please stop sending EFI patches if you can't be bothered to
> test/reproduce against the EFI tree.

um, sorry, but that's a bit strong.  Finding (let alone fixing) a bug
in EFI is a great contribution (thanks!) and the EFI maintainers are
perfectly capable of reviewing and testing the proposed fix.  Or of
fixing the bug by other means.

Let's not beat people up for helping us in a less-than-perfect way, no?

Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C927C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B2920675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394506AbfBMT7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:59:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBMT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:59:08 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 116B81172;
        Wed, 13 Feb 2019 19:59:07 +0000 (UTC)
Date:   Wed, 13 Feb 2019 11:59:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the akpm tree with the tip tree
Message-Id: <20190213115905.f8b0f189c4196eac2ca1138f@linux-foundation.org>
In-Reply-To: <20190213174928.18128be0@canb.auug.org.au>
References: <20190213174928.18128be0@canb.auug.org.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 17:49:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the akpm tree got a conflict in:
> 
>   scripts/atomic/check-atomics.sh
> 
> between commit:
> 
>   4ad119545d78 ("locking/atomics: Check atomic headers with sha1sum")
> 
> from the tip tree and patch:
> 
>   "scripts/atomic/check-atomics.sh: don't assume that scripts are executable"
> 
> from the akpm tree.
> 
> I fixed it up (this latter patch is now needed against the new
> scripts/atomic/gen-atomics.sh instead) and can carry the fix as
> necessary.

Thanks.  I don't know why I've been carrying that fix for so long :(
Shall resend.


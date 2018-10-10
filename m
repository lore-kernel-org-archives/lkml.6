Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeJKGxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:53:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:53:49 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22263360;
        Wed, 10 Oct 2018 23:29:24 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:29:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3 1/3] mm: zero remaining unavailable struct pages
Message-Id: <20181010162922.ceea68916c51f08c54b18d4e@linux-foundation.org>
In-Reply-To: <20181002143821.5112-2-msys.mizuma@gmail.com>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
        <20181002143821.5112-2-msys.mizuma@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Oct 2018 10:38:19 -0400 Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> ...
>
> Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Tested-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This patch and [2/3] should have had your Signed-off-by:, since you
were on the patch delivery path.  As explained in
Documentation/process/submitting-patches.rst, section 11.

I have made that change to my copy of these two patches.

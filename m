Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E2428C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B08A208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B08A208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeFKWrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:47:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeFKWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:47:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.103])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 606B51265;
        Mon, 11 Jun 2018 22:47:09 +0000 (UTC)
Date:   Mon, 11 Jun 2018 15:47:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/page_ext: Trivial cleanups
Message-Id: <20180611154708.559389909285af3e1951ccbc@linux-foundation.org>
In-Reply-To: <20180611143414.vqbfvrn2bvqtjpfw@black.fi.intel.com>
References: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
        <20180611143414.vqbfvrn2bvqtjpfw@black.fi.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 17:34:15 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Thu, May 31, 2018 at 01:54:55PM +0000, Kirill A. Shutemov wrote:
> > A pair of trivial cleanups in preparation for memory encryption.
> 
> Andrew, can we get these applied?
> 

Mid-merge-window is not a good time to be looking at trivial cleanups. 
They're in my to-look-at pile.  Later this week, maybe next week.

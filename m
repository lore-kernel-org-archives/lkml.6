Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C83C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349EC20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349EC20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJCFSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:18:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:18:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2FE5F3A;
        Tue,  2 Oct 2018 22:32:34 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:32:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mihir Mehta <mihir@cs.utexas.edu>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Expand a slightly out-of-date comment
Message-Id: <20181002153232.fe76b9661ce1f226338f7654@linux-foundation.org>
In-Reply-To: <20180928194947.23932-1-mihir@cs.utexas.edu>
References: <87sh1tewtw.fsf@mail.parknet.co.jp>
        <20180928194947.23932-1-mihir@cs.utexas.edu>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 14:49:47 -0500 Mihir Mehta <mihir@cs.utexas.edu> wrote:

> The file namei.c seems to have been renamed to namei_msdos.c, so I
> decided to update the comment with the correct name, and expand it a bit
> to tell the reader what to look for.

Please send us a Signed-off-by: for this patch, as per
Documentation/process/submitting-patches.rst, section 11.

Thanks.

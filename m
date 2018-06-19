Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB45C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D682320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D682320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeFSW07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:26:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeFSW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:26:57 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F7ABFA9;
        Tue, 19 Jun 2018 22:26:57 +0000 (UTC)
Date:   Tue, 19 Jun 2018 15:26:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Hansen <chansen3@cisco.com>
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: modifying page-types to include shared map
 counts
Message-Id: <20180619152656.823e79183f4cbbd8029fe8bf@linux-foundation.org>
In-Reply-To: <20180612153205.12879-1-chansen3@cisco.com>
References: <20180612153205.12879-1-chansen3@cisco.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:32:05 -0400 Christian Hansen <chansen3@cisco.com> wrote:

> Adding a new flag that will read kpagecount for each PFN
> and print out the number of time the page is mapped along
> with the flags in the listing view.

tools/vm/page-types.c isn't particularly documented, although it might
be apprpriate to add some words to
Documentation/admin-guide/mm/pagemap.rst to describe this addition.

Also, it would be very helpful if the changelog was to include sample
output, so we can better understand the proposal.


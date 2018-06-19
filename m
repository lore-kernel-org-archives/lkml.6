Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D0CC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709E7204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeFSWlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:41:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeFSWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:41:02 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC94DFE6;
        Tue, 19 Jun 2018 22:41:01 +0000 (UTC)
Date:   Tue, 19 Jun 2018 15:41:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Hansen <chansen3@cisco.com>
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: adding support for idle page tracking to tool
Message-Id: <20180619154100.3f30e1bb4f110b65dacbd956@linux-foundation.org>
In-Reply-To: <20180612153223.13174-1-chansen3@cisco.com>
References: <20180612153223.13174-1-chansen3@cisco.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:32:23 -0400 Christian Hansen <chansen3@cisco.com> wrote:

> Adding a flag which will use the kernels's idle
> page tracking to mark pages idle.  As the tool already
> prints the idle flag if set, subsequent runs will show
> which pages have been accessed since last run.

Also, it would be appropriate to document this new feature in
Documentation/admin-guide/mm/idle_page_tracking.rst.

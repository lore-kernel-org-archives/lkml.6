Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CF820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGZUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:46:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeGZUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:46:23 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2507BDB;
        Thu, 26 Jul 2018 19:28:07 +0000 (UTC)
Date:   Thu, 26 Jul 2018 12:28:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
Message-Id: <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
In-Reply-To: <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
        <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> I'll give it a spin, see how noisy it is.

Actually, I would prefer if the message, changelog and title
used the term "passed by value".  It's a more familiar term
and it is possible for a passed-by-value aggregate to in fact 
be passed in registers.

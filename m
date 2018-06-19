Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F360C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48782075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48782075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964931AbeFSWAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:00:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755490AbeFSV77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:59:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AF509CC7;
        Tue, 19 Jun 2018 21:59:58 +0000 (UTC)
Date:   Tue, 19 Jun 2018 14:59:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: Make inline name size calculation automatic
Message-Id: <20180619145957.187edcdb0b75901a790774b4@linux-foundation.org>
In-Reply-To: <20014.1529395261@warthog.procyon.org.uk>
References: <20180618174210.b8348d35bce35b2277cab660@linux-foundation.org>
        <152891539958.23512.10618044594537218194.stgit@warthog.procyon.org.uk>
        <20014.1529395261@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 09:01:01 +0100 David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Please cc Alexey on /proc patches.
> 
> If Alexey is responsible for procfs he should declare this in MAINTAINERS.

oop.  I thought we did that but it isn't there.

> > What are the user-visible runtime effects of this change?
> 
> Memory usage only.

Please always include such info in changelogs.

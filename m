Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83689C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE8219CA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AE8219CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeHRBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:47:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHRBrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:47:09 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CDBBBD4;
        Fri, 17 Aug 2018 22:41:56 +0000 (UTC)
Date:   Fri, 17 Aug 2018 15:41:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [GIT PULL] 9p updates for 4.19
Message-Id: <20180817154155.ebe6ffee995a37ade029db2f@linux-foundation.org>
In-Reply-To: <CA+55aFx58-vbKca_KGdhOA3cJ_M7HP=wOsJ483os=CCobi2zOA@mail.gmail.com>
References: <20180813012347.GA32555@nautica>
        <20180817023307.GA32726@nautica>
        <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
        <20180817213648.GA31406@nautica>
        <CA+55aFx58-vbKca_KGdhOA3cJ_M7HP=wOsJ483os=CCobi2zOA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:35:15 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I would basically want to see Andrew and/or others be on record of
> saying "yup, this looks good, go ahead and pull from Dominique".

Please do.  I'll actually be sending you the MAINTAINERS update in
about 55 seconds.

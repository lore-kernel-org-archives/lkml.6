Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62411C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF0020834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF0020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLAGpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAGpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:45:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0C020834;
        Fri, 30 Nov 2018 19:35:12 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:35:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: More fixes for 4.20
Message-ID: <20181130143510.39457d20@gandalf.local.home>
In-Reply-To: <CAHk-=wgJErbyjbAy=cFHUcT7STP7taGtTBX5sfAgkTX6Yq6Skg@mail.gmail.com>
References: <20181130031829.268422593@goodmis.org>
        <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
        <CAHk-=wgJErbyjbAy=cFHUcT7STP7taGtTBX5sfAgkTX6Yq6Skg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 10:56:06 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> This way I got the matching diffstat from your pull requests, but more
> importantly also the independent merge messages.
> 
> The history looks slightly odd this way (with two adjacent merges of
> continuous history), but I thought I'd explain the reason.

It makes perfect sense.

-- Steve

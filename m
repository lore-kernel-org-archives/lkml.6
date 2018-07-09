Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880CA208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880CA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGIVm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:42:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933091AbeGIVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:42:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49BC7D53;
        Mon,  9 Jul 2018 21:42:56 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:42:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 11/12] ipc: simplify ipc initialization
Message-Id: <20180709144255.9d572c2e5b7064e15a60caa1@linux-foundation.org>
In-Reply-To: <20180709151019.1336-12-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
        <20180709151019.1336-12-manfred@colorfullife.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 17:10:18 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:

> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> ...
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Should these be From: dbueso@suse.de?

Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E1218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfBMNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389013AbfBMNpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:45:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AC4218D3;
        Wed, 13 Feb 2019 13:45:12 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:45:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Andress Kuo <andress.kuo@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on
 printk_format.
Message-ID: <20190213084511.45b86e15@gandalf.local.home>
In-Reply-To: <1550040585.12645.9.camel@mtkswgap22>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
        <20190212204113.5ecaa2a1@gandalf.local.home>
        <1550033650.7648.2.camel@mtkswgap22>
        <1550040585.12645.9.camel@mtkswgap22>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 14:49:45 +0800
Mars Cheng <mars.cheng@mediatek.com> wrote:


> After some grep, I found event_trace_printk() not used in 5.0-rc*. But
> trace_printk() is still used in several places.

event_trace_printk() is an abomination, but trace_printk() is an
extremely useful tool. Don't touch that!

-- Steve

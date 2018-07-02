Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B423CB4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2B423CB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965666AbeGBL1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:27:23 -0400
Received: from muru.com ([72.249.23.125]:49572 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965489AbeGBL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:27:22 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B93F38047;
        Mon,  2 Jul 2018 11:30:17 +0000 (UTC)
Date:   Mon, 2 Jul 2018 04:27:19 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] bus: ti-sysc: Use 2-factor allocator arguments
Message-ID: <20180702112719.GU112168@atomide.com>
References: <20180618174549.GA1893@beast>
 <CAGXu5jJZH0fh_q7o2w2_tX3Xxyn2xm-55J62JcucgfWBUYkU5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJZH0fh_q7o2w2_tX3Xxyn2xm-55J62JcucgfWBUYkU5Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook <keescook@chromium.org> [180627 21:59]:
> On Mon, Jun 18, 2018 at 10:45 AM, Kees Cook <keescook@chromium.org> wrote:
> > This adjusts the allocator calls to use 2-factor argument call style, as
> > done treewide already for improved defense against allocation overflows.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Friendly ping! :) This is the last 2-factor devm* allocation left in
> 4.18 to be fixed.

Sorry for the delay on this one. As we're already at -rc3, I'll apply
this into omap-for-v4.19/ti-sysc. Seems there should not be need to rush
this into v4.18-rc cycle, but please do let me know if that is not the
case.

Regards,

Tony

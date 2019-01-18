Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307D120850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfARPb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:31:29 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:59106 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfARPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:31:28 -0500
X-Greylist: delayed 1459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2019 10:31:28 EST
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x0IF7708020955;
        Fri, 18 Jan 2019 15:07:07 GMT
Date:   Fri, 18 Jan 2019 15:07:06 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] spectre hardware-software cooperative mitigation
Message-ID: <20190118150706.7b1b9e31@alans-desktop>
In-Reply-To: <CAPweEDyV487=EWqAibc5g_yhtuvy3w2qabCSOqh32q38rrXLSw@mail.gmail.com>
References: <CAPweEDyvUdGvwy4u5qoA2QgDow0npZBMqjeMiU2RqzrJ_q4Omw@mail.gmail.com>
        <CAPweEDyV487=EWqAibc5g_yhtuvy3w2qabCSOqh32q38rrXLSw@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is going to be a mammoth task. The alternatives are to continue
> as things are, which is a mess that cannot be cleaned up by either of
> (mutually exclusive) hardware or software alone.
> 
> Thoughts and feedback appreciated.

You need to be talking to the JIT developers not asking here I think.
Speculative attacks in JIT environments is a topic an order of magnitude
or more complex than the kernel cases because there isn't even process
isolation between the JIT, JIT engin eand support logic.

Alan

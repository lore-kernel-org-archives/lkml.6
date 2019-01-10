Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25475C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36021848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfAJXrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:47:05 -0500
Received: from ms.lwn.net ([45.79.88.28]:54226 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfAJXrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:47:05 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5E6E2BB;
        Thu, 10 Jan 2019 23:47:04 +0000 (UTC)
Date:   Thu, 10 Jan 2019 16:47:03 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/filesystems: add binderfs
Message-ID: <20190110164703.1dd6cee1@lwn.net>
In-Reply-To: <20190110231309.12653-1-christian@brauner.io>
References: <20190110231309.12653-1-christian@brauner.io>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 00:13:09 +0100
Christian Brauner <christian@brauner.io> wrote:

> This documents the Android binderfs filesystem used to dynamically add and
> remove binder devices that are private to each instance.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Seems like a worthwhile addition overall.  I know nothing about binderfs,
so can't speak to the accuracy, of course.  I do have a couple of
metacomments, though:

 - Please consider doing this in RST and tying it into our documentation
   tree.  It's *almost* RST now, so the effort required will be almost
   zero.

 - It should probably have an SPDX line at the top.

 - Is it worth putting the example program in the samples/ directory?  Is
   it something that would ever make any sense to run in its current form?

Thanks,

jon

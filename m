Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A11C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC7D20C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC7D20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHTA2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 20:28:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:34438 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeHTA2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 20:28:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 277BB2DC;
        Sun, 19 Aug 2018 21:15:23 +0000 (UTC)
Date:   Sun, 19 Aug 2018 15:15:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Revert "Permit silencing of __deprecated warnings."
Message-ID: <20180819151521.4ff92d7e@lwn.net>
In-Reply-To: <20180818024506.GA26409@ziepe.ca>
References: <20180818024506.GA26409@ziepe.ca>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 20:45:06 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> Jonathan: I'm not sure if you prefer diffs to documentation to be
> minimal like this, or if should reflow the paragraph?

I guess I've never really thought to develop a strong preference.  But,
in the end, the docs are meant to be read in their source form, so we
want to keep them readable.  If a paragraph needs to be refilled due to
significant changes, just go ahead and do it...

jon

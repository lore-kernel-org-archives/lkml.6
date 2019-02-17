Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50757218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBQWja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:39:30 -0500
Received: from ms.lwn.net ([45.79.88.28]:37956 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfBQWja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:39:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A8CF300;
        Sun, 17 Feb 2019 22:39:22 +0000 (UTC)
Date:   Sun, 17 Feb 2019 15:39:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     frowand.list@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-doc: typo "if ... if" -> "if ... is"
Message-ID: <20190217153908.78646071@lwn.net>
In-Reply-To: <1549924684-2148-1-git-send-email-frowand.list@gmail.com>
References: <1549924684-2148-1-git-send-email-frowand.list@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 14:38:04 -0800
frowand.list@gmail.com wrote:

> From: Frank Rowand <frank.rowand@sony.com>
> 
> "If no *function* if specified" should instead be
> "If no *function* is specified".
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Applied, thanks.

jon

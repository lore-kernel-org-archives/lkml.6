Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69422086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBAW7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:59:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:33416 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfBAW7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:59:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5AEEC2BD;
        Fri,  1 Feb 2019 22:59:36 +0000 (UTC)
Date:   Fri, 1 Feb 2019 15:59:35 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     frowand.list@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-doc: update commands to generate man page
Message-ID: <20190201155935.169d2e15@lwn.net>
In-Reply-To: <1549058079-10582-1-git-send-email-frowand.list@gmail.com>
References: <1549058079-10582-1-git-send-email-frowand.list@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 13:54:39 -0800
frowand.list@gmail.com wrote:

> (1) The command to generate man pages is truncated in the pdf version
> of the document.  Reformat the command into multiple lines to prevent
> the truncation.
> 
> (2) Older versions of git do not support all variants of pathspec
> syntax.  Provide commands to generate man pages for various
> alternate syntax.

Applied, thanks.

(Though it would sure be nice if we could document which versions of the
syntax should be used with which versions of git...:)

jon

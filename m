Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515E320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBVPh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:37:26 -0500
Received: from ms.lwn.net ([45.79.88.28]:52510 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVPh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:37:26 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8ECB035A;
        Fri, 22 Feb 2019 15:37:25 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:37:24 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] Documentation: fix admin-guide/README.rst minimum gcc
 version requirement
Message-ID: <20190222083724.70145ce0@lwn.net>
In-Reply-To: <ecb653af-79e5-6233-a7f6-edbb61715d3b@infradead.org>
References: <ecb653af-79e5-6233-a7f6-edbb61715d3b@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 20:02:33 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix minimum gcc version as specified in Documentation/process/changes.rst.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/admin-guide/README.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-50-rc7.orig/Documentation/admin-guide/README.rst
> +++ lnx-50-rc7/Documentation/admin-guide/README.rst
> @@ -251,7 +251,7 @@ Configuring the kernel
>  Compiling the kernel
>  --------------------
>  
> - - Make sure you have at least gcc 3.2 available.
> + - Make sure you have at least gcc 4.6 available.
>     For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
>  
>     Please note that you can still run a.out user programs with this kernel.

Applied, thanks.

Good to know I can still run my a.out binaries :)

jon

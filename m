Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06183C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D255321924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfBHUIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:08:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:56324 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfBHUIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:08:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 381392CD;
        Fri,  8 Feb 2019 20:08:15 +0000 (UTC)
Date:   Fri, 8 Feb 2019 13:08:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Joris Gutjahr <joris.gutjahr@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-doc: typo "documentaion"
Message-ID: <20190208130814.3d1534cd@lwn.net>
In-Reply-To: <9dc7fd5f-3ed6-f36d-5b84-8fcd3c477181@gmail.com>
References: <1549058656-11119-1-git-send-email-frowand.list@gmail.com>
        <20190202205620.GA13285@bombadil.infradead.org>
        <9dc7fd5f-3ed6-f36d-5b84-8fcd3c477181@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 16:29:31 -0800
Frank Rowand <frowand.list@gmail.com> wrote:

> On 2/2/19 12:56 PM, Matthew Wilcox wrote:
> > On Fri, Feb 01, 2019 at 02:04:16PM -0800, frowand.list@gmail.com wrote:  
> >>    Include documentation for each *function* in *source*.
> >> -  If no *function* if specified, the documentaion for all functions
> >> +  If no *function* if specified, the documentation for all functions
> >>    and types in the *source* will be included.  
> > 
> > Could you fix the if/is mistake while you're at it?
> >   
> 
> 
> Jon,
> 
> Since you already accepted the patch, is it easy for you to revert the
> patch and apply a v2 with the change Mathew pointed out?  If so, I will
> do a v2.

How about you just send another with the second fix?  Seems just as easy
in the end...

Thanks,

jon

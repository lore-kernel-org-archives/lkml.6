Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C6C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78718208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfACQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:18:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:57098 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfACQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:18:22 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E31CE7DC;
        Thu,  3 Jan 2019 16:18:21 +0000 (UTC)
Date:   Thu, 3 Jan 2019 09:18:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: Re: [PATCH] Docs/kernel-api.rst: Remove removed blk-tag.c reference
Message-ID: <20190103091820.224b180d@lwn.net>
In-Reply-To: <20190102004015.47152-1-marcos.souza.org@gmail.com>
References: <20190102004015.47152-1-marcos.souza.org@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Jan 2019 22:40:14 -0200
Marcos Paulo de Souza <marcos.souza.org@gmail.com> wrote:

> After 7ca01926463a, legacy rq tagging was removed, so block/blk-tag.c
> does not exists anymore. When generating pdfdocs, sphinx complains about
> this missing file:
> 
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> 
> So remove blk-tag.c traces from kernel-api.rst file to silence these
> warnings.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Applied to the docs tree, thanks.

jon

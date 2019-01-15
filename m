Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3BCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64037206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfAOAhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:37:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:38606 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfAOAhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:37:22 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 934472E5;
        Tue, 15 Jan 2019 00:37:21 +0000 (UTC)
Date:   Mon, 14 Jan 2019 17:37:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs-rst: doc-guide: Minor grammar fixes
Message-ID: <20190114173720.3e1d4c58@lwn.net>
In-Reply-To: <1547450099-3534-1-git-send-email-joeln@il.ibm.com>
References: <1547450099-3534-1-git-send-email-joeln@il.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 09:14:59 +0200
Joel Nider <joeln@il.ibm.com> wrote:

> While using this guide to learn the new documentation method, I saw
> a few phrases that I felt could be improved. These small changes
> improve the grammar and choice of words to further enhance the
> installation instructions.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
> Acked-by: Matthew Wilcox <willy@infradead.org>
> ---
> v2: address Matthew's comment

Applied, thanks.

jon

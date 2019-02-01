Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A7214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfBAXU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:20:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:33596 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfBAXU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:20:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 339C72C4;
        Fri,  1 Feb 2019 23:12:19 +0000 (UTC)
Date:   Fri, 1 Feb 2019 16:12:17 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] stable-kernel-rules.rst: add link to networking patch
 queue
Message-ID: <20190201161217.46d7b88b@lwn.net>
In-Reply-To: <20190122184632.GA32510@kroah.com>
References: <20190122184632.GA32510@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 19:46:32 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> The networking maintainer keeps a public list of the patches being
> queued up for the next round of stable releases.  Be sure to check there
> before asking for a patch to be applied so that you do not waste
> people's time.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: David S. Miller <davem@davemloft.net>
> ---
> 
> Jon, I can take this through one of my trees if you don't want to, which
> ever is easier for you.

I'm back from my wanderings finally and have just applied it.

Thanks,

jon

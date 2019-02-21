Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0702081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfBUTGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:06:41 -0500
Received: from ms.lwn.net ([45.79.88.28]:46534 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUTGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:06:40 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2351272D;
        Thu, 21 Feb 2019 19:06:40 +0000 (UTC)
Date:   Thu, 21 Feb 2019 12:06:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        axboe@kernel.dk
Subject: Re: [PATCH 0/2] docs: Add some struct file refcounting information
Message-ID: <20190221120639.2c321ea4@lwn.net>
In-Reply-To: <20190221190230.17985-1-corbet@lwn.net>
References: <20190221190230.17985-1-corbet@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 12:02:28 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Al Viro's recent "braindump" on how struct file refcounting works is too
> good to lose, so let's capture it in Documentation/.  There are two changes
> here:
> 
>  - Clean up the filesystem book, move stuff around, and generally try to
>    create some order here.  No text changes other than some connecting
>    text.
> 
>  - Bring in Al's text, with a fair amount of language tweaking and later
>    corrections applied.
> 
> Hopefully this is just the beginning.

I meant to add that, should anybody be curious to see the formatted
version of this work, it's at:

  https://static.lwn.net/kerneldoc/filesystems/index.html

jon

Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F8C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5EA20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAUHj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:32976 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfAUHjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 66D242D0;
        Mon, 21 Jan 2019 01:43:43 +0000 (UTC)
Date:   Sun, 20 Jan 2019 18:43:38 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Greg KH <greg@kroah.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:process: remove note from 'stable api nonsense'
Message-ID: <20190120184338.01cd4ef9@lwn.net>
In-Reply-To: <20190118215804.3340-1-federico.vaga@vaga.pv.it>
References: <20190118215804.3340-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 22:58:04 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> The link referred by the note can't be retrieved: this patch just
> remove that old note.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/process/stable-api-nonsense.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/stable-api-nonsense.rst b/Documentation/process/stable-api-nonsense.rst
> index 24f5aeecee91..57d95a49c096 100644
> --- a/Documentation/process/stable-api-nonsense.rst
> +++ b/Documentation/process/stable-api-nonsense.rst
> @@ -171,8 +171,7 @@ is also a rough job.
>  
>  Simple, get your kernel driver into the main kernel tree (remember we
>  are talking about GPL released drivers here, if your code doesn't fall
> -under this category, good luck, you are on your own here, you leech
> -<insert link to leech comment from Andrew and Linus here>.)  If your
> +under this category, good luck, you are on your own here, you leech).  If your
>  driver is in the tree, and a kernel interface changes, it will be fixed
>  up by the person who did the kernel change in the first place.  This
>  ensures that your driver is always buildable, and works over time, with

I've applied this.  I do wonder if the "you leech" should maybe come out
too, though.  I don't think that parasitic worms are a protected class
under the CoC, but they might still suffer emotionally from being
compared to the purveyors of proprietary modules...

jon

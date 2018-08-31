Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B68C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5B2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B5B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeIACif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:38:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:33894 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeIACif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:38:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E3FE12B0;
        Fri, 31 Aug 2018 22:28:58 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:28:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tim Bird <tim.bird@sony.com>
Subject: Re: [PATCH] docs: fix typo in table describing 4.16 development
 cycle
Message-ID: <20180831162845.28a1ba28@lwn.net>
In-Reply-To: <1534527210-1947-1-git-send-email-akinobu.mita@gmail.com>
References: <1534527210-1947-1-git-send-email-akinobu.mita@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 02:33:30 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Fix s/4.17/4.16/ typo.
> 
> Fixes: 8962e40c1993 ("docs: update kernel versions and dates in tables")
> Cc: Tim Bird <tim.bird@sony.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  Documentation/process/2.Process.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index 51d0349..ae020d8 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -82,7 +82,7 @@ As an example, here is how the 4.16 development cycle went (all dates in
>  	March 11	4.16-rc5
>  	March 18	4.16-rc6
>  	March 25	4.16-rc7
> -	April 1		4.17 stable release
> +	April 1		4.16 stable release

Oops...  applied, thanks.

jon

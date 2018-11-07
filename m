Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423EBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F8D20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeKHIXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:23:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:45946 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbeKHIXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:23:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 141D2537;
        Wed,  7 Nov 2018 22:50:35 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:50:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-edac@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [trivial] Documentation/ras: Typo s/use use/use/
Message-ID: <20181107155034.0955101e@lwn.net>
In-Reply-To: <20181107134617.14092-1-geert+renesas@glider.be>
References: <20181107134617.14092-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 14:46:17 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/admin-guide/ras.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
> index 197896718f813036..c7495e42e6f48bcb 100644
> --- a/Documentation/admin-guide/ras.rst
> +++ b/Documentation/admin-guide/ras.rst
> @@ -54,7 +54,7 @@ those errors are correctable.
>  Types of errors
>  ---------------
>  
> -Most mechanisms used on modern systems use use technologies like Hamming
> +Most mechanisms used on modern systems use technologies like Hamming
>  Codes that allow error correction when the number of errors on a bit packet
>  is below a threshold. If the number of errors is above, those mechanisms
>  can indicate with a high degree of confidence that an error happened, but

Applied, thanks.

jon

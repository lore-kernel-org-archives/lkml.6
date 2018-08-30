Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF49C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F251020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRQEhHga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F251020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeH3X4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:56:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH3X4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ijlrZb64gUx2BYNyDfMZMz8l7+DCMrqG7Y61JHu0dBs=; b=PRQEhHga5gVXTPXKuYPuq6rqu
        kgp8/1/BYy8gj5le1/yYwUZ+NRqAS3MVpkMXaFkxYJUm0ydoEIP2upASF82iQOFT+nh05knNkdJWJ
        +1lsaT2sS2ddMRfnmnt9YruMfHOw6UbLM2ucWUsnhhlyI91Bc/uPQCawgwTj/01BNI7RejbTUbrzM
        758Ae9T/lAhR/U6K6/nTyX9McpGehnmORd+kJuBxBf9GqhUFRn1vKlnxFXzJ8z67DlvmnbMdUsAP1
        hRj8Mu+Ym4wOT8W5scVZK+saJ3Mk7i4SCkf6YPmrezmrHyoENImV8/j+shiNMau1S5GmNiQs+V8ce
        u7fL0mpZg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvSzE-00083v-Sc; Thu, 30 Aug 2018 19:52:12 +0000
Subject: Re: [PATCH] lib: fix three typos in Kconfig help text
To:     Thibaut Sautereau <thibaut@sautereau.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180830194505.4778-1-thibaut@sautereau.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f6a5b93b-ea49-0c95-0702-152aba7ea48a@infradead.org>
Date:   Thu, 30 Aug 2018 12:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830194505.4778-1-thibaut@sautereau.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 12:45 PM, Thibaut Sautereau wrote:
> Fix three typos in CONFIG_WARN_ALL_UNSEEDED_RANDOM help text.
> 
> Signed-off-by: Thibaut Sautereau <thibaut@sautereau.fr>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  lib/Kconfig.debug | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c7fef0c56d6b..3e50cc93572c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1277,13 +1277,13 @@ config WARN_ALL_UNSEEDED_RANDOM
>  	  time.  This is really bad from a security perspective, and
>  	  so architecture maintainers really need to do what they can
>  	  to get the CRNG seeded sooner after the system is booted.
> -	  However, since users can not do anything actionble to
> +	  However, since users cannot do anything actionable to
>  	  address this, by default the kernel will issue only a single
>  	  warning for the first use of unseeded randomness.
>  
>  	  Say Y here if you want to receive warnings for all uses of
>  	  unseeded randomness.  This will be of use primarily for
> -	  those developers interersted in improving the security of
> +	  those developers interested in improving the security of
>  	  Linux kernels running on their architecture (or
>  	  subarchitecture).
>  
> 


-- 
~Randy

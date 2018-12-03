Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ADF214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm9+7H1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ADF214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeLCLF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbeLCLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:05:57 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBF420851;
        Mon,  3 Dec 2018 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543835123;
        bh=9ETUFM2GTS+wchab/GI6GIOzbFg4pqYf10keKf0Pk54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm9+7H1oHkraXdtjuEJqLQrA9aj0g5qnLKaaoj/QgJDyfw01nCeANEFQZJzxMALVa
         DqjQkDGbUYAcBE0gviLYsOm1f63+g/ISXrNtp3JSOOTNEn0qiqG0+m3535KTWbpPRN
         OACNZAqsE6KDz0b9d93Ju692d3r2Jcy5RvvRWSmI=
Date:   Mon, 3 Dec 2018 12:05:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
Message-ID: <20181203110506.GA7485@kroah.com>
References: <20181202093257.3918-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202093257.3918-1-geert@linux-m68k.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 10:32:57AM +0100, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
> 
> Furthermore, this list is already overly long, polarizing,
> politically-laden, and reinstating the concept of human races.
> None of these is related to the goals of the Linux kernel project.
> 
> Avoid any ambiguity or political undertone by removing the list, to
> ensure "a harassment-free experience for everyone", period.

I understand the reason you and others are proposing this change,
however for now, let us stick with the text that we have.  As Linus and
I said just over a month ago, let's sit with the text we have until
something comes up that requires a change to happen.

Also, I recommend you work with the upstream developers of this text to
see if they agree with your changes here.  If they do, and update their
version, I will be glad to revisit this text at that time.

But everyone, please note that there are very specific reasons for
listing things like this.  You might not agree with those reasons, but
many other people do so each "camp" can not be happy in the end.  As we
did have 3 years without such a list of factors, perhaps it is time to
have 3 years with the list to provide a fair balance. :)

So I'm not going to accept this patch at this point in time, sorry.

thanks,

greg k-h

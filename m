Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE7BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B12147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548768772;
	bh=BYfDEct+HYUf7Tu6kJWvoCLqu0C4mB4yu3fgRDIU4Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JDKtGG6Dfw7Ul2DeIa9O9sTShzw/90GWF2LJ9ENWqPsuhDFt9YJlFSxLOfWbZmEh7
	 oiyoky6TCxcEYvTbTLlCF7czl8LczLNvvfJkAC6wrCT2EakMwLsGrG7fe2/8WznyF2
	 glbphZI/ibU6vazsg4mnBqYqhhb18u1qEOqUxVU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfA2Ncu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfA2Ncu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:32:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E2B21473;
        Tue, 29 Jan 2019 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548768769;
        bh=BYfDEct+HYUf7Tu6kJWvoCLqu0C4mB4yu3fgRDIU4Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2XTJRy40IIVhadRy1zzI76J5u274zDVBNg81KkS8sCo8sCUrzxOM+0Z2js4rbcCrJ
         U+1QikXkHELxXZex50QDvi5QE6C89YISx91fmO1Bf6wFtkXVYX7DPrAbFLL8kqppPA
         TGb6CgmqVADG12QRJuVxcuUa+qeVlzNYvkJ6BNAM=
Date:   Tue, 29 Jan 2019 14:32:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4.19 059/103] Input: input_event - provide override for
 sparc64
Message-ID: <20190129133247.GB26351@kroah.com>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113204.233323662@linuxfoundation.org>
 <A56950FD-7063-4955-8091-BE6690F6B430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A56950FD-7063-4955-8091-BE6690F6B430@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:14:30PM +0530, Deepa Dinamani wrote:
> There was another bug here that Arnd pointed out. It is fixed by 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1904961.html
> 
> You need this patch also.

Thanks, now queued up for 4.19.y and 4.20.y.

greg k-h

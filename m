Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92330C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E4720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547564387;
	bh=e4yZLe1Z5yfh+mQBLpBALV6ynm/9wpUK5z+21WdFbFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gIIpVlujQrqFUjd0Y2TQxY31EEuKv/SIgjsd+/voou4plKQ1WeKplqNzrIwXXpW4q
	 CLanFAGkTOQcjcwzL5CBFBZjsIj48+td+z8kkm3/lwGpkPQg7LXqEj0WFkRgsuamOu
	 /mESMMEvivBL+nP1fxj5LPX7AwMEt7tdSA+VMZB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfAOO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfAOO7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:59:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818F720656;
        Tue, 15 Jan 2019 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547564385;
        bh=e4yZLe1Z5yfh+mQBLpBALV6ynm/9wpUK5z+21WdFbFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy3xe2eScVU0J6tVn/tVdbcfKmmv5PX/pEuwMrX9XKtt3bhd+LDEKwmFC5Owvr7nK
         ebxN1OKVv5yiKOz4ioYGvOqYbp2k3ScwDdRZ4lMhOD2xt1IiBbfjLx/k35XsADjRdf
         jnxjvY/aRQlin0yhmAGob2lR/KHY9n7XogItAYUQ=
Date:   Tue, 15 Jan 2019 15:59:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, devel@driverdev.osuosl.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/android/vsoc: Remove duplicate header
Message-ID: <20190115145942.GA3379@kroah.com>
References: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:55:59PM +0530, Brajeswar Ghosh wrote:
> Remove linux/mutex.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/staging/android/vsoc.c | 1 -
>  1 file changed, 1 deletion(-)

This does not apply as it is already in the tree, are you sure you are
working against the latest release?

thanks,

greg k-h

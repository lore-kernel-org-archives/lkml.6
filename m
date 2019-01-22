Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674FA205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548141331;
	bh=5CCqXT0PjA//g3bPeV5fHqHiC2R1tj3jTXFVuk4KD+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L5XQ+Eoh7oPAXxt6FOggbV2Pt9BKQ8VBbv9FQR2lUVMlTsV5DNTPo6P888n/RqshO
	 SP2SPwtCbi63L9x3Ce98tW8Gjb3Jwm0xeYWOzI11VACZnGwUH+t4u5jCyyWsCwotcs
	 NRNHQcU5RZpnPszQAh8xPZKlEDXfeon0F+D49toM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfAVHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfAVHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:15:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE0B205C9;
        Tue, 22 Jan 2019 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548141328;
        bh=5CCqXT0PjA//g3bPeV5fHqHiC2R1tj3jTXFVuk4KD+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzZtY69x0MLkGCCzmHQXTy0JHy/M85Jj+H+oFdq9Pmspg6/BphBFnauO0RojXO9qa
         nd6q6z+6S1Xg5YiHg6nBnxSBq75XLeuXbVgBmlspQF7nxC2Oirhl8KUsKD2gHzsDjz
         ybpcmhUqjUF22c6FVh0hx2AgXBBYHmaRT/rxfqls=
Date:   Tue, 22 Jan 2019 08:15:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoine Robertson <antoinerbrtsn@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: moxa: Fix coding style issues
Message-ID: <20190122071526.GA6240@kroah.com>
References: <20190121224543.5150-1-antoinerbrtsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121224543.5150-1-antoinerbrtsn@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:45:43PM -0500, Antoine Robertson wrote:
> Fix coding style issues
> 
> Signed-off-by: Antoine Robertson <antoinerbrtsn@gmail.com>
> ---
>  drivers/tty/moxa.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

What changed from v1?

Always put that below the --- line, as the documentation asks you to do
so.

Please fix up and send a v3.

thanks,

greg k-h

Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EFB20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ygei0mRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EFB20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJHVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeJHVN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:13:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC75520858;
        Mon,  8 Oct 2018 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539007295;
        bh=hYl4FKT1BmtznZ8KZGuIsojX3iFGhshOUt4VFThVblA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ygei0mRDYLkN3AniZ0qktI/IOH9oISlrFMslvY6vDQ08s1JS9dl7D6Y4FecqN6g+j
         GnnvQYPoy8u/qjBvJWxPJf4+3vmk80HMIEJaWmDIHhXX7KHnwZM4nL6OpLZtDUs9aR
         3FSJUO1fCbOxza95O41QQxWDd40v2YvqthdFwSt0=
Date:   Mon, 8 Oct 2018 15:49:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Loic Tourlonias <loic.tourlonias.lkml@gmail.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: erofs: add SPDX identifer
Message-ID: <20181008134928.GA31820@kroah.com>
References: <20181008104100.2369-1-loic.tourlonias.lkml@gmail.com>
 <fe0ab9ae-3b71-7d63-053c-53b6dab95ef6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0ab9ae-3b71-7d63-053c-53b6dab95ef6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:20:55PM +0800, Gao Xiang wrote:
> Hi Loic,
> 
> On 2018/10/8 18:41, Loic Tourlonias wrote:
> > Add SPDX identifier to simplify header and remove whole license text
> > 
> > Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
> > ---
> >  drivers/staging/erofs/lz4defs.h | 23 ++---------------------
> >  1 file changed, 2 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
> > index 00a0b58a0871..bdb1022981d8 100644
> > --- a/drivers/staging/erofs/lz4defs.h
> > +++ b/drivers/staging/erofs/lz4defs.h
> > @@ -1,32 +1,13 @@
> >  #ifndef __LZ4DEFS_H__
> >  #define __LZ4DEFS_H__
> >  
> > +// SPDX-License-Identifier: BSD-2-Clause
> 
> For *.h files, it seems SPDX Identifier should be /* SPDX-License-Identifier: */
> rather than // SPDX-License-Identifier:

That is correct.

> And I think it should be placed at the first line of the line, but I am not sure of that.

Yes, it has to be the first line.

The documentation for the SPDX lines in the kernel describe all of this.

thanks,

greg k-h

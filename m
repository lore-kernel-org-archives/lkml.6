Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C632620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547564882;
	bh=qWGRp51oW4+SX3OGcJQ2GYA0ej1KXClEo0ER46y+UEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WSivg7MAoIJ5oAsfPBW0HNi313oVwCVTh6eEbjwbcr8EyOv2LgpwSSq5/nCw8ZvNc
	 pfvB4ZwIDr4ewmj1iPsFZTliEdLiT7vgAejBndfsqv+82xmM/oU+1342R5xlQm9OpB
	 iTlCFExLL92D17JEWXJI+ubtkhFNjT6lXXw+Hf9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfAOPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfAOPIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:08:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D013320645;
        Tue, 15 Jan 2019 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547564880;
        bh=qWGRp51oW4+SX3OGcJQ2GYA0ej1KXClEo0ER46y+UEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba2XxgaqW3dy5rKV59uud/3rOOcCVxDxaCkd1VVYP2yT48KgKL/sXcX0pCOtCcgFc
         265pp7w+/+sXPbtqckMA3oB6SLapn6vsXI6XoftAUjSttbf9r1CEACbDcp/BpDMBIV
         ZG1MkgvndcglSHKUZgiPJZMmEk+GrVEqEJUfiHYE=
Date:   Tue, 15 Jan 2019 16:07:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, devel@driverdev.osuosl.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/android/vsoc: Remove duplicate header
Message-ID: <20190115150757.GA4215@kroah.com>
References: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
 <20190115145942.GA3379@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115145942.GA3379@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:59:42PM +0100, Greg KH wrote:
> On Wed, Jan 09, 2019 at 08:55:59PM +0530, Brajeswar Ghosh wrote:
> > Remove linux/mutex.h which is included more than once
> > 
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/staging/android/vsoc.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> This does not apply as it is already in the tree, are you sure you are
> working against the latest release?

Ugh, my fault, nevermind...

Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F981C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C850121019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546962278;
	bh=cf5mRd1pycxTUhVu17AM3x4JWEXyk7F9srUEJIu/cFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ELjGOKctdHtgLiiiYf2ep9IOYv+G6fw0zHyWdUH2jp+4aCo8SS+NkFGrPbaLbSYu0
	 P9ec01xI7RW2kcMef6NutGzKKVtmhTBJskRsgblgPXJFDUe4XHrnKrYsdJFHFKwf9Q
	 5rRba393lGG/5wCe0yx+lXJkHBF2co4blL5Ya4FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfAHPoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfAHPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE8C20827;
        Tue,  8 Jan 2019 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546962276;
        bh=cf5mRd1pycxTUhVu17AM3x4JWEXyk7F9srUEJIu/cFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+fFbQjKkFWfnRZaYjb2Y8AvNKDR0RyNNb+RtQwr2OZeXzec8xCPhlwd/kBN/59Dk
         X6eiQQ+m8d2QHz5SDxvE4/dOS4NXWayW6gbrLnZBTInYvjmetYKRMz5ggbhQvPop8X
         ciEyfSAXS+dSLPn8Sss/FJYXGeWYAzUqQOb3sL0c=
Date:   Tue, 8 Jan 2019 16:44:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: Re: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Message-ID: <20190108154434.GA20989@kroah.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
 <20190108060426.11581-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108060426.11581-3-ran.wang_1@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:04:29AM +0000, Ran Wang wrote:
> From: yinbo.zhu <yinbo.zhu@nxp.com>

I doubt Yinbo's name has a "." in it :)

Can you please fix this up to have the correct name here?

> Remove USB errata checking code from driver. Applicability of erratum
> is retrieved by reading corresponding property in device tree.
> This property is written during device tree fixup.
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

And here.

thanks,

greg k-h

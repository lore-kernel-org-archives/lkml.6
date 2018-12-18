Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4318A2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545128902;
	bh=yoHqLLapwEdsttmIn6XgMykKW1Qyqrqr6HdoH8hf/Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PWQ2bC7Jqs+pAYj3lBcyaK2b0yEGLGXASHurAbeJg5kknJGmxn/gTJ6oXbyD3ypha
	 EuxjZYPlhgH/5p0Ah5Z/TmhnAQqYGN9uVMu8k7qLC6J0Gsk0O5LlBvbjPb+Y/DmS7b
	 GR3/ZbrThcWqOQsRNhvogYgbVEtyy08Qhunqh7hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLRK2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeLRK2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:28:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A0421841;
        Tue, 18 Dec 2018 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545128900;
        bh=yoHqLLapwEdsttmIn6XgMykKW1Qyqrqr6HdoH8hf/Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hrm3+xn6hbaXhxuUgqPIbaMJnt9EPmn0spJOamFRtDXkjj9/ME4XUNyf5Tsb9C8mU
         c9VjR7wurBdMNrFOSEn/EWQ1e6Kg1qXu/4KlMab9Snlg9LjoarajaXx0WKFEGp0jKv
         rCWelLCS3tZmXjaM72qtob8Xl3SFb9+MF3cELkJc=
Date:   Tue, 18 Dec 2018 11:28:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3]  misc/pvpanic: return 0 for empty body register
 function
Message-ID: <20181218102817.GA29083@kroah.com>
References: <1545126403-25747-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545126403-25747-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:46:41PM +0800, Peng Hao wrote:
> Return 0 for empty body register function normally.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
> QEMU community requires additional PCI devices to simulate PVPANIC devices
> so that some architectures can not occupy precious less than 4G of memory 
> space.

What is this for below the --- line?

And again, you did not specify what changed from the previous versions.
I can not take these unless you provide it.

thanks,

greg k-h

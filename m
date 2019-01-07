Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB272173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546877643;
	bh=1daLBk2rb+0p9aue38sC51iW0FONuOXGCQKFr6dpL38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ybb3iD92ii5fQD64CTVniFcPIKYivZ2u3sHYnvaPNuUbEtR+c223kXFjE1/+CiH4v
	 p0bgSsxSqdFXw4pwbRg70Gx1qb3KKUzF5+RqYLnyRtvDpzJVPIO0rJGa4xLWdVXp08
	 va5daZ8wqhGxO9rjgYCV+KmMbZj/oh/YDyynaG+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfAGQOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfAGQOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:14:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22B62147C;
        Mon,  7 Jan 2019 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546877641;
        bh=1daLBk2rb+0p9aue38sC51iW0FONuOXGCQKFr6dpL38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSBvkn8mtFJaJe4cizEwGoq5NquT22zsJvSAb3y08VrTI9hpwoBRXPCtkMxk5BL0j
         CjS1kBUhPzXP3/epuCOQnw6xy8Fr5TDSGknO8CODFUpDGFwPk+ni8v0y88kBKjr7Hz
         QGw2ajE1+OIPPXqAiRrrybXNYanK1lCren3TywGU=
Date:   Mon, 7 Jan 2019 17:13:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liujian <liujian56@huawei.com>
Cc:     xiubli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver: uio: fix possible memory leak in uio_open
Message-ID: <20190107161358.GB25694@kroah.com>
References: <1546525702-11264-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546525702-11264-1-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:28:22PM +0800, liujian wrote:
> Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
> Signed-off-by: liujian <liujian56@huawei.com>


I can not take patches without any changelog text at all :(

Also, is "liujian" your full name?  We need a real and full name for a
signed-off-by line.

thanks,

greg k-h

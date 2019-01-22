Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B55C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22D421019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548154850;
	bh=QW24MFMkT9hHcq17VGKtsGLUh7GVgB7JQuQvgz2ARhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iflIoGCkPrDKZ/bzgYJPbaAtumsDGrE4wKW4s1ADvfe1DqlD8zspdgvmPwXGY+7UK
	 /5huNZ9p+yhL5frH/yAA2A5MmGyPsnl4uxU5wapCIlADF0TuWE8EBBad1ZthbAufSF
	 +cAjzsZaAOAvXVCFOfbJToyIaYFBlmmicWKeFZT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfAVLAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfAVLAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:00:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B119F20870;
        Tue, 22 Jan 2019 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548154848;
        bh=QW24MFMkT9hHcq17VGKtsGLUh7GVgB7JQuQvgz2ARhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6L6kfluYk7Q9tnYIhLtDY8lTEdqysMm5bMYcE7vlW5VD0xWzD/7P0qp/U/8KEiz7
         iRCgibqMdyJyMdGVk4GYEHmeTDeMHrIL3gFHA4Ju007XH0291waCCGICkNq0nQoUxf
         YmKURuSGSm4wjH+/ghhEkJCKZBIL2tsVnGs6/xU8=
Date:   Tue, 22 Jan 2019 12:00:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     hamish.martin@alliedtelesis.co.nz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver: uio: fix possible memory leak in
 __uio_register_device
Message-ID: <20190122110045.GB21034@kroah.com>
References: <1546952508-186003-1-git-send-email-liujian56@huawei.com>
 <1546952508-186003-2-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952508-186003-2-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:01:47PM +0800, Liu Jian wrote:
> From: liujian <liujian56@huawei.com>

This From: line does not match your email From: line, nor your
signed-off-by name :(

Please fix up and resend.

thanks,

greg k-h

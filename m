Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D437FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0E52184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549963102;
	bh=OD3wzD6ITwDFlYphAeQYVpHhEuoCbLbqYpEO6WQc6e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NBe5ArTRQnwWNLob13kWjVA8w/kISpiQDjGk+OQOP305J+wVQ7Jk95NO/nFyUy91q
	 19eY/7mqvgfJ7uadPs3T9j46irjTJQoMI7nb4Yu45Rs76ysRHv34qEPACQ7wmpJU8B
	 9HE8dL6kO1JY4DDF/5QGvjm2EgQsXTTn6BsFltm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfBLJSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfBLJSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:18:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E649421773;
        Tue, 12 Feb 2019 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549963100;
        bh=OD3wzD6ITwDFlYphAeQYVpHhEuoCbLbqYpEO6WQc6e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOa3l+1aCekrri7Yv0ehQmxh7EYhK4k3AEPMzJcIC8QLotmaeh80y9aY5PGKLo9wt
         b0Y5r01uq0X3nuasfZGFyHNit+2w9Wrb5LzAzlMuFCkOJnYv9PERxr1fIBH8nuRjoa
         pqfY6klZAAcPC3FEuRVRcTtOdmmhxvs9EfgrsSEk=
Date:   Tue, 12 Feb 2019 10:18:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo Wang <wdjjwb@163.com>
Cc:     linux-kernel@vger.kernel.org, wang.bo116@zte.com.cn
Subject: Re: [PATCH v2] uio:remove unneeded variable ret
Message-ID: <20190212091817.GA27450@kroah.com>
References: <1548167637-2607-1-git-send-email-wdjjwb@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548167637-2607-1-git-send-email-wdjjwb@163.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:33:57PM +0800, Bo Wang wrote:
> From: wangbo <wdjjwb@163.com>
> 
> In uio_dmem_genirq_open the variable ret is unneeded,remove it now.
> 
> Signed-off-by: Bo Wang <wang.bo116@zte.com.cn>

This name does not match up with the "From:" line :(

Please fix up and resend.

thanks

greg k-h

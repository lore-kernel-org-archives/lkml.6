Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C21E2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWgaAZer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C21E2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeJQT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:57:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D3E32150D;
        Wed, 17 Oct 2018 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539777711;
        bh=dUqgWNcNrJ18NZjJSwEq/+G2UH2uh8dGycWTMQgeUIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWgaAZerO9+oMBCs72OiS0bcrpwET6YMCIQ4Rwz275jFSZqqrO0H0erxs2R0mhukh
         3F0h+l02OT2AE8SIhNfaMq4E9AeGHhWzq9cbpNusonfuYLisFkLYmGFPvLWx/Tioar
         VqKQ/V4MEn29sHvxUQGMd8yzUyL08KZF94UUkVYc=
Date:   Wed, 17 Oct 2018 14:01:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [GIT PULL] parisc fix for kernel v4.19
Message-ID: <20181017120148.GA692@kroah.com>
References: <20181017064524.GA32311@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017064524.GA32311@ls3530.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:45:24AM +0200, Helge Deller wrote:
> Hi Greg,
> 
> would you please include the trivial patch below for 4.19?
> My older cross-compiler didn't complained, so it went unnoticed for me until
> now and the faulty code was added during the 4.19 merge window.
> 
> It can be pulled from my git tree as well:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3

Now merged, thanks.

greg k-h

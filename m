Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D902083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550769639;
	bh=W59Nir6yH0saKrGzaX5q3/RjQW8oDOwY5dcwZ538V7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v8pGEbrrl/XPoV/V0YjcNgNrR2wr+9HUqhNT7J1f8S1ToWX39xyY1ZNySL6TgMdEM
	 fQS91zlSLI/6KelNGkBO8+xXmO/DWRg0FPb9KbmobbcKBMGeN9hrF7avy01EsNR3bw
	 ZrNH6SlyTdisZfkmssNa852RsxnKpX7uf6NzcBIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfBURUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBURUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:20:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7782083B;
        Thu, 21 Feb 2019 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550769636;
        bh=W59Nir6yH0saKrGzaX5q3/RjQW8oDOwY5dcwZ538V7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3FB6i8zBa7OYDrfT5ZEk6dcWyxlUlavoMB6Ryt3oU7VdoX8doB8TBqAqwAW5dJVF
         aLHpkJ5I4s4AlD/6AQUSdR6OJKKsnhIaRjdzdtE3jBbbUlcbGGfuwRUZrlLICa9Xkd
         0oICFpOBq4rSdcl+JA/N3UFMCcuORXasro+m57sA=
Date:   Thu, 21 Feb 2019 18:20:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 5.1-rc1
Message-ID: <20190221172005.GA16665@kroah.com>
References: <20190221163126.GA19338@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221163126.GA19338@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:31:26PM +0100, Johan Hovold wrote:
> The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:
> 
>   Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.1-rc1

Pulled and pushed out, thanks.

greg k-h

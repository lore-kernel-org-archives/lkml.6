Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2921773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547104113;
	bh=49O2HYw2/FTJlxu17FcLKjSAF1UAruXNTK4qOthVW6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpYubBfo8/wC/NeQ47sH7DBHWE6/R4kz85hu9eRcxuGFibc+7JlSc2LGAoYNHVSmF
	 p2uQlqXDpKfzACxEemboTvdRbDwqyJVyuFhqHDSkuHnuhkGxO2O+OfJzzspXiQME9A
	 96IMIbzTHQaQZWdlVM5+mXOYe7jerhjnRfA1Xtes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfAJHIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfAJHIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:08:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA0220665;
        Thu, 10 Jan 2019 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547104110;
        bh=49O2HYw2/FTJlxu17FcLKjSAF1UAruXNTK4qOthVW6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQLGf3xsA6EmE4vglL+o9OSQi5Hs/NVJlbWbTBV/6mWNM2jy3eGhYPRS83/ByVgjY
         qP0qyOi72YXD7dcfIpaF7DZB24wEa9e6zqIf3B2U3+/n6kpuPhWrZPkuodie9aP9yV
         DMls4+SrLFK+ye94U+p90p7NV/JbUyopl/hQj/rI=
Date:   Thu, 10 Jan 2019 08:08:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [GIT PULL] lkdtm updates for -next
Message-ID: <20190110070828.GA13398@kroah.com>
References: <20190109201240.GA33464@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109201240.GA33464@beast>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:12:40PM -0800, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these lkdtm changes for next (into, I assume, your
> drivers-misc tree).

Now merged, thanks.

greg k-h

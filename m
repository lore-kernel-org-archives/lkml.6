Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44E0206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545054645;
	bh=A8PmSTwNMdu//SmQOadjpNpNM71FU6rwYu6Id0fxgQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hDpzZ0VvY4BlDrV1ef2EaaHiEJf40EmL4oZdWmo+kwSJ/vbn1hyApPBkKkRRVOzIl
	 z3KSsesvLtRfqS3jpEGJZJMeuLUjt3O0M8YmQZWl51cPuJLfJ29ibYBfNt9IRv5fIg
	 4tYE3TdfblCUtmWQDS8FfCn269oD65Ci1HX920Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeLQNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeLQNum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:50:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089B32145D;
        Mon, 17 Dec 2018 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545054641;
        bh=A8PmSTwNMdu//SmQOadjpNpNM71FU6rwYu6Id0fxgQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/gv7J/UNGG5I0A+ycCYAgrmbFCEaaAtL5YNnOFkDECA8ikfBi+PwqLZwq/Ed8+77
         3JKSXGDPoQuLROsi36qfxFWwpl0y0Q8dK4xcTpxExs5tk2L0ThxsWhFrLnLaWmOVhJ
         2g6h+ZHI6FwJ/F8zzSQTKWmF4/gnA1MHVTSqjkrU=
Date:   Mon, 17 Dec 2018 14:50:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] staging: rtl8188eu: cleanup declarations in
 rtw_mlme_ext.c
Message-ID: <20181217135039.GA28400@kroah.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 05:46:08PM +0100, Michael Straube wrote:
> Replace tabs with spaces and/or remove spaces in declarations.
> Remove unused/commented declarations, remove unnecessary comment,
> remove blank lines between declarations and add missing lines after
> declarations. Also clears some line over 80 characters checkpatch
> warnings.

That is a lot of different things to do all in one patch :(

Please break this up into "one logical thing per patch" please, so it
can be reviewed easier.

thanks,

greg k-h

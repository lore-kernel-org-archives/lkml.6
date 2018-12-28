Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11892146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546012031;
	bh=9JOYIYfitbYS+RaVPp3ZthM/0D/Km3dgCFixwFBmZR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mo8XJU34qnvYhgBCTpJRUH7z5Zs5aep3VoZAQmrLsY8v3CKqDSjbfCh8QqAGuJw9j
	 Bf9Gz/y8rs9SsSHnIfLDQJ0S2Q/EkQvKD9JQX0l4occyw86IQVq7TbkKuPh6EstDwD
	 Yf+gCxbanzzZSSUVI+1+PxPM3lSRS0ejZWpuKVtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbeL1PrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeL1PrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:47:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D2420879;
        Fri, 28 Dec 2018 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546012029;
        bh=9JOYIYfitbYS+RaVPp3ZthM/0D/Km3dgCFixwFBmZR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEoMDSQ+WsxiApae7SPiRMQKo1mTZ6HkGwI4/hNyJ2PcxULxcnbPcdueX9O0rw7b+
         9xYYE/IA3LFQOq1LiJV1VhwBX5Bnb9PMFPExhNbd231CzWZrnogwfbjft4Qo4tBDzj
         Omc/fOsw8qCievvcQsOXQB+YJGJr8NuG5o8Um4so=
Date:   Fri, 28 Dec 2018 16:47:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.21-rc1
Message-ID: <20181228154707.GA26161@kroah.com>
References: <20181228153531.GA23672@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228153531.GA23672@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:35:31PM +0100, Greg KH wrote:
> The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> 
>   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.21-rc1
> 
> for you to fetch changes up to 215852f4b8bbf7a8d6a534dfb367bb0f1a2d5011:
> 
>   staging: mt7621-mmc: Correct spelling mistakes in comments (2018-12-20 18:11:58 +0100)

There will be conflicts with two files in your tree now with this pull:
	drivers/staging/media/tegra-vde/tegra-vde.c
	drivers/staging/vboxvideo/vbox_ttm.c

both resolutions should be trivial.  If not, let me know.

thanks,

greg k-h


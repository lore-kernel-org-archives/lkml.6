Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAE120855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW5zOfUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAE120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKZR5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbeKZR5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:57:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2664C20672;
        Mon, 26 Nov 2018 07:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543215838;
        bh=JAbBTnZ+vBmAJqpOGQq47WR5RmTWF8SELjVOPF/cLWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HW5zOfUpDHFBHsCmddGZZZKTs/52DYQzHhfxLF30zAW8EZBuX+SfsJkH/AKnEVE8n
         eN1iKqgQKmJpei/NTuTc/aUncKPEZdSeGSe1Z9G2xOLcMLVbAjm03fS8GBgT5DL7lt
         m7n8LyrKmjTS8PUJFh7AsSR+c/FqpImPrkeXU0Vg=
Date:   Mon, 26 Nov 2018 08:03:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] FSI fixes for 4.20
Message-ID: <20181126070348.GC9680@kroah.com>
References: <b0960d55bb1895253caefe942f8065ac84213267.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0960d55bb1895253caefe942f8065ac84213267.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:37:08AM +1100, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> Here are two very minor fixes for FSI. One from Arnd is a Kconfig fixup
> and has been rusting away in my tree for a while (I had forgotten about
> it). The other one just removes a duplicate #include, courtesy of
> Brajeswar Ghosh.
> 
> The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:
> 
>   Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-11-26

Now pulled, thanks.

greg k-h

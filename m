Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF76820879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544610831;
	bh=e77rAmibzXjl4N1dIz50bpJuI36/JkdMqVTNhUu+YNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lshaFbHsjqUvU6PnHW5FFZSANTOLcueGdoAohwDWzurW/b0HOV+/io2jo6Cv4FGk8
	 adk94TOhq0U9RNX55+QlHeOl8TgWh88xU6pxCuSphp6yu3sUMX1YIypkpxGR9W8/ZG
	 6PUcQsxorZ7bxR9ghbJnuaGFtM91Pu5YGZ6tttX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF76820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeLLKdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeLLKdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:33:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C138F2086D;
        Wed, 12 Dec 2018 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544610829;
        bh=e77rAmibzXjl4N1dIz50bpJuI36/JkdMqVTNhUu+YNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caDuud3CWYdlyCjgqwXtEENU4ceWeKs/vmhwXuhqh4NuTAAEyshv8xy33kBItuRe6
         vegGf+6t6wwuxuMYX613178Qnnwas7MpW7IzjNFQQ4eDw7zI1WlBPAoQVsWWn6GYI5
         PwYCMj94o1Ku1E7Y4Avy0mP2dRo1/kuMnm3Qzmx8=
Date:   Wed, 12 Dec 2018 11:33:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yuhui zhang <zhangyuhui89757@gmail.com>
Cc:     matthias.bgg@gmail.com, sergio.paracuellos@gmail.com,
        neil@brown.name, mamtashukla555@gmail.com, peter.vernia@gmail.com,
        blogic@openwrt.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] staging: mt7621-pci: Fix checkpatch errors
Message-ID: <20181212103347.GA16458@kroah.com>
References: <CALT5DkvTHn=TO5TDd+_qiNobkukdQ=M1zhRatOHD3QCbBkes4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALT5DkvTHn=TO5TDd+_qiNobkukdQ=M1zhRatOHD3QCbBkes4Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:23:06PM +0800, yuhui zhang wrote:
> This patch fixes the following checkpatch.pl errors in the
> drivers/staging/mt7621-pci:
> ERROR: space required after that ')'.
> ERROR: space required after that '='.
> 
> Signed-off-by: zhangyuhui <zhangyuhui89757@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You sent this same patch 4 times.  Or at least I think it is the same
patch, I really do not know...

Please resend, properly, to the correct mailing lists and people, this
patch only one time.

Also, you need to fix up your from: and signed-off-by lines to match up.

thanks,

greg k-h

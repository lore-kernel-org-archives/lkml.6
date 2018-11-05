Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBECC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830552086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZKga0Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830552086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeKEXpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKEXpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:45:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32E82085A;
        Mon,  5 Nov 2018 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541427908;
        bh=xnaCTcTd6MKr6tKXiqbLUdjiiC8sQ7sbf2w727DuFpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZKga0SinenTpMknKbfo3RffubS6AO6MliLVROiUnM/di4ybVNKK+FrCA/0ua7p0f
         greSbyalWNAH40/lkngKWVN26k3sszeGNzJj4BxH5/OuzDoTzYmw2CiBS7l/llMpps
         WFVHD/Cn8UcMwuHF2gNu1jKzJLyGxLopBDcqkX+o=
Date:   Mon, 5 Nov 2018 15:25:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        natechancellor@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fix some typo
Message-ID: <20181105142506.GB4352@kroah.com>
References: <20181102125332.24421-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102125332.24421-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:53:32AM -0400, Yangtao Li wrote:
> ture->true
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Change in v2:
> -add changelog
> ---
>  drivers/staging/rtl8712/rtl871x_cmd.h       | 2 +-
>  drivers/staging/rtl8723bs/include/rtw_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

One patch per driver please.

thanks,

greg k-h

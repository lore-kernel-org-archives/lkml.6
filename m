Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 213CEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC573208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNtgPn0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC573208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965784AbeFOLIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965768AbeFOLIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:08:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DFB208B2;
        Fri, 15 Jun 2018 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529060922;
        bh=u6hGM5U9VxWb0PHa2QTVy66thIF2J8hEEZcXM3MC+uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNtgPn0bbyHzTOJ7FSQ0fdvPgOjJv+2c2sYG3vUozf8s7H6QRGqv+RW0EarHHspN4
         ehnJU3VA6ellk4T5sEhwmbc99kVNoenwvaUqNGpA2RgvuMm3OlY63fbq74yVaGHnT+
         1HYdi1Z8grP4Kb/aubiXEmj5783HqqV7aJSsO/Sc=
Date:   Fri, 15 Jun 2018 13:08:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     thtlwlsmsgkfla@gmail.com
Cc:     devel@driverdev.osuosl.org, keescook@chromium.org,
        johannes.berg@intel.com, tvboxspy@gmail.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linyu.Yuan@alcatel-sbell.com.cn, colin.king@canonical.com,
        davem@davemloft.net
Subject: Re: [PATCH 1/2] staging: rtl8192e: remove brace for single statement
Message-ID: <20180615110820.GB14855@kroah.com>
References: <1986308.HpuS17FQ0J@os-virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1986308.HpuS17FQ0J@os-virtualbox>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 03:05:56PM +0900, thtlwlsmsgkfla@gmail.com wrote:
> * fix checkpatch.pl warning:
>   WARNING: braces { are not necessary for single statement blocks
> 
> Signed-off-by: Hyunil Kim <thtlwlsmsgkfla@gmail.com>

This does not match your "From:" line in your email headers :(


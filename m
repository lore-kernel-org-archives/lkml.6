Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F56E22507
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq+Ojt9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F56E22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeKMJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeKMJjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:39:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4450D22419;
        Mon, 12 Nov 2018 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542066240;
        bh=X1x401ojOqBi79ZZtxEnmEVlDWLOmjY/y+WdfcPKXU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq+Ojt9C1z830rnHuEvq3ayf1XrIpQqD4SePyzQq4qRZ0ZiKFQJ3YEU8ZMMXjxbfh
         /csi9wcXXiLnlOm8a7K2oQgxi1Nc/fOihNm47iTBx/kzcTZa1pb3ZbwN9EMHdPOece
         yEp/c7a3i3JgFGJpeD0RNIz6c8KmmSQmR61af9K8=
Date:   Mon, 12 Nov 2018 15:44:00 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: rtlwifi: Add new line to stay in 80
 characters
Message-ID: <20181112234400.GA16079@kroah.com>
References: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:18:56AM +0100, Cristian Sicilia wrote:
> The parameter is sent to next line to stay in 80
> characters
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/rtlwifi/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

You sent two 1/1 patches, shouldn't this be a patch series of 2 patches
ordered properly?

Please fix up and resend.

thanks,

greg k-h

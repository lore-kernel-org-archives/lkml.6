Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F42C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBF20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvUoxOK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBBF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKBCqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeKBCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:46:43 -0400
Received: from localhost (unknown [95.99.172.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7475C20657;
        Thu,  1 Nov 2018 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541094167;
        bh=2Zksyttm/TFnOxzH6XvCfqhxDMlYLjH0ZTQlnuA+/WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvUoxOK6K8L+eAGgysX6XIglAGNM6HlSPoCP99QZ5U7l32W/6XR73t2YdewB2s/GR
         lfHZs6stU/HODtf8oWKdqUT2wCYrjXsHQx9dG3FtEGcPG9PT8pqlP3oA5jygfjD9zQ
         7vyUToCnTRjG9FGcT9gHs81jpwofMdgkrQDg1eyM=
Date:   Thu, 1 Nov 2018 18:41:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        natechancellor@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fix some typo
Message-ID: <20181101174123.GA5251@kroah.com>
References: <20181101154838.23220-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101154838.23220-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:48:38AM -0400, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_cmd.h       | 2 +-
>  drivers/staging/rtl8723bs/include/rtw_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

No changelog?

Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419AD2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545052532;
	bh=x3jyP2KTcKJlt3739gG4CoO5DZbUmks1o+FgFnoFd0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bFku5NRDdQ8MoE/RjZbyZdUAMkEZSkKeJRwDgWEK4IDU0vOM03g78nLiHDpgiwG9d
	 BJP20ikVPuQ6A67EpmM6huB6xDgBNnzcSOJcSDKVOqKmFUnEvq/JNIdwKKkuF3LDbR
	 SyblVUiqAghJo/SD8CEpIs1+kd5t0zaYQ4NK96BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeLQNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbeLQNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:15:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CED2133F;
        Mon, 17 Dec 2018 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545052529;
        bh=x3jyP2KTcKJlt3739gG4CoO5DZbUmks1o+FgFnoFd0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hmN+gUDFMEL4YgAlMc93OjWQ47sUODAGSw7adP8n5aiuwVUzg6DlYmlJLBCtpJP1
         2yeFSLZBfCY1AnLaehx/enSp9u18lWT0clGxcgkNFQistKlGRt29UwIGy8Ngp37Mo/
         9ON58ZplBNgM05I9jlLiefEsPzOIadp7oNvJgMnM=
Date:   Mon, 17 Dec 2018 14:15:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     marvin24@gmx.de, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ac100@lists.launchpad.net
Subject: Re: [PATCH 1/2] Staging: comedi: cb_pcidas: fixed a spelling mistake
 coding style issue
Message-ID: <20181217131527.GA12317@kroah.com>
References: <1544979445-10079-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544979445-10079-1-git-send-email-indigoomega021@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 08:57:25AM -0800, Amir Mahdi Ghorbanian wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You already sent this patch, right?

What changed from the previous one?

confused,

greg k-h

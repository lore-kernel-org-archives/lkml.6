Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C4DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF932085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfegJ2h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF932085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeKEXoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKEXoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:44:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D632085A;
        Mon,  5 Nov 2018 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541427886;
        bh=7taWxtC/V9svKJ3Xv0JYOrYa8Yv0LR+9HTJQToUa0mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfegJ2h2A5jbWyCaGxKhNHN4uo6d/MXh1rZHFt7XSIkGplbfSlIwjOyPPM1Az7C9D
         JwCNgpB+fZ/sV0g2SRH5Ay8vdq3PSNpPR6kWoip8XbVOWE0Q8kG4QxPLiSs8TLpEo/
         UlkMkUazThbDP1gUnxWuKFlvYqcHN4ZYZa9avrEw=
Date:   Mon, 5 Nov 2018 15:24:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     forest@alittletooquiet.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fix small typo
Message-ID: <20181105142444.GA4352@kroah.com>
References: <20181101155251.23330-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101155251.23330-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:52:51AM -0400, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can not accept patches without any changelog text :(

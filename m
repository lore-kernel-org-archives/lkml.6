Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED2B22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ6ePSa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2B22504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeKMFgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbeKMFgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:36:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7AF20817;
        Mon, 12 Nov 2018 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051722;
        bh=aZlbvYMH/OCRJ1ndcyrFLz+ecRURxk1bUB2dtWyc8jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJ6ePSa9IwZ9p5vEZHEUnVG6nb7oLkoXwxHr4sJmscUEbgznKfnA8AdgyGJuhPqx0
         pfZUMjUfHEKFdZp5bPYdTlvTJ0P+UjnvLBSJx7ZtTP1Bd5fd9WUbEaUVDt1lEstyFI
         +WGO4Xz4pfSu6MS78ThCgkAJpXZG6zbsxU1et7Jk=
Date:   Mon, 12 Nov 2018 11:42:01 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Diego Viola <diego.viola@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
Message-ID: <20181112194201.GA2849@kroah.com>
References: <20181112192252.3911-1-diego.viola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112192252.3911-1-diego.viola@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:22:52PM -0200, Diego Viola wrote:
> med_power_with_dipm still causes freezes after updating the firmware to
> the latest version (DXT04L5Q).
> 
> Set model_rev to NULL and blacklist the device.
> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

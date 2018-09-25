Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51375C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051B02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051B02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeIZA4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:56:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeIZA4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:56:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37E8F107C;
        Tue, 25 Sep 2018 18:47:59 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:47:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Williams <zero@zeroaptitude.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: control.c: fixed some coding style
 issues
Message-ID: <20180925184756.GB16455@kroah.com>
References: <20180920123828.22059-1-zero@zeroaptitude.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920123828.22059-1-zero@zeroaptitude.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:38:28PM +1000, Aaron Williams wrote:
> fixed some "Alignment should match open parenthesis" checks.
> Signing up for the kernel clean up crew while I learn C
> 
> Signed-off-by: Aaron Williams <zero@zeroaptitude.com>
> ---
>  drivers/staging/greybus/control.c | 39 +++++++++++++++----------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/greybus/control.c b/drivers/staging/greybus/control.c
> index 35f945a12b11..f8f0aee224c8 100644
> --- a/drivers/staging/greybus/control.c
> +++ b/drivers/staging/greybus/control.c
> @@ -15,7 +15,6 @@
>  #define GB_CONTROL_VERSION_MAJOR	0
>  #define GB_CONTROL_VERSION_MINOR	1
>  
> -

This change does not match your changelog text :(


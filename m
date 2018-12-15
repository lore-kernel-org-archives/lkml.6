Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510A2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeLOQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:53:12 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:48560 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbeLOQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:53:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0DC691800226A;
        Sat, 15 Dec 2018 16:53:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: song55_72d5028983547
X-Filterd-Recvd-Size: 2583
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Dec 2018 16:53:08 +0000 (UTC)
Message-ID: <2f878988b8b9fec09f3fae8e1ec5ddba89ebc6f7.camel@perches.com>
Subject: Re: [PATCH 1/9] staging: rtl8188eu: cleanup declarations in
 rtw_mlme_ext.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 15 Dec 2018 08:53:07 -0800
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-15 at 17:46 +0100, Michael Straube wrote:
> Replace tabs with spaces and/or remove spaces in declarations.
> Remove unused/commented declarations, remove unnecessary comment,
> remove blank lines between declarations and add missing lines after
> declarations. Also clears some line over 80 characters checkpatch
> warnings.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
[]
> @@ -22,14 +22,14 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>  /**************************************************
>  OUI definitions for the vendor specific IE
>  ***************************************************/
> -unsigned char	RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
> +unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
>  unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
> -unsigned char	WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
> -unsigned char	P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
> -unsigned char	WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
> +unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
> +unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
> +unsigned char WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
>  
> -unsigned char	WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
> -unsigned char	WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
> +unsigned char WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
> +unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
>  
>  unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
>  unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};

unrelated trivia:

Might be nice to make some or all of these const or
even static const where appropriate.



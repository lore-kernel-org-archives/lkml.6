Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24639C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD6C208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD6C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeJPTdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:33:37 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:49115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726760AbeJPTdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:33:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 42C84837F27F;
        Tue, 16 Oct 2018 11:43:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet99_1ec7ac17dd41e
X-Filterd-Recvd-Size: 1963
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 11:43:31 +0000 (UTC)
Message-ID: <249981aa5af26de07565946fbe806e3c01f26c07.camel@perches.com>
Subject: Re: patch "staging: MAINTAINERS: remove obsolete IPX staging
 directory" added to staging-testing
From:   Joe Perches <joe@perches.com>
To:     gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Date:   Tue, 16 Oct 2018 04:43:30 -0700
In-Reply-To: <15396867728666@kroah.com>
References: <15396867728666@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 12:46 +0200, gregkh@linuxfoundation.org wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     staging: MAINTAINERS: remove obsolete IPX staging directoryts
[]
> From dd71c89b2c1ae049d2018107e9d7a41261db3f7b Mon Sep 17 00:00:00 2001
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Tue, 16 Oct 2018 12:45:13 +0200
> Subject: staging: MAINTAINERS: remove obsolete IPX staging directory
> 
> The IPX code was removed from staging back in November 2017, but the
> MAINTAINERS entry stuck around.  Remove the invalid directory from the
> file as it does not actually point to anything anymore.

As the uapi ipx file still exists but the functionality
has been removed, perhaps some compiler message like

#pragma message "IPX functionality removed as of linux kernel v4.18"

should be added to the uapi file.

> diff --git a/MAINTAINERS b/MAINTAINERS
> []
> @@ -7672,7 +7672,6 @@ IPX NETWORK LAYER
>  L:	netdev@vger.kernel.org
>  S:	Obsolete
>  F:	include/uapi/linux/ipx.h
> -F:	drivers/staging/ipx/
>  
>  IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
>  M:	Marc Zyngier <marc.zyngier@arm.com>


Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7257C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6079F21745
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6079F21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHNEUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:20:34 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:43683 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbeHNEUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:20:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A853A18022D00;
        Tue, 14 Aug 2018 01:35:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seat20_4f23d611c5a48
X-Filterd-Recvd-Size: 1524
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 01:35:43 +0000 (UTC)
Message-ID: <000cca42c7f8379213113a15864c6148c4458b1a.camel@perches.com>
Subject: Re: [PATCH 1/9] platform: goldfish: pipe: Fix comments to fit 80
 columns
From:   Joe Perches <joe@perches.com>
To:     rkir@google.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Date:   Mon, 13 Aug 2018 18:35:42 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
References: <20180813233839.190855-1-rkir@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 16:38 -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> Some comment lines are longer than 80 symbols.
[]
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
[]
> @@ -84,7 +84,10 @@ enum PipePollFlags {
>  	PIPE_POLL_HUP	= 1 << 2
>  };
>  
> -/* Possible status values used to signal errors - see goldfish_pipe_error_convert */
> +/*
> + * Possible status values used to signal errors - see
> + * goldfish_pipe_error_convert

If this is to be wrapped at all, and this really doesn't
need to be wrapped, it would probably be more sensible as:

/*
 * Possible status values used to signal errors
 * see: goldfish_pipe_error_convert
 */


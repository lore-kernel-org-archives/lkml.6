Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC02F206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC02F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDB1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:27:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:27:43 -0400
Received: from localhost (unknown [104.132.0.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF78EC11;
        Wed,  3 Oct 2018 18:38:09 +0000 (UTC)
Date:   Wed, 3 Oct 2018 11:38:08 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxime Desroches <desroches.maxime@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] Staging: rts5208: rtsx_card.c: Fixed all braces
 issues of the file
Message-ID: <20181003183808.GA23132@kroah.com>
References: <20181002231126.10352-1-desroches.maxime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002231126.10352-1-desroches.maxime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 07:11:26PM -0400, Maxime Desroches wrote:
> Fixed all the braces issues of the rtsx_card.c file
> 
> Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_card.c | 96 +++++++++++------------------
>  1 file changed, 37 insertions(+), 59 deletions(-)

None of the patches in this series applied to my staging-next tree at
all :(

Always work against either linux-next, or my staging-next tree when
submitting patches so you do not duplicate work others have already
done.

thanks,

greg k-h

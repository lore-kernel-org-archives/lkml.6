Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814DAC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308AA2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308AA2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJCFCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:02:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCFCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:02:11 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 944BFB79;
        Tue,  2 Oct 2018 22:16:37 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:16:36 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v5 1/3] staging: mt7621-mmc: Remove #if 0 blocks
Message-ID: <20181002221636.GA8586@kroah.com>
References: <cover.1538402548.git.nishadkamdar@gmail.com>
 <b0ae4cb302d68d2fb0f6584bd8ecc8043f88845c.1538402548.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ae4cb302d68d2fb0f6584bd8ecc8043f88845c.1538402548.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 08:13:40PM +0530, Nishad Kamdar wrote:
> This patch removes #if 0 code blocks and usages of
> functions defined in the #if 0 blocks.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/dbg.c |  21 +--
>  drivers/staging/mt7621-mmc/dbg.h |  14 --
>  drivers/staging/mt7621-mmc/sd.c  | 269 -------------------------------
>  3 files changed, 1 insertion(+), 303 deletions(-)

This patch did not apply :(

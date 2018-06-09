Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NzVNI2HeG1ueWAAAmS7hNA
	; Sat, 09 Jun 2018 14:05:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AC7C9608BF; Sat,  9 Jun 2018 14:05:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGOvy3KV"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 417DD607BB;
	Sat,  9 Jun 2018 14:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 417DD607BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeFIOFw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753175AbeFIOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:05:51 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C012087B;
        Sat,  9 Jun 2018 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528553150;
        bh=/OGy1mlXahGUOTTMJLhDJVmcMTHJVhIjDtRalzCo6uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGOvy3KVT5eETyb0G6VKOht/ORrV6ZYPWUdZk8bTS//R/Uta96BovamTX8IdG2kQv
         MBbXDO/oNwrysRRi9gqKO+hJobYlaBrg3AAQKspab763ex83bkLcnOTfRejsJNP/YH
         ihkl08w+mw+jSPkp1bsyHeuGRD8pJs/5IA3pdiMs=
Date: Sat, 9 Jun 2018 16:05:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Opperman <eklikeroomys@gmail.com>
Cc: devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180609140527.GC28854@kroah.com>
References: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 04:23:21PM +0200, Chris Opperman wrote:
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
> ---
>  drivers/staging/comedi/drivers.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

I can not take patches without any changelog text at all :(

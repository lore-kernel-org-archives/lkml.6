Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96835C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E012250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g19lVrXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E012250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbeKMLFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMLFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:05:21 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F41F122419;
        Tue, 13 Nov 2018 01:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542071380;
        bh=GHT/bXv1468iqKTt3p/CnIDGVl203FMPH5pec6Qlbwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g19lVrXVl4Hnvi1dPVr+P3GW1os47EEPVOSlXELVyXTwguxe59tM5MLNezDoU5BGL
         0Gn0Vc/Lqj5/GSI8jawxKx6MZU+lSF3m2W4MulWDJmADEf+vm8jPbVmurRtbykGj0n
         o49oiXqp43ywqxYe8IliKXuU1Da6YZNmtaZNbUVA=
Date:   Mon, 12 Nov 2018 17:09:39 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Arnold Chand <arnold.chand@gmail.com>
Cc:     "eric@anholt.net" <eric@anholt.net>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vc04_services: bcm2835-audio: Fixed
 warnings, checks
Message-ID: <20181113010939.GB20883@kroah.com>
References: <46bb5564b6bd6cad78c01b4d8026c7c72a870b15.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46bb5564b6bd6cad78c01b4d8026c7c72a870b15.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:45:00PM -0500, Arnold Chand wrote:
> Corrected warnings and checks provided by scripts/checkpatch.pl which
> includes: alignment of parenthesis, lines over 80 characters and mutex
> definition without comment.
> 
> Signed-off-by: Arnold Chand <arnold.chand@gmail.com>
> ---
>  .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 18 +++---
>  .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 25 ++++----
>  .../bcm2835-audio/bcm2835-vchiq.c             | 59 ++++++++++---------
>  .../vc04_services/bcm2835-audio/bcm2835.h     |  4 +-
>  4 files changed, 56 insertions(+), 50 deletions(-)

What changed from v1?  Always put that below the --- line.

v3?  :)

thanks,

greg k-h

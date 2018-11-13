Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA54C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE67122507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVxdR4rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE67122507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeKMKEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:04:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6822224E0;
        Tue, 13 Nov 2018 00:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542067732;
        bh=7GCJ1cITumJ3R3NRqaiwgo95hTe9ppTWpkDiNRxe9IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVxdR4rKRB3lSPWNpDuH2RpwdB0mnm9igtPAhsOnl8yGdoqEYUJd+FTikUJOUEAih
         NPh1WgQ2vYizWi0DckVaa9u2JIfkiPiDgLNaoRwX87qQpz4Rv8zkTBZ1DEXlR2YD5A
         +YgwsjGGVcEl9EQyEleyHWRboCubZH5OClTdlzP8=
Date:   Mon, 12 Nov 2018 16:08:52 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Arnold Chand <arnold.chand@gmail.com>
Cc:     "eric@anholt.net" <eric@anholt.net>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: bcm2835-audio: Fixed warnings
Message-ID: <20181113000852.GA17358@kroah.com>
References: <1650188556670803023de0df9040efea86258b3c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650188556670803023de0df9040efea86258b3c.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:00:20PM -0500, Arnold Chand wrote:
> Fixed warnings provided by checkpatch.pl

Please be much more specific as to what you changed or "fixed".

Please fix this up and resend.

thanks,

greg k-h

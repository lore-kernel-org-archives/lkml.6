Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750C4218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548269411;
	bh=JBeuA2xsxi2orlBoECB5sIP+sVatT2Do5IPVV+CfcjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hFgWK7V/6eiqsjAnelWYn97J7xZKkja/sgy9aBnun5MOr//bYeaVYAQx4G8l9QNEW
	 GYm2calESsQ3y/QRCDxhDIe1gCShSxXy3B9BRpN9vqbHIlFZXb/obUNqvudQbBWeRr
	 ukxQt4FOLgrhmgo+OLF7e9eTl9of5WNuTdLJOQo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAWSuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:50:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfAWSuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:50:09 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF8021855;
        Wed, 23 Jan 2019 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548269408;
        bh=JBeuA2xsxi2orlBoECB5sIP+sVatT2Do5IPVV+CfcjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZaD4ObUCywPijIdnzsYA5PawGMQ5Fz1jr835hZ5NPosFxb63pumIuKNpJjDxCL0y
         YXrVLOOYz/Ch52u33HbLhtWPOOZyuVQxvLI/O6z+I0Dod0ZkhcNT2ZOp+2+urU1pMy
         nKeQIBQ08zmks2x2IX7ONTuadGA+ukpgRuxS5p6E=
Date:   Wed, 23 Jan 2019 13:50:07 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, ruizhao@microsoft.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, will.deacon@arm.com, okaya@kernel.org
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Message-ID: <20190123185007.GP202535@sasha-vm>
References: <20190118162324.17123-1-sashal@kernel.org>
 <20190121123547.GF29166@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190121123547.GF29166@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:35:47PM +0100, Borislav Petkov wrote:
>On Fri, Jan 18, 2019 at 11:23:24AM -0500, Sasha Levin wrote:
>> From: Rui Zhao <ruizhao@microsoft.com>
>>
>> New driver supports DRAM error detection and correction on DMC520
>> controller.
>
>That's this thing, right?
>
>https://developer.arm.com/products/system-ip/memory-controllers/corelink-dmc-520

Yup!

>> Validated on actual hardware:
>
>Which is what exactly?

A variant of a Broadcom's SST100 board.

--
Thanks,
Sasha

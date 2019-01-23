Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8C2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kSdJ3cFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAWTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:04:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41466 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAWTEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:04:02 -0500
Received: from zn.tnic (p200300EC2BCA6A00F4913A0531746803.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:6a00:f491:3a05:3174:6803])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F1591EC0229;
        Wed, 23 Jan 2019 20:04:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548270240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u/6zEDJU+7cnPbVRr77ODnKvabMOu/CqhUbKN6kH7gI=;
        b=kSdJ3cFUQbvI02yf+0boAG7bmrYnaK4t75rEHPz1y7B013jeh0CnuwXUz6M6taPwCgiR8a
        t5u8zTx3GZK+FBWG6/JWiLOawD1sVJa74icnGJtF00ZJIm1mSwRA7Z7PQvoiQDsgChPWEA
        FnaOpg0Tlv3dl82mlP1gHsA93iM0zbc=
Date:   Wed, 23 Jan 2019 20:03:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     mchehab@kernel.org, ruizhao@microsoft.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, will.deacon@arm.com, okaya@kernel.org
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Message-ID: <20190123190353.GE3227@zn.tnic>
References: <20190118162324.17123-1-sashal@kernel.org>
 <20190121123547.GF29166@zn.tnic>
 <20190123185007.GP202535@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190123185007.GP202535@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:50:07PM -0500, Sasha Levin wrote:
> A variant of a Broadcom's SST100 board.

Is that some platform which people will use and run linux on and thus
would make sense to have an EDAC driver for or is this something
devel-only toy thing?

Searching a bit doesn't tell me a whole lot except some enablement for
some stingray SOC reference board...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

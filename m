Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WhM26Nli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfBZRrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:47:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37256 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:47:14 -0500
Received: from zn.tnic (p200300EC2BCDB200F19C36A0CFFF8AC0.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:f19c:36a0:cfff:8ac0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3611B1EC0354;
        Tue, 26 Feb 2019 18:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551203233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yECRnf9xHA+bF8UOcSdNEYGxwopzM0d+sVOWkJpRWKM=;
        b=WhM26NliI79ALDctbwpTCK4XPu1Mgs8ha9YfOQDpFPBAPiqZJd+FbfehLbYvY9WpOUtAOH
        VqucDrxVnmGI0BXFsUVv1kHvi0/Cd+de37AUFziUIPvq5o7fv1ga5Tm20nGTiLKOl99zaG
        Gf0X/fvpS4ZIXSCe27mnLpNb2TM2dpA=
Date:   Tue, 26 Feb 2019 18:47:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     thor.thayer@linux.intel.com, linux@armlinux.org.uk,
        mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Message-ID: <20190226174705.GF14836@zn.tnic>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
 <20190225204244.GJ26145@zn.tnic>
 <17733148-82fd-e119-3525-c2d580fabc99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17733148-82fd-e119-3525-c2d580fabc99@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:59:43AM -0600, Dinh Nguyen wrote:
> If you don't mind, I'll take the defconfig patch to avoid any conflicts.

Ok, thanks. Applied the first one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

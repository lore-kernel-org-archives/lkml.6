Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B02177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MkCc7Sif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfBSNuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:50:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:50:08 -0500
Received: from zn.tnic (p200300EC2BCDC800C58ECA98EDA20EC9.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:c800:c58e:ca98:eda2:ec9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A9FB1EC038F;
        Tue, 19 Feb 2019 14:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550584207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hMMsthxUAhA6hTqzqSgLbL2D/neNfkUCSn0Hhx9jDcY=;
        b=MkCc7SifxX/797iCERsUDd/ZD2asAd7qtFmc1x+gC3gpsmbFAwYY8Q8OQGd/jmtK+tnGE+
        oB5QJmNYO5IqbDVBR7vP3S4GfYeXX6/2Sd/fPuyQb9Ky9BBJXTotYeUgzrU3DKQTakwRWb
        XLa60xAtKPy96zZRnIQ9hyQtiIX7R7c=
Date:   Tue, 19 Feb 2019 14:50:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 0/2] Fix crash in cper_estatus_check()
Message-ID: <20190219135004.GC19514@zn.tnic>
References: <20190128100424.30278-1-ross.lagerwall@citrix.com>
 <2534482.fmfRlZkPUo@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2534482.fmfRlZkPUo@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:00:49AM +0100, Rafael J. Wysocki wrote:
> Boris, any comments here?

For both:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1943D21A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DL4psxFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392641AbeLVRkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:40:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391670AbeLVRkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:40:47 -0500
Received: from zn.tnic (p200300EC2BD1800084260E574037D059.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:8426:e57:4037:d059])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4E371EC0958;
        Sat, 22 Dec 2018 12:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545479090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KMd4LVsZ76H5MjJvkbm14bUfh7gaUd6nMYJZb0k5hFc=;
        b=DL4psxFymz32qgGbVH1CRm+VFPXxJoupMTCurVus+oc7ebBFb6xrVC9nWf9tzyH5JJvwy6
        xNGSl0KdwWQXY6iWfgThqadIa5Nm25hIFQVzJxIoXy7xn/hfStm2mc2O+eFNQESqQ00MRq
        JRc4UEW1uoR7PVS902ul06EoLvkLml4=
Date:   Sat, 22 Dec 2018 12:44:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] Last straggler for 4.20-rc8 or final
Message-ID: <20181222114446.GA9314@zn.tnic>
References: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
 <20181221224040.GA25147@zn.tnic>
 <b54245cb-d029-02a5-d854-129ea7734336@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b54245cb-d029-02a5-d854-129ea7734336@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:47:43AM +0100, Paolo Bonzini wrote:
> Right, and also I will have to provide you with a topic branch to base
> that patch on.

Ok, sure.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

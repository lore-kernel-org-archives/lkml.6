Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F74D2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rY+GUKeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfBUMZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:25:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUMZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:25:27 -0500
Received: from zn.tnic (p200300EC2BCBF80069FBEE4120F5857A.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:f800:69fb:ee41:20f5:857a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 817551EC023E;
        Thu, 21 Feb 2019 13:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550751925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yq77mx4y0yXWCoemxnQN0mAeAyuP5oeV+Kui95oJBA8=;
        b=rY+GUKeJW7fcjx+uA0/SAbuDGraDm+BHxpywBQm7ngf5AKqVQWKAw1InNP3pAnIMMgCGix
        tfdCXg/8fCTJDVttFrVkyX3gD9oJmXq0UNjkJLThfn6pGVtL3niUphWMGlyIi7Ej1S2eb8
        eVyyUdPLEnc7/Wnwpwq5Aho3RVsBKJw=
Date:   Thu, 21 Feb 2019 13:25:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, linux-tip-commits@vger.kernel.org,
        suravee.suthikulpanit@amd.com, jiaxun.yang@flygoat.com,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        sherry.hurwitz@amd.com, mingo@redhat.com, mingo@kernel.org,
        thomas.lendacky@amd.com, hpa@zytor.com,
        Erwan Velu <e.velu@criteo.com>
Subject: Re: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Message-ID: <20190221122523.GB12997@zn.tnic>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
 <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
 <20190220085334.GA5177@zn.tnic>
 <20190221115230.GB25198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221115230.GB25198@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:52:30PM +0100, Greg KH wrote:
> I would, but I do not see this patch in Linus's tree yet :)

You will soon :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

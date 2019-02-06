Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CF420821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sy/9+5nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfBFSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:11:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFSLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:11:25 -0500
Received: from zn.tnic (p200300EC2BCEF100C1C850073B25A4AC.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:c1c8:5007:3b25:a4ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C7911EC0A0E;
        Wed,  6 Feb 2019 19:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549476684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pVmVM1+tbIvFSepBZwmC/10XF0a4O9sFXT5LDjaDW/w=;
        b=Sy/9+5nQagGvalCqiu7+BnefCKQIfsFI4HXDFVD7wzFtNavBwO/535LnGpYIy5JQvQ98xT
        K0kRgGllPlIRPJl9thbKJyDDVf3kPZeKuIowHMk3WeICkLqxWUPLAr+zZCDPiZPc3VyxFH
        N4MkVwRiL5MHeLuwcFum5kARnLRZK/0=
Date:   Wed, 6 Feb 2019 19:11:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Kyle D Pelton <kyle.d.pelton@intel.com>,
        Wei Huang <wei@redhat.com>
Subject: Re: [PATCH] x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1
 setting
Message-ID: <20190206181111.GH7314@zn.tnic>
References: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
 <20190206152141.GF7314@zn.tnic>
 <20190206154756.matwldebbxkmlnae@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206154756.matwldebbxkmlnae@black.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 06:47:57PM +0300, Kirill A. Shutemov wrote:
> What about this:

Yap, thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

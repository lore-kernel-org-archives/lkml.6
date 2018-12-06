Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5FE208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Le0GDOMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5FE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLFVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:37:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFVhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:37:55 -0500
Received: from zn.tnic (p200300EC2BCE8F00A9C379089DD692CF.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:8f00:a9c3:7908:9dd6:92cf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17A5B1EC04DF;
        Thu,  6 Dec 2018 22:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544132274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3FLOL1Gcjlmj0/7UOOXqFhpML1TvTBhiPBJKhCh++6E=;
        b=Le0GDOMzUeLLLRRDrq4uwC9UN6r/vipn1pwMB+jhnd7Z6emjrYThZfOwizRvGSqnMg5RLs
        kO5ugRdw42cQuaR63jPiXz4G3a0k+LXIvNaIs0c3tGuY0ycpT83Y5Iittgb7LcmF0QoP0X
        PM4yd4FeqTpb24iEcE7bn2WmkpwTYMQ=
Date:   Thu, 6 Dec 2018 22:37:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        bp@suse.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
Subject: Re: [PATCH v8 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Message-ID: <20181206213752.GL3986@zn.tnic>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:21:12PM +0100, Paolo Bonzini wrote:
> Thanks!  I should be able to post a Tested-by next Monday.  Boris, are
> you going to pick it up for 4.21?

Boris me or Boris O.?

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

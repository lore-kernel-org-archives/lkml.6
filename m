Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E1C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672FC20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672FC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLGTWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:22:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:22:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A26A9B004;
        Fri,  7 Dec 2018 19:22:41 +0000 (UTC)
Date:   Fri, 7 Dec 2018 20:22:31 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        rkrcmar@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, hch@infradead.org, mingo@redhat.com,
        xen-devel@lists.xenproject.org, thomas.lendacky@amd.com,
        luto@kernel.org, jpoimboe@redhat.com, tglx@linutronix.de,
        mchehab@kernel.org, jgross@suse.com,
        Maran Wilson <maran.wilson@oracle.com>,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        kirill.shutemov@linux.intel.com, roger.pau@citrix.com
Subject: Re: [Xen-devel] [PATCH v8 0/7] KVM: x86: Allow Qemu/KVM to use PVH
 entry point
Message-ID: <20181207192231.GE9465@zn.tnic>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
 <20181206213752.GL3986@zn.tnic>
 <147cc043-b0af-74e9-5259-8c7854f82d8b@oracle.com>
 <63756df6-6f0b-fdfa-932e-b53d173da5be@redhat.com>
 <20181207102546.GC9385@zn.tnic>
 <e6b86f5a-ef90-8770-8091-5a143ab00754@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6b86f5a-ef90-8770-8091-5a143ab00754@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:07:54AM -0500, Boris Ostrovsky wrote:
> Can this be considered as an ACK from you?

I'll look at v9 next week and add tags, assuming v9 is going to be the
final one, of course.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

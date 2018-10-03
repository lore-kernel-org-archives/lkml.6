Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77D20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE77D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCSWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeJCSWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E364EAE8B;
        Wed,  3 Oct 2018 11:34:46 +0000 (UTC)
Date:   Wed, 3 Oct 2018 13:34:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
Message-ID: <20181003113435.GB4436@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
 <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:57:59AM +0800, lijiang wrote:
> I noticed that your test was based on [patch v8 RESEND 4/4],

How did you notice that?

Let's see, the patch in question is this one:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=rc6%2b0-sme-kdump&id=4a0f2adf6cf374ed3e742134e40591ea33d55b05

and it has a Link tag:

Link: https://lkml.kernel.org/r/be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com

Now let's open that link tag. I don't know about you but my browser says:

https://lore.kernel.org/lkml/be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com/T/#u

which points to

Subject: Re: [PATCH v9 4/4] kdump/vmcore: support encrypted old memory with SME enabled

Looking at that mail, its message id is:

Message-ID: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>

It looks to me it is already v9, no?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

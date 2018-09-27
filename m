Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860CB21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860CB21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeI0W3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:29:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbeI0W3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:29:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEE2EAFAD;
        Thu, 27 Sep 2018 16:10:37 +0000 (UTC)
Date:   Thu, 27 Sep 2018 18:10:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
Message-ID: <20180927161038.GB19779@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com>
 <20180927131737.GA19779@zn.tnic>
 <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:53:47PM +0800, lijiang wrote:
> If no need to break this line, it will cause a warning of exceeding 80 characters per line.

That's fine - we don't take the 80 cols rule blindly but apply common
sense. In this particular case the lines can stick out because they're
simply externs and are meant to be skimmed over and not really read. :)

> Thank you for pointing out this issue, i forgot to remove this header file. 
> 
> I will get rid of this header file and post this patch again.

No need - already fixed that up.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

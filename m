Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA66C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EC2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0EC2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeJOTDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeJOTDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9126DAD49;
        Mon, 15 Oct 2018 11:18:50 +0000 (UTC)
Date:   Mon, 15 Oct 2018 13:18:43 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>,
        bhe@redhat.com, tiwai@suse.de, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mingo@redhat.com,
        baiyaowei@cmss.chinamobile.com, hpa@zytor.com,
        dan.j.williams@intel.com, tglx@linutronix.de,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20181015111843.GB10240@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
 <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
 <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:51:38PM +0800, Dave Young wrote:
> > Since the fix of checking the end is in another patch, probably merge
> > these two patches so that they are in one patch to avoid break bisect. 
> 
> Not sure if above comment was missed, Boris, would you mind to fold the
> patch 1 and 2?

Without any further explanation about a potential bisection breaking,
there's nothing I can do.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68F2ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D420866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5D420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIOSu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbeIOSu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:50:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4463BAF70;
        Sat, 15 Sep 2018 13:31:54 +0000 (UTC)
Date:   Sat, 15 Sep 2018 15:31:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dave Hansen <dave@sr71.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dtor@vmware.com,
        kys@microsoft.com, haiyangz@microsoft.com, agraf@suse.de,
        gleb@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/2] x86 Kconfig: create x86/Kconfig.virt
Message-ID: <20180915133148.GB6833@zn.tnic>
References: <20140114001138.57304DD0@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140114001138.57304DD0@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2014 at 04:11:38PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Right now, there is a "Enable paravirtualization code" option in
> the "Processor Features" menu, which means Xen.  There is also a
> group of host-side paravirtualization options specific to KVM
> under the top-level "Virtualization" menu.
> 
> I think it makes a lot of sense to group the host and guest side
> things together, especially since the top-level "Virtualization"
> menu is so sparsely populated.

Whoops, those are 4 years old and look forgotten. The idea still makes
sense though, IMO. You could refresh them, if bored ... :-)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

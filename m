Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42294C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128C8218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfBRJWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:22:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbfBRJWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:22:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0E38AE9A;
        Mon, 18 Feb 2019 09:22:18 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:22:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "chenzefeng (A)" <chenzefeng2@huawei.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>
Subject: Re: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Message-ID: <20190218092218.3ltqt5uhvy4z23ny@pathway.suse.cz>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
 <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
 <d137b1a4-ae46-f529-15a0-cdc8fbfc6bbe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d137b1a4-ae46-f529-15a0-cdc8fbfc6bbe@huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-02-18 13:29:11, chengjian (D) wrote:
> Hi，Jiri
> 
> 
> This patch should be merged into 4.4 stable,
> 
> which still use klp_write_module_reloc.
> 
> 
> https://elixir.bootlin.com/linux/v4.4.174/source/arch/x86/kernel/livepatch.c
> 
> 
> ZeFeng may have sent a stable(4.4-y) patch to the wrong mail-list(mainline).

ZeFeng or Chengjian, please, send the patch once again with
stable@vger.kernel.org in CC and explanation that it is needed
only for 4.4 and why.

This thread is already too long and messed to be proceed
by stable people effectively.

Best Regards,
Petr

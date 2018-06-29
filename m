Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5CDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEF527963
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEF527963
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934100AbeF2Hta (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:49:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeF2Ht3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:49:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fYo9l-0002XD-L6; Fri, 29 Jun 2018 09:49:25 +0200
Date:   Fri, 29 Jun 2018 09:49:25 +0200
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     "Calciano, Jess" <jess.calciano@intel.com>
Cc:     "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iscsi_trx oops in 4.18.0-rc2 and potential patch for percpu_ida.c
Message-ID: <20180629074924.pomscnvmi3l42lbm@linutronix.de>
References: <E079A211AAA8AD48953B67A89DB71C856E7DBC38@fmsmsx104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E079A211AAA8AD48953B67A89DB71C856E7DBC38@fmsmsx104.amr.corp.intel.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-28 19:53:21 [+0000], Calciano, Jess wrote:
> So although the problem has already been reported, we're wondering if there are any updates on the status of the fix, or if it will be available in an upcoming mainline build.
In Linus' tree:
4bb6e96ab808 ("lib/percpu_ida.c: don't do alloc from per-CPU list if there is none")

> Thanks,
> Jess

Sebastian

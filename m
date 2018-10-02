Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398BCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A3020666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A3020666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJBSNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:13:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:13:53 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7ItG-0000Ke-0A; Tue, 02 Oct 2018 13:30:58 +0200
Date:   Tue, 2 Oct 2018 13:30:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cpandya@codeaurora.org, toshi.kani@hpe.com, mhocko@suse.com,
        akpm@linux-foundation.org, sean.j.christopherson@intel.com
Subject: Re: [PATCH v2 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
In-Reply-To: <1538478363-16255-4-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.DEB.2.21.1810021326300.32062@nanos.tec.linutronix.de>
References: <1538478363-16255-1-git-send-email-will.deacon@arm.com> <1538478363-16255-4-git-send-email-will.deacon@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Will Deacon wrote:

Subject prefix wants to be 'x86/pgtable:' please

> Now that the core code checks this for us, we don't need to do it in the
> backend.

According to Documentation changelogs want to be written in imperative
mood.

  The core code has a check for pXd_none() already. Remove it in the
  architecture implementation.

Or something like that.

> Cc: Chintan Pandya <cpandya@codeaurora.org>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Other than the nits above:

  Acked-by: Thomas Gleixner <tglx@linutronix.de>

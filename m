Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E26B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E26B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFTGVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:21:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeFTGVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:21:43 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVWUo-00086g-Ip; Wed, 20 Jun 2018 08:21:34 +0200
Date:   Wed, 20 Jun 2018 08:21:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 00/38] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <85f6cdc2-e801-2def-def8-112be862b3a7@intel.com>
Message-ID: <alpine.DEB.2.21.1806200813400.10546@nanos.tec.linutronix.de>
References: <cover.1527593970.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1806191853510.10546@nanos.tec.linutronix.de> <85f6cdc2-e801-2def-def8-112be862b3a7@intel.com>
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

Reinette,

On Tue, 19 Jun 2018, Reinette Chatre wrote:
> I am sorry for adding confusion by keeping the changelog from previous
> versions with each new submission. v3 had 39 patches with the last patch
> depending on Mike's work. I removed that final patch in v4, planning to
> resubmit it when Mike's work has been merged since it seems the API I
> used may change.

Nothing to be sorry about. I just wanted to make sure, that I'm not missing
something,

All in all this was a very enjoyable read through and the whole thing is
very well done! I played around with the exclusive mode and it's a useful
improvement: it immediately catched that I'm not able to count :)

Great job!

Thanks,

	Thomas

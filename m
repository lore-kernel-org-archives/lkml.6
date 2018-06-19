Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01265C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BFC20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BFC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967179AbeFSQ52 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:57:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966999AbeFSQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:57:25 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVJwT-0000ss-UP; Tue, 19 Jun 2018 18:57:18 +0200
Date:   Tue, 19 Jun 2018 18:57:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 00/38] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1806191853510.10546@nanos.tec.linutronix.de>
References: <cover.1527593970.git.reinette.chatre@intel.com>
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

On Tue, 29 May 2018, Reinette Chatre wrote:
> 
> The last patch of this series depends on the series:
> "[RFC PATCH 0/3] Interface for higher order contiguous allocations"
> submitted at:
> http://lkml.kernel.org/r/20180212222056.9735-1-mike.kravetz@oracle.com
> A new version of this was submitted recently and currently being discussed
> at:
> http://lkml.kernel.org/r/20180417020915.11786-1-mike.kravetz@oracle.com
> Without this upstream MM work (and patch 39/39 of this series) it would

There are only 38 patches and none which might depend on Mikes work :)

So the whole thing is self contained and just limited to 4MB, right?

Thanks,

	tglx

Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C4624BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C4624BE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeFWMaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:30:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeFWMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:30:05 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWhfz-0005cr-K1; Sat, 23 Jun 2018 14:29:59 +0200
Date:   Sat, 23 Jun 2018 14:29:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:for-vfs-merged 2/2] arch/x86//kernel/cpu/intel_rdt_rdtgroup.c:1263:3:
 error: 'dentry' undeclared
In-Reply-To: <201806232025.2w1ZNpT8%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.21.1806231429350.8650@nanos.tec.linutronix.de>
References: <201806232025.2w1ZNpT8%fengguang.wu@intel.com>
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

On Sat, 23 Jun 2018, kbuild test robot wrote:
> 32206ab3 Reinette Chatre 2018-06-22  1261  	ret = rdt_pseudo_lock_init();
> 32206ab3 Reinette Chatre 2018-06-22  1262  	if (ret) {
> 32206ab3 Reinette Chatre 2018-06-22 @1263  		dentry = ERR_PTR(ret);
> 32206ab3 Reinette Chatre 2018-06-22  1264  		goto out_mondata;

Dammit.


Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C61C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D6720869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeIHPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:06:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeIHPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:06:58 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyaMx-0006HM-6p; Sat, 08 Sep 2018 12:21:35 +0200
Date:   Sat, 8 Sep 2018 12:21:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     longman@redhat.com, arnd@arndb.de, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/sg_pool: remove unnecessary null check when free
 the object
In-Reply-To: <5B939F01.7020802@huawei.com>
Message-ID: <alpine.DEB.2.21.1809081221080.1402@nanos.tec.linutronix.de>
References: <1533054107-35657-1-git-send-email-zhongjiang@huawei.com> <5B9398CD.1060500@huawei.com> <alpine.DEB.2.21.1809081146010.1402@nanos.tec.linutronix.de> <5B939F01.7020802@huawei.com>
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

On Sat, 8 Sep 2018, zhong jiang wrote:

> On 2018/9/8 17:46, Thomas Gleixner wrote:
> > On Sat, 8 Sep 2018, zhong jiang wrote:
> >> Hi,  Thomas
> >>
> >> Can you pick up the patch?
> > I'm not picking up patches for lib/sg_pool. Why would I?
> >
> I am sorry for that. I regard you as maintainer for lib/sg_pool mistakely. 
> but I can get maintainer information nothing from get_maintainer.pl
> The code is not updated since 2016. 

Andrew Morton picks up such things.

Thanks,

	tglx

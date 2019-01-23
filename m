Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A30C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D432D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfAWMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:51:16 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:53653 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:51:15 -0500
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by mgwkm02.jp.fujitsu.com with smtp
         id 1472_10b5_ea807b26_0004_410e_897d_635f5e36908c;
        Wed, 23 Jan 2019 21:51:11 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 89730AC0108
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 21:51:11 +0900 (JST)
Received: from G01JPEXCHKW17.g01.fujitsu.local (G01JPEXCHKW17.g01.fujitsu.local [10.0.194.56])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 58EC2328726;
        Wed, 23 Jan 2019 21:51:10 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw17 ([10.0.194.56]) with mapi id 14.03.0415.000; Wed, 23 Jan 2019
 21:51:10 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>
CC:     "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fCADGG/gP/+BGiA
Date:   Wed, 23 Jan 2019 12:51:08 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
 <20190122152339.GD52887@lakrids.cambridge.arm.com>
In-Reply-To: <20190122152339.GD52887@lakrids.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark, James
> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Wednesday, January 23, 2019 12:24 AM
> To: Zhang, Lei/張 雷
> Cc: 'catalin.marinas@arm.com'; 'will.deacon@arm.com';
> 'linux-arm-kernel@lists.infradead.org';
> 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
> Fujitsu-A64FX
> 
 
> As above, I'm very concerned that this could be taken from kernel
> context. There are a number of cases where we cannot handle such faults:
At first thanks for your comments. 
I thinks James's comments is quite similar with above comment.
I am reviewing this point now.
I will respond to your questions after I check this.

Thanks
Lei Zhang



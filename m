Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C5820857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBAFyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:54:01 -0500
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168]:21179 "EHLO
        mgwkm01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAFyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:54:01 -0500
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by mgwkm01.jp.fujitsu.com with smtp
         id 64f2_3f1a_6c3210bf_a1da_4726_99e2_1b71f7246348;
        Fri, 01 Feb 2019 14:53:53 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2DBBAAC00A3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 14:53:53 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 23075BD646B;
        Fri,  1 Feb 2019 14:53:52 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Fri, 1 Feb 2019
 14:53:51 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'James Morse' <james.morse@arm.com>
CC:     'Mark Rutland' <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUuKy5V4yTFdOO5Emj9g0aGwlQl6XKckPA
Date:   Fri, 1 Feb 2019 05:53:50 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
In-Reply-To: <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
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

Hi James,

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> James Morse
> Sent: Thursday, January 31, 2019 12:00 AM
> To: Zhang, Lei/張 雷
> Cc: 'Mark Rutland'; 'Catalin Marinas'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001
> 
> 
> e03e61c3173c ("arm64: kaslr: Set TCR_EL1.NFD1 when
> CONFIG_RANDOMIZE_BASE=y") ?
> 
> So you'd never see it if you disabled CONFIG_RANDOMIZE_BASE?
For security, it is necessary to set CONFIG_RANDOMIZE_BASE=y.

Thanks,
Zhang Lei 


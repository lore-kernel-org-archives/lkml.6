Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D60C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4CB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4CB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeHUNRE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:17:04 -0400
Received: from mail5.windriver.com ([192.103.53.11]:60020 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeHUNRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:17:04 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w7L9vRiJ028744
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 21 Aug 2018 02:57:27 -0700
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.23]) by
 ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0399.000; Tue,
 21 Aug 2018 02:57:27 -0700
From:   "Xue, Ying" <Ying.Xue@windriver.com>
To:     Jon Maloy <jon.maloy@ericsson.com>
CC:     David Miller <davem@davemloft.net>,
        "Bai, Haiqing" <Haiqing.Bai@windriver.com>,
        "Gao, Zhenbo" <Zhenbo.Gao@windriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
Thread-Topic: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
Thread-Index: AQHUOPWO0Fgxj94ZzUmvikkEOFXOIKTKbNaA//+L+Vs=
Date:   Tue, 21 Aug 2018 09:57:25 +0000
Message-ID: <E0E1BFBA-FB75-4ACC-AAE1-14647A0BEA7F@windriver.com>
References: <1534760761-30206-1-git-send-email-Haiqing.Bai@windriver.com>
 <20180820.192031.1137174206399090141.davem@davemloft.net>,<DM5PR15MB1513428048EE31705DA273549A310@DM5PR15MB1513.namprd15.prod.outlook.com>
In-Reply-To: <DM5PR15MB1513428048EE31705DA273549A310@DM5PR15MB1513.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I am on vacation too. I agree with Jon. Please temporarily hold this patch. Once I am back, I will review it as soon as possible.

Sent from my iPhone

> On Aug 21, 2018, at 9:52 PM, Jon Maloy <jon.maloy@ericsson.com> wrote:
> 
> Hi David, 
> Please hold this one for now. 
> 
> ///jon
> 
>> -----Original Message-----
>> From: David Miller <davem@davemloft.net>
>> Sent: Monday, 20 August, 2018 22:21
>> To: Haiqing.Bai@windriver.com
>> Cc: Jon Maloy <jon.maloy@ericsson.com>; ying.xue@windriver.com; zhenbo.gao@windriver.com; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
>> 
>> From: Haiqing Bai <Haiqing.Bai@windriver.com>
>> Date: Mon, 20 Aug 2018 18:26:01 +0800
>> 
>>> The tipc multicast demo in tipcutils fails to work on big-endian hardware.
>>> The tipc multicast server can not receive the packets sent by the multicast
>>> client for that the dest port is always zero after tipc_dest_pop, then it
>>> is found that the struct tipc_dest fails to take big/little endian into
>>> account.
>>> 
>>> Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
>>> Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>
>> 
>> Jon and Ying, please review.
>> 
>> thank you.

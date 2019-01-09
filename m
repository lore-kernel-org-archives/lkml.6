Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED84C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709EE20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAIHvY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:51:24 -0500
Received: from [223.203.96.18] ([223.203.96.18]:50703 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728112AbfAIHvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:51:24 -0500
X-ASG-Debug-ID: 1547020278-107606139f16c250001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id 6QDLhnrj1a4dYJt9 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 15:51:20 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 15:51:12 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 15:51:12 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: About some mail lost and random unsubscribe issues on this
 dmaengine list
Thread-Topic: About some mail lost and random unsubscribe issues on this
 dmaengine list
X-ASG-Orig-Subj: Re: About some mail lost and random unsubscribe issues on this
 dmaengine list
Thread-Index: AQHUp/AW6Fts0xnNYkCZH4exZZuk3A==
Date:   Wed, 9 Jan 2019 07:51:11 +0000
Message-ID: <e3a2d37d7bce44eb8d3a726a8f69c8d7@HXTBJIDCEMVIW02.hxtcorp.net>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
 <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
 <79da1c31d3e14e6e91cf6a7cc0fea31a@HXTBJIDCEMVIW01.hxtcorp.net>
 <16bbdd233f1d45249eb2f6592418efd5@HXTBJIDCEMVIW02.hxtcorp.net>
 <b607a505d2974e1d879ba7d7c3488f85@HXTBJIDCEMVIW02.hxtcorp.net>
 <20190109065851.GW13372@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1547020280
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 983
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4092 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65372
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod,
  Thanks for your information. I will check with our IT.
Shunyong.
Thanks.

On 2019/1/9 15:00, Vinod Koul wrote:
> On 09-01-19, 01:35, Yang, Shunyong wrote:
>> Hi, Vinod and All,
>>   I found, somtimes, I cannot received some mails from this mailing
>> list. For example, I sent my v2 series on 7th, Jan,
>>
>> https://patchwork.kernel.org/project/linux-dmaengine/list/?series=62713
>>
>> It appeared on patchwork.kernel.org but I haven't received it in this
>> mailing list.
>>
>> And I found randomly, a month or two months, I am unsubscribed from this
>> list automatically. Then I have to re-subscribe the list.
> 
> I guess your corporate server is to blame. vger mail list is "know" to 
> unsubscribe servers which behave badly, so you need to ask your mail
> admins why and try to use other email which is known to be friendly with
> vger :)
> 
>> Have someone met similar problem as me? Or maybe I missed some necessary
>> settings?
>>
>> Shunyong.
>> Thanks.
> 


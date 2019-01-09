Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03477C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D1220821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfAIBlr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:41:47 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:55465 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729099AbfAIBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:41:47 -0500
X-ASG-Debug-ID: 1546997741-093b7e2d887eff0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id 5xEdSqT50cy5IZQn (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 09:35:41 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 09:35:34 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 09:35:34 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: About some mail lost and random unsubscribe  issues on this dmaengine
 list
Thread-Topic: About some mail lost and random unsubscribe  issues on this
 dmaengine list
X-ASG-Orig-Subj: About some mail lost and random unsubscribe  issues on this dmaengine
 list
Thread-Index: AQHUp7udaPqeOMKVUkqGIWsA4iAm4g==
Date:   Wed, 9 Jan 2019 01:35:34 +0000
Message-ID: <b607a505d2974e1d879ba7d7c3488f85@HXTBJIDCEMVIW02.hxtcorp.net>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
 <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
 <79da1c31d3e14e6e91cf6a7cc0fea31a@HXTBJIDCEMVIW01.hxtcorp.net>
 <16bbdd233f1d45249eb2f6592418efd5@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546997741
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.1256 1.0000 -1.2412
X-Barracuda-Spam-Score: -1.24
X-Barracuda-Spam-Status: No, SCORE=-1.24 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65355
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod and All,
  I found, somtimes, I cannot received some mails from this mailing
list. For example, I sent my v2 series on 7th, Jan,

https://patchwork.kernel.org/project/linux-dmaengine/list/?series=62713

It appeared on patchwork.kernel.org but I haven't received it in this
mailing list.

And I found randomly, a month or two months, I am unsubscribed from this
list automatically. Then I have to re-subscribe the list.

Have someone met similar problem as me? Or maybe I missed some necessary
settings?

Shunyong.
Thanks.

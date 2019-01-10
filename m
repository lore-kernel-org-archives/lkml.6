Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14941C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC00021738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAJCRf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:17:35 -0500
Received: from [223.203.96.18] ([223.203.96.18]:30649 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbfAJCRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:17:35 -0500
X-ASG-Debug-ID: 1547086650-107606139f175eb0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id zQSO4bp5ZVHhk6wI (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 10 Jan 2019 10:17:31 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 10:17:24 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Thu, 10 Jan 2019 10:17:24 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Thread-Topic: [PATCH v2] ACPI / tables: table override from built-in initrd
X-ASG-Orig-Subj: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Thread-Index: AQHUlpcx3RZcoqMsIkiCDzlptVMvNQ==
Date:   Thu, 10 Jan 2019 02:17:23 +0000
Message-ID: <2e88277db20e4f72a78116b9c199ccf1@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1545112965-2692-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <dc56c63fba6c410b9fd35a4ebe11ce07@HXTBJIDCEMVIW02.hxtcorp.net>
 <CAJZ5v0iEVUXZ=jV9JosNM+UwEC4y-i-GzJDJPyCiEXJPY8-h+Q@mail.gmail.com>
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
X-Barracuda-Start-Time: 1547086651
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 350
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3331 1.0000 -0.2147
X-Barracuda-Spam-Score: -0.21
X-Barracuda-Spam-Status: No, SCORE=-0.21 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65431
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael

  Got it. Many thanks!

Shunyong.

On 2019/1/9 17:58, Rafael J. Wysocki wrote:
> On Wed, Jan 9, 2019 at 3:41 AM Yang, Shunyong
> <shunyong.yang@hxt-semitech.com> wrote:
>>
>> Hi, Rafael,
>>
>> Gentle ping for this patch.
> 
> It is in my queue, I'll get to it when the most urgent 5.0-candidate
> fixes have been pushed.
> 
> Thanks!
> 


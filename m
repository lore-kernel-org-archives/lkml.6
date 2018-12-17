Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49306C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEC420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbeLQKGz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:06:55 -0500
Received: from [38.106.11.25] ([38.106.11.25]:40944 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbeLQKGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:06:55 -0500
X-ASG-Debug-ID: 1545041210-107606139f0a400001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net (localhost [10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id AeENQf04z983sViF (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 17 Dec 2018 18:06:50 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Dec 2018 18:05:55 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Mon, 17 Dec 2018 18:05:55 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Thread-Topic: [PATCH] ACPI / tables: table upgrade from built-in initrd
X-ASG-Orig-Subj: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Thread-Index: AQHUla75pLHf4djd9EmmRCWXKkRMKA==
Date:   Mon, 17 Dec 2018 10:05:54 +0000
Message-ID: <2866d2b19d604155b690f1a08df0a4ab@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com>
 <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
 <CAJZ5v0jWROTTSRT1FFQWXpWn2M=uMRw5SKbwu0doKaeMjSOEnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1545041210
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 616
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3682 1.0000 -0.0915
X-Barracuda-Spam-Score: -0.09
X-Barracuda-Spam-Status: No, SCORE=-0.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63927
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

  OK. I will update the description and document.

Thanks.
Shunyong.

On 2018/12/17 17:31, Rafael J. Wysocki wrote:
> On Mon, Dec 17, 2018 at 10:18 AM Yang, Shunyong
> <shunyong.yang@hxt-semitech.com> wrote:
>>
>> Hi, Rafael,
>>   I think "override" is more accurate. I just follow the existing
>> description of "ACPI_TABLE_UPGRADE" in drivers/acpi/Kconfig.
>>   Should I change all upgrade/UPGRADE to "override/OVERRIDE" in this patch?
> 
> I think that this would be better.
> 
> Also, there is some documentation regarding this feature in the kernel
> tree.  Should it be updated by your patch?
> 


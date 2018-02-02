Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBBMNA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:13:00 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:59874
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751508AbeBBMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:12:53 -0500
X-ASG-Debug-ID: 1517573568-093b7e4cf101040001-xx1T2L
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To: Hanjun Guo <guohanjun@huawei.com>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
Subject: Re: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Thread-Topic: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
X-ASG-Orig-Subj: Re: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Thread-Index: AQHTnBBsYAsQWgur5Uueb4Qh1ttM2KOQeuYAgAAFGgA=
Date: Fri, 2 Feb 2018 12:12:39 +0000
Message-ID: <em5890c25f-84af-42ac-bfea-b27c6516e46b@bjl0091>
References: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
In-Reply-To: <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
Reply-To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C293ACC3B91E445907C1EE789E92A4B@hxt-semitech.com>
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1517573568
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4104 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47510
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w12CD4Ap011868

Hey, Hanjun,

On 2018/2/2 19:54:24, "Hanjun Guo" <guohanjun@huawei.com> wrote:

>On 2018/2/2 18:25, Yang Shunyong wrote:
>>Loading IORT table from initrd is used to fix firmware IORT defects.
>
>I don't think this fix "firmware defects", it just for debug purpose,
>we will not use that for production purpose, right? I think above line
>can be removed.
>
I thinks the upgrade feature not only for debug. Here's an important
way to fix bugs that come from the firmware.

Documentation/acpi/initrd_table_override.txt


Cheers,
-Dongsheng

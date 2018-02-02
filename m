Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBBHSb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:18:31 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:55052
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751582AbeBBHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:18:24 -0500
X-ASG-Debug-ID: 1517555901-093b7e06e830030001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Thread-Topic: [PATCH v2] ACPI / tables: Add IORT to injectable table list
X-ASG-Orig-Subj: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Thread-Index: AQHTlCPb2ARzJ9BNo0O5jf5uTQ8ff6OLKU8AgAJYFwCAArwzgA==
Date: Fri, 2 Feb 2018 07:18:28 +0000
Message-ID: <1517555897.3387.6.camel@hxt-semitech.com>
References: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <1517276662.2652.12.camel@hxt-semitech.com>
         <74324d8a-c144-5b21-bea1-9f2e1b891c0f@huawei.com>
In-Reply-To: <74324d8a-c144-5b21-bea1-9f2e1b891c0f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.3]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <230C63D794E8754E876676F6DD99C9BD@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1517555901
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4737 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47505
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hanjun

On Wed, 2018-01-31 at 21:32 +0800, Hanjun Guo wrote:
> Hi Shunyong,
> 
> On 2018/1/30 9:44, Yang, Shunyong wrote:
> > 
> > Hi, Rafael
> > 
> > Could you please help to review this patch? This is a small change
> > to
> > add ACPI_SIG_IORT to table_sigs[]. 
> > Loading IORT table from initrd is very useful to debug SMMU
> > node/device
> > probe, MSI allocation, stream id translation and verifying IORT
> > table
> > from firmware. So, I add this.
> It's true, mappings in IORT will be easy getting wrong, so it would
> be
> good to test it without updating the firmware.
> 
> But I think you'd better to add your comment about why you need
> IORT in the commit message in your patch, that will be useful
> to convince Rafael to take your patch.
> 

Thanks for your suggestion. I will add detailed information to commit
message and send out v3 later.

Thanks.
Shunyong.

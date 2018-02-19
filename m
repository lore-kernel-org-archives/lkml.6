Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeBSTOJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:14:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753443AbeBSTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:14:07 -0500
Subject: Re: [PATCH v3] ACPI / tables: Add IORT to injectable table list
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
Newsgroups: gmane.linux.acpi.devel,gmane.linux.kernel
References: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <68362a1f-cc0c-42f9-97da-bdf379c4f5a1@huawei.com>
 <em5890c25f-84af-42ac-bfea-b27c6516e46b@bjl0091>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <669340a4-e748-07f4-51d5-bf0566cd75b8@jonmasters.org>
Date: Mon, 19 Feb 2018 14:13:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <em5890c25f-84af-42ac-bfea-b27c6516e46b@bjl0091>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 07:12 AM, Wang, Dongsheng wrote:
> Hey, Hanjun,
> 
> On 2018/2/2 19:54:24, "Hanjun Guo" <guohanjun@huawei.com> wrote:
> 
>> On 2018/2/2 18:25, Yang Shunyong wrote:
>>> Loading IORT table from initrd is used to fix firmware IORT defects.
>>
>> I don't think this fix "firmware defects", it just for debug purpose,
>> we will not use that for production purpose, right? I think above line
>> can be removed.
>>
> I thinks the upgrade feature not only for debug. Here's an important
> way to fix bugs that come from the firmware.
> 
> Documentation/acpi/initrd_table_override.txt

I think we should message that this is for debug/development use.
Ultimately, it's not the way to address firmware problems. Firmware
needs to address that by shipping the correct(ed) tables :)

-- 
Computer Architect

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA1C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pOAdu31h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAVEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:37:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAVEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:37:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0M4YQb5053568;
        Tue, 22 Jan 2019 04:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HcKF4/ZF+zSHDbMcidL+N3LFGOYEiGdPB2AEQWKShmA=;
 b=pOAdu31hMpSqV1I6/wwOfn7CUkiXCCz2xXZZkOJzQ9rrvPVMSNAqZuRzfCGHqhT1IW5T
 iizeo/j6t81qwveqsVluyEAiCmSSaBh1dpQdjqIPaACfo1pLO7VnJ1WXJLIXpD4pyzvK
 fLd9GhPMNrnMwlShcAAbjgJcDCVJAky8uLHzKp3s5fUDbhoFI0jhosiPTsv8u/wQfiE/
 PzN0bpA+yJMKM56G7CC97+26jjHGS9fhoBXzu2qg/P+uSz5aHKa/OJ8uq1BwsTYRySdA
 DI+jfYYbdUOdssL+hp16oJgjRE3lHGK+JaDugSWTETzVkmcHtl8mAZf2e0Mvty4Ko1+Z uQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q3vhrh7dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 04:37:14 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0M4bEPB006676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 04:37:14 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0M4bDFb031082;
        Tue, 22 Jan 2019 04:37:13 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 20:37:13 -0800
Subject: Re: [PATCH] net: sun: cassini: Cleanup license conflict
To:     Shannon Nelson <shannon.lee.nelson@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
 <CAP-MU4M4FzAvgFodk1gm2dERJcuoJLCdX3QFFJMNDjFGvfGptw@mail.gmail.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <d4a29826-e9f0-1613-176b-c264342886f7@oracle.com>
Date:   Tue, 22 Jan 2019 12:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAP-MU4M4FzAvgFodk1gm2dERJcuoJLCdX3QFFJMNDjFGvfGptw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9143 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/19 0:30, Shannon Nelson wrote:
> On Fri, Jan 18, 2019 at 2:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The recent addition of SPDX license identifiers to the files in
>> drivers/net/ethernet/sun created a licensing conflict.
>>
>> The cassini driver files contain a proper license notice:
>>
>>    * This program is free software; you can redistribute it and/or
>>    * modify it under the terms of the GNU General Public License as
>>    * published by the Free Software Foundation; either version 2 of the
>>    * License, or (at your option) any later version.
>>
>> but the SPDX change added:
>>
>>     SPDX-License-Identifier: GPL-2.0
>>
>> So the file got tagged GPL v2 only while in fact it is licensed under GPL
>> v2 or later.
>>
>> It's nice that people care about the SPDX tags, but they need to be more
>> careful about it. Not everything under (the) sun belongs to ...
>>
>> Fix up the SPDX identifier and remove the boiler plate text as it is
>> redundant.
>>
>> Fixes: c861ef83d771 ("sun: Add SPDX license tags to Sun network drivers")
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Shannon Nelson <shannon.nelson@oracle.com>
>> Cc: Zhu Yanjun <yanjun.zhu@oracle.com>

Thanks.

Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>

>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: netdev@vger.kernel.org
>> Cc: stable@vger.kernel.org
> Thanks, Thomas.
>
> Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>
>
>> ---
>>   drivers/net/ethernet/sun/cassini.c |   15 +--------------
>>   drivers/net/ethernet/sun/cassini.h |   15 +--------------
>>   2 files changed, 2 insertions(+), 28 deletions(-)
>>
>> --- a/drivers/net/ethernet/sun/cassini.c
>> +++ b/drivers/net/ethernet/sun/cassini.c
>> @@ -1,22 +1,9 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
>>    *
>>    * Copyright (C) 2004 Sun Microsystems Inc.
>>    * Copyright (C) 2003 Adrian Sun (asun@darksunrising.com)
>>    *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> - *
>>    * This driver uses the sungem driver (c) David Miller
>>    * (davem@redhat.com) as its basis.
>>    *
>> --- a/drivers/net/ethernet/sun/cassini.h
>> +++ b/drivers/net/ethernet/sun/cassini.h
>> @@ -1,23 +1,10 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>   /* $Id: cassini.h,v 1.16 2004/08/17 21:15:16 zaumen Exp $
>>    * cassini.h: Definitions for Sun Microsystems Cassini(+) ethernet driver.
>>    *
>>    * Copyright (C) 2004 Sun Microsystems Inc.
>>    * Copyright (c) 2003 Adrian Sun (asun@darksunrising.com)
>>    *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> - *
>>    * vendor id: 0x108E (Sun Microsystems, Inc.)
>>    * device id: 0xabba (Cassini)
>>    * revision ids: 0x01 = Cassini
>
>

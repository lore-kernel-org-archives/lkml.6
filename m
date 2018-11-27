Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9771C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D7720817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D7720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeK1CV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:21:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeK1CV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:21:59 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 55D7B9A55D8E2;
        Tue, 27 Nov 2018 23:23:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 23:23:28 +0800
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
 <20181127144333.GA11004@kroah.com>
CC:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8ae3a984-b4d4-f2eb-4aaa-b460441fa403@huawei.com>
Date:   Tue, 27 Nov 2018 15:23:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181127144333.GA11004@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 14:43, Greg KH wrote:

Hi Greg,

> On Tue, Nov 27, 2018 at 10:15:32PM +0800, John Garry wrote:
>> Currently sas_task.c has no license specifier, so add SPDX license
>> identifier for GPL-2.0+.
>>
>> As mentioned in commit b24413180f56 ("License cleanup: add SPDX GPL-2.0
>> license identifier to files with no license"), files with no license in
>> the kernel are under default kernel license.
>
> The default is GPLv2, not v2+.

So sas_task.c should be v2.

>
>>
>> While I'm at it, all other libsas source code files are updated to use
>> SPDX license identifier for GPL-2.0+.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
>> index 13739bfa..bdc6bce 100644
>> --- a/drivers/scsi/libsas/Kconfig
>> +++ b/drivers/scsi/libsas/Kconfig
>> @@ -4,22 +4,7 @@
>>  # Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>>  # Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>>  #
>> -# This file is licensed under GPLv2.
>> -#
>> -# This program is free software; you can redistribute it and/or
>> -# modify it under the terms of the GNU General Public License as
>> -# published by the Free Software Foundation; version 2 of the
>> -# License.
>> -#
>> -# This program is distributed in the hope that it will be useful,
>> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> -# General Public License for more details.
>> -#
>> -# You should have received a copy of the GNU General Public License
>> -# along with this program; if not, write to the Free Software
>> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
>> -# USA
>> +# SPDX-License-Identifier: GPL-2.0+
>
> No, the above license is GPLv2 only, do NOT change the license of a file
> unless you have permission to do so.

Of course. That was not my intention. My mistake.

>
> Also, the spdx line goes at the first line of the file.

JFYI, checkpatch.pl does pick up on this for .c/.h files but not this one.

>
>
>>  #
>>
>>  config SCSI_SAS_LIBSAS
>> diff --git a/drivers/scsi/libsas/Makefile b/drivers/scsi/libsas/Makefile
>> index 5d51520..75998b7 100644
>> --- a/drivers/scsi/libsas/Makefile
>> +++ b/drivers/scsi/libsas/Makefile
>> @@ -4,22 +4,7 @@
>>  # Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>>  # Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>>  #
>> -# This file is licensed under GPLv2.
>> -#
>> -# This program is free software; you can redistribute it and/or
>> -# modify it under the terms of the GNU General Public License as
>> -# published by the Free Software Foundation; version 2 of the
>> -# License.
>> -#
>> -# This program is distributed in the hope that it will be useful,
>> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> -# General Public License for more details.
>> -#
>> -# You should have received a copy of the GNU General Public License
>> -# along with this program; if not, write to the Free Software
>> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
>> -# USA
>> +# SPDX-License-Identifier: GPL-2.0+
>
> Again you changed the license, not good :(

I was thrown by having a different license for the Kconfig+Makefile vs 
.c/.h.

>
> Please do not make these types of changes unless you really know what
> you are doing, it is not ok to change the license of files.

Right, of course.

>
> greg k-h
>

Thanks, I'll fix them properly,
John




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756378AbeDXIv0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:51:26 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:55196 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755957AbeDXIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:51:23 -0400
Subject: Re: [PATCH v2 0/2] memory: aemif: add support for machine code
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: Kevin Hilman <khilman@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180419151252.26212-1-brgl@bgdev.pl>
 <0f2903da-b670-dc85-e61b-64cac90a6c34@oracle.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4d72accf-7d63-c725-0b67-253ed6818ae0@ti.com>
Date: Tue, 24 Apr 2018 14:21:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0f2903da-b670-dc85-e61b-64cac90a6c34@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2018 10:54 PM, santosh.shilimkar@oracle.com wrote:
> On 4/19/18 8:12 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is a follow-up to the series that contained both changes to the
>> aemif driver and platform code. It contains only the driver changes.
>>
>> As the first step in removing duplicate support for aemif from the
>> kernel we need to add support for board files to the aemif memory
>> driver.
>>
>> First patch just uses a static string for the ti-aemif driver name.
>>
>> The second adds support for board files to the aemif driver.
>>
>> This series includes changes requested by Sekhar in his code review:
>> - made aemif the parent of each sub-device before registering it
>> - documented the new members in aemif_platform_data
>>
>> v1 -> v2:
>> - actually iterate over abus entries instead of always accessing the
>>    first one
>>
>> Bartosz Golaszewski (2):
>>    memory: aemif: don't rely on kbuild for driver's name
>>    memory: aemif: add support for board files
>>
> Applied. Should show up in next soon.
> 
> Sekhar, You can use below branch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git  'for_4.18/soc-drivers'

Thanks Santosh!

Regards,
Sekhar

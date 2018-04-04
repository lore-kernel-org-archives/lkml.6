Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDDINn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:13:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750916AbeDDINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:13:42 -0400
Subject: Re: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
 <20180325181600.vehqe3xcx55qxtd7@katana>
 <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
 <20180403152604.udgh4v2erpsupgo3@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <a6218454-d44c-7888-2688-d24bf5bc97f4@st.com>
Date: Wed, 4 Apr 2018 10:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403152604.udgh4v2erpsupgo3@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 05:26 PM, Wolfram Sang wrote:
> On Mon, Mar 26, 2018 at 10:41:51AM +0200, Pierre Yves MORDRET wrote:
>>
>>
>> On 03/25/2018 08:16 PM, Wolfram Sang wrote:
>>> On Wed, Mar 21, 2018 at 05:48:56PM +0100, Pierre-Yves MORDRET wrote:
>>>> This patch adds slave support for I2C controller embedded in STM32F7 SoC
>>>>
>>>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>>>
>>> Looks OK from a first look. What kind of tests did you do?
>>
>> As mentioned for 10-bit, I'm using 2 I2C instances from the SoC.
>> Here are the tests I dit:
>>  - Master/slave send in 7 and 10 bits
>>  - master/slave recv in 7 and 10 bits
>>  - E2PROM Read/Write
> 
> As far as I understand the code now, both instances can be master /
> slave simultanously on the same bus?
> 

Correct.

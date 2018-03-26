Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeCZIUX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:20:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54859 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750940AbeCZIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:20:21 -0400
Subject: Re: [PATCH v2 4/6] i2c: i2c-stm32: Add generic DMA API
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
 <20180324225138.d5yipagxiouoyqtl@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <43b6d8d7-37e6-1fe8-6a53-0202ab25cfb1@st.com>
Date: Mon, 26 Mar 2018 10:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324225138.d5yipagxiouoyqtl@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the heads-up !
My driver supports DMA, but hardly used in the system.

But it's worth to mentioned it.

On 03/24/2018 11:51 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:48:58PM +0100, Pierre-Yves MORDRET wrote:
>> This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
>> drivers
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> In case you haven't read it so far, there is a new document about I2C &
> DMA -> Documentation/i2c/DMA-considerations
> 
> Just so you know...
> 

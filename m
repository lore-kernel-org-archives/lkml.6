Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCTJpd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:45:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752555AbeCTJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:45:27 -0400
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
 <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
 <20180320094216.ugietqyerdowq4c4@katana>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <4a1aa386-21dc-12a2-b2b5-6e25586ffc79@st.com>
Date: Tue, 20 Mar 2018 10:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320094216.ugietqyerdowq4c4@katana>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick answer

On 03/20/2018 10:42 AM, Wolfram Sang wrote:
> Hi,
> 
>> Looking at the recovery API, this recovery is for slave and nothing else with my
>> case. Therefore I think I have to get move this reset out of recovery API.
> 
> Yes, you are correct. You need a custom function, this is totally driver
> specific.

OK !
> 
>> Slave Recovery mechanism is another story to implement in our platform since we
>> have to deal with GPIOs.
> 
> For that, the recovery infrastructure in the core has lots of helpers
> for you.
> 
Yeah. This is what I saw nonetheless the main trouble is to setup SCL/SDA into
GPIO. Not that easy. but feasible of course.

BTW I will rework my driver.

Thanks.

> Regards,
> 
>    Wolfram
> 

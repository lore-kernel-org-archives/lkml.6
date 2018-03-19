Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeCSIlq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:41:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56391 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932301AbeCSIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:41:41 -0400
Subject: Re: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
Date: Mon, 19 Mar 2018 09:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317205109.gocf5wemtjkyomct@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do believe the hw can support it, even it looks odd to me having the same I2C
in slave and master mode at the same time.
Nevertheless the driver is devised to support either master or slave more but
not at the same time.

Regards
On 03/17/2018 09:51 PM, Wolfram Sang wrote:
> 
>> + * @master_mode: boolean to know in which mode the I2C is running (master or
>> + * slave)
> 
> It can't do both at the same time?
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeEOHP4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:15:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59349 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752089AbeEOHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:15:54 -0400
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180515072217.0a2ffe25@canb.auug.org.au>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <80df07c8-b89c-503e-ad25-9f235cb08038@st.com>
Date: Tue, 15 May 2018 09:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515072217.0a2ffe25@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/14/2018 11:22 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    949a0c0dec85 ("ARM: dts: stm32: add USB Host (USBH) support to stm32mp157c")
> 
> is missing a Signed-off-by from its committer.
> 

My fault, I forgot it when I applied patch on my branch. Do we need an 
update or it is just a reminder?

regards
alex

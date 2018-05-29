Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeE2HmJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:42:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57911 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750831AbeE2HmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:42:07 -0400
Subject: Re: linux-next: manual merge of the irqchip tree with the arm-soc
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
References: <20180529155257.5ae48830@canb.auug.org.au>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <1bedc0b7-21f9-1e15-a11c-3de06e81b5ba@st.com>
Date: Tue, 29 May 2018 09:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529155257.5ae48830@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On 05/29/2018 07:52 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the irqchip tree got a conflict in:
> 
>    arch/arm/boot/dts/stm32mp157c.dtsi
> 
> between commit:
> 
>    3c00436fdb20 ("ARM: dts: stm32: add USBPHYC support to stm32mp157c")
> 
> from the arm-soc tree and commit:
> 
>    5f0e9d2557d7 ("ARM: dts: stm32: Add exti support for stm32mp157c")
> 
> from the irqchip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thanks for the fix (I will reorder nodes in a future patch). My opinion 
is that all STM32 DT patches should come through my STM32 tree. It is my 
role to fix this kind of conflicts. I thought it was a common rule 
(driver patches go to sub-system maintainer tree and DT to the Machine 
maintainer). For incoming next-series which contain DT+driver patches I 
will indicate clearly that I take DT patch. I'm right ?

Regards
Alex

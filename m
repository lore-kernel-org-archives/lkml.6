Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936363AbeE0J3b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:29:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44527 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbeE0J3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:29:30 -0400
Subject: Re: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
To: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
 <ba9e3312-1923-dcc5-b07e-20f491881328@c-s.fr>
 <cabbedf3-8a8b-4862-3efe-4ca9d5f6946b@molgen.mpg.de>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <6d133a0b-2f4c-cd63-6c76-9573c63a749f@c-s.fr>
Date: Sun, 27 May 2018 11:29:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cabbedf3-8a8b-4862-3efe-4ca9d5f6946b@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/05/2018 à 20:27, Paul Menzel a écrit :
> Dear Christophe,
> 
> 
> Am 26.05.2018 um 18:02 schrieb christophe leroy:
> 
>> Le 26/05/2018 à 06:35, Paul Menzel a écrit :
> 
>>> Building the configuration created with `make tinyconfig` on the 
>>> Power 8 system IBM S822LC with Ubuntu 18.04 fails with the error below.
>>>
>>> ```
>>> $ git describe --dirty
>>> v4.17-rc6-296-gbc2dbc5420e8
>>> $ git log --oneline -1
>>> bc2dbc5420e8 (HEAD -> master, origin/master, origin/HEAD) Merge 
>>> branch 'akpm' (patches from Andrew)
>>> $ make tinyconfig
>>> $ make -j120
>>> […]
>>>    AS      arch/powerpc/kernel/head_32.o
>>> arch/powerpc/kernel/head_32.S: Assembler messages:
>>> arch/powerpc/kernel/head_32.S:1106: Error: missing operand
>>
>> There was a similar problem in 2015, see 
>> http://linux-kernel.2935.n7.nabble.com/Missing-operand-for-tlbie-instruction-on-Power7-td1206917.html 
>>
>>
>> Which version of binutils do you use ?
> 
> 2.30-15ubuntu1 is installed.

Can tell what 'as --version' says ?

Thanks
Christophe

> 
> 
> Kind regards,
> 
> Paul

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

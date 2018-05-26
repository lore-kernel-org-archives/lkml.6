Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032336AbeEZS13 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 14:27:29 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42649 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032233AbeEZS12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 14:27:28 -0400
Subject: Re: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
 <ba9e3312-1923-dcc5-b07e-20f491881328@c-s.fr>
From: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>
Message-ID: <cabbedf3-8a8b-4862-3efe-4ca9d5f6946b@molgen.mpg.de>
Date: Sat, 26 May 2018 20:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ba9e3312-1923-dcc5-b07e-20f491881328@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christophe,


Am 26.05.2018 um 18:02 schrieb christophe leroy:

> Le 26/05/2018 à 06:35, Paul Menzel a écrit :

>> Building the configuration created with `make tinyconfig` on the Power 
>> 8 system IBM S822LC with Ubuntu 18.04 fails with the error below.
>>
>> ```
>> $ git describe --dirty
>> v4.17-rc6-296-gbc2dbc5420e8
>> $ git log --oneline -1
>> bc2dbc5420e8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 
>> 'akpm' (patches from Andrew)
>> $ make tinyconfig
>> $ make -j120
>> […]
>>    AS      arch/powerpc/kernel/head_32.o
>> arch/powerpc/kernel/head_32.S: Assembler messages:
>> arch/powerpc/kernel/head_32.S:1106: Error: missing operand
> 
> There was a similar problem in 2015, see 
> http://linux-kernel.2935.n7.nabble.com/Missing-operand-for-tlbie-instruction-on-Power7-td1206917.html
> 
> Which version of binutils do you use ?

2.30-15ubuntu1 is installed.


Kind regards,

Paul

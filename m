Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBCHXU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:23:20 -0500
Received: from mout.web.de ([217.72.192.78]:65375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeBCHXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:23:13 -0500
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: Coccinelle: zalloc-simple: Checking consistency for SmPL rules
To: Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
 <alpine.DEB.2.20.1802011040110.3135@hadrien>
 <22276745-4723-4391-4460-07f0820ae85b@users.sourceforge.net>
 <alpine.DEB.2.20.1802011125460.3135@hadrien>
Message-ID: <c7a59e25-a77f-a0ba-8635-5910dbba5d81@users.sourceforge.net>
Date: Sat, 3 Feb 2018 08:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802011125460.3135@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:li9tWFtwUqSmRNIdnpIeKR/IYkERBePACIgrjUKMm2ra9fn71en
 E05ow1CM3BHkkJ9sufWHWVBhINhB6mwQUmITffTrR3TW6ZIqBuHdzODFvdhkiKQJkYV2HKq
 i4h46W/z61CCp/zp1xVmA/HLZ2IIo5ybMvePkZDZkoSVE9ayb9GowjAkKVBF52b8RUP37YS
 e341pZscJAHV4Bbma1y6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mr/zHJPk7XQ=:L9dnitWc1X8J9EmaEBNV1d
 dZ1J2r54eAjx7qYW3QjltlgLgIRw0P9i67VLciVMVuQHquCKmRhvswcO5dfTBQu6cXbylpEjj
 el2WyUN75nQT3lgNa9YZGG/4yNmf2HbQhDxsshD+KRn50ABzRLCADpkoh/62pc3PoXCNUakXE
 e0p0cqhN3F51Mc6vpogDybGo5+eblONI5Y5/69P/sHizIfim8owBQuJ8Mi7mlXydPBf2y+ysB
 st7aWZAdK9m7kyEjVFDII4dnEdbN6S8f27GYZc0s1e7Yq4s6LTwVR8wVsyA6Hnh0o5de4Oa67
 gxMDgyiDbEd9SimPQQVV+2GlmRandpN2ERsnySnboSYp4mezpDvytT9c32rprTbDVOedhG9RJ
 gzJMLkwFSvtO6LYFt8XY7C7XZK+Vdmw5mjshMQwPJeAnFMNwkyVZsfr0EBP0W+v5Bwr6+h79T
 Yb2GFXycCUe0C/+c04NO1h0TV0jgqyDYmG7fT7GeZ5K/cfSD52XkrsH9qy0tbQScgli32qK1R
 oIAaFCUzUyzv/h+7bP1L5rZAtUbLN/MJd33D3+/p71Vht+LBKoI/Tjl0gWkH5BoBpWd5d1stC
 AzcD3jQf95HNf0GDr9u8NxyWHiNig2UrOG/t+Vj1iIfmy680zVJ3/rGl//tiIGUt7v1tym0lg
 jCOXCR9LqKJqu0/2QCGErkXjQqq8jzZbiE6a/5KGJGM7EuaDrKJDDATZX88NyOgoSJ2Jg+hvz
 jc3dqjgF9yTdCzWm1wNtX5GhU+a/mzqJOq8VMJ3w4fY0JPUNsADrdm7cjX7tLqn/xUGj6kaLV
 MQZahuAlZ+43cIWM1N6h/59Zq6krJvO9U+rzWXXZwjLnnBKF2M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Do we agree that a proper size determination is essential for every
>>   condition in the discussed SmPL rules together with forwarding
>>   this information?
> 
> No.  I don't mind a few false positives.

Do you care to split SmPL rules by their confidence category in such an use case?

Regards,
Markus

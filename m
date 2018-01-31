Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbeAaRx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:53:29 -0500
Received: from mout.web.de ([212.227.15.14]:63049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932325AbeAaRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:53:27 -0500
Subject: =?UTF-8?Q?Re:_[v2]_Coccinelle:_zalloc-simple:_Delete_function_?=
 =?UTF-8?B?4oCca21lbV9jYWNoZV9hbGxvY+KAnSBmcm9tIFNtUEwgcnVsZXM=?=
To: Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc: cocci@systeme.lip6.fr, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <243e83a2-ae0c-2dd2-7f8f-83ac0978cc0e@users.sourceforge.net>
 <alpine.DEB.2.20.1801311836320.3707@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f182b411-d378-56dd-1ab5-0e8f039d493e@users.sourceforge.net>
Date: Wed, 31 Jan 2018 18:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801311836320.3707@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5iae4RoUQhQROTeI4WF2S/1oBHTWkyEckwBGAo8XOrb/SOsQsKH
 FSAOSdfJ0CYhtVZhY1GV8deC5FOelMST71MLI5Bs/s/xMBZVk2A3okloVcCYGmjcSYL3l/c
 XpQFocMu8w4APTNngKC59b7lgTyovsgvbqgskJzrYJFH6iG4kfrsKOU7mzwHd6u3QUbKB1p
 bSCU/4t1OxI+BZTRZydUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CGL3MVnhfWc=:MEOzmhzKaGIppQp9tW0yL6
 bdw0/pCd1kII3xzPxmLjfkcQt50mRe3xllDIclwh9aDRLO9jBPo2XaG6TW6lXsWYa7UGd/MNd
 Jw1Yll0ddhQ5K3UAYTBcLk6yA9Tw7f/+FNIa49AaXZHK4FYTqf98LaMXxKomremOGvdQIoQO2
 AYCSa4P+nYMiQTwBCXqO0laCPawk2yULXbAuzagCW+LDwKRJPaf19jFwZiF6LdLAecZwCfM0l
 gJU99GOZca1h0OJZiGeTT7gcyH0rBTP9cp6O5y4uVUJpvQvxtcIvInobsP6KpkqOnkkA6qHO8
 JHSMO3OFeTy5MYJ+zwbwF/FP/Ifi94BCN9LQtpHLBIddVdLYRNMuq1Wq9Q0cXtponPO1UCXT2
 qhpaiPAQreULU7mN7fdW5ZQuR4/d+1D0wjn/nvmXaId57OswiiIRvX/laoKTwCquClmPadWLN
 ROg105ssbGNrEMhmcPIswNvFKTwmXmjirX5nZwESIF0g6gGNIBzgbRMXpmm0UEopcHFWP3Ous
 MVhRLgdfJTepm6d7L0a0Jfti/fFhbODBCMafyCbZiLfk2bDoBPRRWLGAm07o8FNEluU4LG0pF
 8t8UCEoVVo75OqTOhalkBHX5WjV8f1lcaPOip8MAEbbuCBKiaT2LrM5OyBG8q2n5MEsZ/YpTu
 s1VSgj4kVS64/ZCo1g3hTKp9s2S9spEm6V4xOwRxTrU9+4TenyCcKhhRwgqYBnkZ6SqRvzq6R
 BGdKe9kORKHp/eCN3+KURPVbQTBuTQwQzGKVvUfQIUq56Gd/6QaMff2X/wg9rEVCCFoVSAZ2/
 IRWyD+InxivbrmsjWDa8ctFT81MWqYUYw6O4Vzf+WB4h2vVHcU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Will the rule set be more consistent then?
> 
> If E1 is not bound by the kem_cache_alloc rule, then it will match anything.

How much was such a software behaviour intended by the discussed SmPL script?


> The user can check if it is appropriate.

How does such an information fit to expectations for safe source code analysis?


> Another option would be to use the type of the variable storing the result
> of the call to compute the expected size.

How would this suggestion help here?

Regards,
Markus

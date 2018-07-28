Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE212C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9319120893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9319120893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeG1SRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 14:17:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:37069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeG1SRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 14:17:46 -0400
Received: from obelix.fritz.box ([87.122.99.93]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9NE-1fkYt925c4-00GYIM for
 <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 18:50:39 +0200
From:   "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: Re: Linux 4.17.11
To:     linux-kernel@vger.kernel.org
Message-ID: <3a976c32-555b-ab68-3e2d-d5fbe7743d58@gmx.de>
Date:   Sat, 28 Jul 2018 18:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ReGdRkg2Wti3GeLkbDLXuGZjazk3d+dO4wYIJU4I8HMAnRCgJcc
 0XS8ReQy2i0p/51Wm/2ZcWaXDV8KnEPNRI18U/jTPrsKQQkBIkuZi6qwtGJlCRelOgbck9j
 VYzEATaO1wM64/flsEmRlVMrALaFJLBMGAilS3VKVKv20JhdNM4Y2pvJLFbpGyMwX6GIwBU
 OaqkCoIzeVibfFKJ3VByA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1V+poZHVuMY=:/z9S+E+Pouala0w5iELawt
 tsKYnSIj1uGILNIoqIJqHb3CwLhEH49GgzU6x4taEOuuz1YJv1DJ7RZILasSCdJSvxNrgXQGJ
 XungRUZdx2oSaBu1RhFFqbB5GxzuapPRU56BPp6YwuEquzgpzfPDXIQwANw/yoxLZ+Jt2p3m8
 WFQkJ5UyP4bpIAkdgD7rEPyOUJKK+leZOPC4xnRjqCRMATbn5yGNZJ25IWToBWpfYWziM0vUj
 pa8EBpGtyjxhdTpfD8hXT2qkU6VEHF4cbB2bV8a29eTphRnYwSz9dcf19/6AvcxxWrsRk5oF8
 +5vpRM8cEURy7pXFQh8mHqxfeqVmkvhmc+SIBxhdT9AI28/NcLeGzecuBSbN4ue3S+/x0/9jE
 uHcz4As5BhoS4tMUBbZIhofnN8lcNQHNLtaJ/V7LjoG+I117mi/g+ylnqKpIyjlZXRxn7SnEc
 AyXdOMt+xNxrg3rrm0v6vgwkq7J2UF7YIhgs9L3N6MqVmJlFHbmLpktSXakiVohkiPftKAv6p
 XVflA84u3pi8xrgmhfMMZJWZPHSnqa4b3uFKKHXf/NytZ8MkmvE39ZaiAjVXMJxr5bW9lnsCf
 KNc4J0BT4yEhDIAsLEr+pc9muK5CxBjFXImoqF/LT0Q8rob54QCmAK9fSvXQhVM5FG21TqjvD
 zwCTPp1P1UyckQ1nWEuKCnPPu4bQzfTWI5S9i8uT48qpcqiL0u11utOgNMvlEjCeXEz1cWxrS
 lWfiCLTYBCoyA0rgsA1bI9aLl17t0j5/mDj+delosXNwT//AGUAvAMxuc8YVlhSvR1/Cip70C
 GjpFrpi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

I see this since 4.17.11:


[    0.282161] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.282269] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.282375] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.282657] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.282762] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.282868] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.282973] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.284001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.284106] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.284254] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.284359] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.284464] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.285235] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.285473] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.285709] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.286190] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.286425] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.286661] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.286897] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.287000] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.287237] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.287988] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.288001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.288237] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.288482] ACPI Error: Unimplemented data type: 0x0 
(20180313/dsobject-549)
[    0.299831] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.300001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.300236] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)
[    0.300513] ACPI Error: Result stack is empty! State=        (ptrval) 
(20180313/dswstate-65)
[    0.300749] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null 
operand (20180313/dsutils-612)
[    0.300984] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 
(20180313/dsutils-727)



do I need to worry about  - box runs as usual - ?


-- 
bis denne ... ;-)

Ronald

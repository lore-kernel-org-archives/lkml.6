Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFDTfe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:35:34 -0400
Received: from mail.medvecky.net ([85.118.132.146]:41110 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFDTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:35:33 -0400
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Ivan Ivanov <qmastery16@gmail.com>
Cc: Josh Boyer <jwboyer@kernel.org>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        suravee.suthikulpanit@amd.com, Tom Lendacky <thomas.lendacky@amd.com>,
        Jon Grimm <jon.grimm@amd.com>
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
 <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
 <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
 <20180531220503.2jqs3oiqsnw7ye2t@khazad-dum.debian.net>
From: Rudolf Marek <r.marek@assembler.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=r.marek@assembler.cz; prefer-encrypt=mutual; keydata=
 xsBNBFN2VH4BCADpv+3Tkikr+X489Xso9UC719YdxgGiy0xBjDiWC22wAd3tHy6G3nEhWfh4
 1UNGcqscPAvJMn2GhgSJRfBzj0wALXLkoTYta78wEK+Ji+Gs7PX9VhqRKt9/OIn/2XJ1Yv9i
 e8uo9MFBGFCB5roz+Ws8rdXq0Quu7VZylzRv7qqhxMAk9RvXCT2tyt6XY16R7ZEL9wbSLRAl
 h8LRPMF0iiLH1YenfSCX2XkW7eA7CJSjh9pwIBFOF5cd5mcT69OPO+TuAbdvgCcZPEoQQBhk
 QmOr2PlUOl3CSgqtTxjAjAxXhPTU7Q3xxgB2Oa7xbt3Eic2Z4lltP/dowULZqXvsC5DxABEB
 AAHNI1J1ZG9sZiBNYXJlayA8ci5tYXJla0Bhc3NlbWJsZXIuY3o+wsB+BBMBAgAoBQJTdlR+
 AhsjBQkJZgGABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDAb22rZM9dcMf1B/97PHhB
 YaPoM4PHlk3o3HEs0ZxiJyVqDLpmM8kOh+Pcvb40KX0uebiODfeff+RYJWOff27la7AzqG20
 dEAi3hpHYVigZWf3BaLXwCbUKlyLLydks4qydfKBG62PnM74sW1M/sfFA/bdzC9tnjy4G9r9
 mXNBJBDHb4XuHeukqlrMLDDGW78wrfv4tjtW9Z3Aoroja9CnxREt6c3iHA50TX65BrthPxhF
 c+ES+4J/uuBe6pfq9PN8HZKBWgK+jhCoyCajck964ccVF1a2uTRhN39gXtA2YpKUqb+dcsp+
 2NH2eBVYZYaPVJIoIWPxhriOHszs+NjOkk+jBw2gVLy4bmOlzsBNBFN2VH4BCADsg91uA/mm
 l6APO+aWyqkiPjENreT2DT2gmoaEkp07jZrzNcQrLyNhGhsH6+UtCJLV9YNHbfJb7wsfXmXh
 IRh+TQYLJlrU4tBqvVB0F24+MEAFdt/1/jAmaihRZWKdE/Ogtt0YV7BEKfJk2KZxrG4wLB4G
 g57kI+aVmoVRl7/WmM46JpOJhBqvI6/Pw/ZIDhJZfrOXCCWM3pYjx0ftkkULPl6E6dXv3V7N
 9dMV4bqNj4PDfysptFoVo02AblHqMmmBQ2LcI+o5HNm2iPyTklKMmq8Z5kblXDR6GXe2rO5c
 5j0vQ6q5uSyVa30JNJcfl2iUT2akFv7n+RRWhlyCItjpABEBAAHCwGUEGAECAA8FAlN2VH4C
 GwwFCQlmAYAACgkQwG9tq2TPXXAq4Af/UhDBiEaW/s1gDmtci6ZBTDetOdWGx69dzD2rIm1b
 OoQiO1EZ+WNFe0RFmMByfCsRVXP4iD/Ly1l0c6ZNvCBPR+ssXlnltE0Z1S43ZrR4gYjWw2GM
 y1EcSOLv6Yvt/+8IS6YANlzR6RRBs2pM1ndM2AhI43k2rpGFarNEX7z9QrdcoZ4rY94DUGwZ
 0hlQ5VrGt/DAnMkJmOkr6Yriiybw8COnw4qigLfZH6b87vUqdBjRr3BR0iD3ahiXUY0bhlX2
 bQE1IdT8+enQsm4+ePcC8Oihl8Y9JI/cBCw3eEZOl2p1+8aRq7tGkLsilWXUCDJ2kCDQixCJ
 RoTzi/gSro2qhg==
Message-ID: <6402a30f-04d3-59d9-92df-5a43e2060f5c@assembler.cz>
Date: Mon, 4 Jun 2018 21:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531220503.2jqs3oiqsnw7ye2t@khazad-dum.debian.net>
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

Any news on this please? It seems we still miss updated microcode for certain fam15h/16h for Linux.

Thanks
Rudolf


Dne 1.6.2018 v 00:05 Henrique de Moraes Holschuh napsal(a):
> On Wed, 30 May 2018, Ivan Ivanov wrote:
>> This is still not addressing the outdated 15h microcode version issue
>> that Rudolf Marek has pointed out. Also, we still hope to see an
>> updated microcode for 16h architecture as well - it has not received
>> any updates for two years already
> 
> True, but now at least it won't regress old boxes anymore, so we can
> ship it in the stable branches of the distros with less restrictions.
> 
> It would be really good to be able to actually mitigate spectre v2/v4 on
> most AMD systems, though.  And current experience shows this is only
> going to happen if we can have the required microcode update also going
> through the operating system update channels.



> Dne 24.5.2018 v 16:48 Hurwitz, Sherry napsal(a):
>> Thank you for pointing this out.  Let me investigate and send out an updated fam15h container.
> 
> Thanks I have seen the patch. However it still contains "old" microcode from 2012, patch level
> 0x06001119. Do you plan to update it to 0x0600111f, which will support IBPB?
> 
> Thanks
> Rudolf
> 
> 

> I noticed in commit [1], that 0x00610f01 microcode is removed completely. It has only entry in the equivalence table,
> but the actual microcode is gone. As this update fixes important errata (and it was latest supported microcode officially released), what is the reason behind that?
> 
> Maybe it is a mistake? Or new microcode will be provided? I seen in the wild one with patch level 0x0600111f, but it does not
> seem to be available?
> 
> Please can someone throw some light on that? 
> 
> Many thanks
> Rudolf
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amd-ucode/microcode_amd_fam15h.bin?id=77101513943ef198e2050667c87abf19e6cbb1d8

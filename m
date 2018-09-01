Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB5C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5FF2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5FF2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIAUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:07:20 -0400
Received: from mail.medvecky.net ([85.118.132.146]:50636 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeIAUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:07:20 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2018 16:07:17 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.medvecky.net (Postfix) with ESMTP id 3F9B45E2002;
        Sat,  1 Sep 2018 17:40:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at medvecky.net
Received: from mail.medvecky.net ([127.0.0.1])
        by localhost (slovakia.medvecky.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id on7xRb6_XdbA; Sat,  1 Sep 2018 17:39:57 +0200 (CEST)
Received: from [192.168.88.62] (ip-89-176-80-18.net.upcbroadband.cz [89.176.80.18])
        by mail.medvecky.net (Postfix) with ESMTPSA id 958B45E2001;
        Sat,  1 Sep 2018 17:39:56 +0200 (CEST)
Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
To:     "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Ivan Ivanov <qmastery16@gmail.com>
Cc:     Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
 <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
 <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
 <20180531220503.2jqs3oiqsnw7ye2t@khazad-dum.debian.net>
 <6402a30f-04d3-59d9-92df-5a43e2060f5c@assembler.cz>
 <MWHPR1201MB2526CF0F174938EA64156AE98B660@MWHPR1201MB2526.namprd12.prod.outlook.com>
From:   Rudolf Marek <r.marek@assembler.cz>
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
Message-ID: <b01e8484-17e6-5253-5d83-9d864c66a7f9@assembler.cz>
Date:   Sat, 1 Sep 2018 17:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <MWHPR1201MB2526CF0F174938EA64156AE98B660@MWHPR1201MB2526.namprd12.prod.outlook.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

Dne 5.6.2018 v 16:27 Hurwitz, Sherry napsal(a):
> Hi Rudolf, I have been investigating the status with the AMD release
> management, but I have not been given approval to publish any other
> microcode.  I have been trying to track down why there might be a
> version in the wild that I have not been given for public publishing.
> It might have come from a BIOS update and not a OS microcode load but

Yes exactly. Why this exists? Is there some technical restriction that will prevent
microcode loading just in Linux? I think it would be beneficial to have at least
the IBPB protection in place via microcode updates.

> I don't have the definitive details on that either.  I will publish
> whatever is released to me as soon as possible.

Any news on this? The family 15h microcode revision provided for Linux is 0x06001119 but I know that 0x0600111f
exists, which provides the IBPB.

Btw I also think that Family 17h (0x00800F11) Linux microcode update has a same problem.

It does not include IBPB support right? It is included in the "BIOS" only microcode revision 0x08001137.

Thanks,
Rudolf

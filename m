Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D134C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeLQQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:45:43 -0500
Received: from nbd.name ([46.4.11.11]:34360 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387669AbeLQQpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:45:43 -0500
Subject: Re: [PATCH] pinctrl: xway: fix gpio-hog related boot issues
To:     Linus Walleij <linus.walleij@linaro.org>,
        Martin Schiller <ms@dev.tdt.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181214074825.6976-1-ms@dev.tdt.de>
 <CACRpkdaTR-Bb6MBtP34GCEtjqfxSNr5PQjDZ_PFqX2B+odGu-w@mail.gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <f84d3544-417d-182e-2dd1-8a79585c40e5@phrozen.org>
Date:   Mon, 17 Dec 2018 17:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaTR-Bb6MBtP34GCEtjqfxSNr5PQjDZ_PFqX2B+odGu-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/12/2018 15:32, Linus Walleij wrote:
> On Fri, Dec 14, 2018 at 8:48 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
>> This patch is based on commit a86caa9ba5d7 ("pinctrl: msm: fix gpio-hog
>> related boot issues").
>>
>> It fixes the issue that the gpio ranges needs to be defined before
>> gpiochip_add().
>>
>> Therefore, we also have to swap the order of registering the pinctrl
>> driver and registering the gpio chip.
>>
>> You also have to add the "gpio-ranges" property to the pinctrl device
>> node to get it finally working.
>>
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Patch applied unless John Crispin has objections, it looks
> good to me!
>
> Yours,
> Linus Walleij


sorry did not see the patch in my inbox

Acked-by: John Crispin <john@phrozen.org>


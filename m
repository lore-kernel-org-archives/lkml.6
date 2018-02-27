Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeB0L2J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:28:09 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:39407 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeB0L2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:28:07 -0500
X-Google-Smtp-Source: AG47ELvxlCxCmmSY/uVwh3FTOfv9/LmTn1+uWkGZOTbW8TA/A6cMNWtEEHS445KgNwHT7z7GU1eebl1Df10dTLUL/SY=
MIME-Version: 1.0
In-Reply-To: <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
References: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
 <CGME20180223014048epcas5p293b090a79d10de2653428d6fec57a203@epcas5p2.samsung.com>
 <f87c7d91-8b26-bf63-5323-5c60b00c81e4@rock-chips.com> <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Feb 2018 12:28:06 +0100
Message-ID: <CAPDyKFp7Aik0U49cFZGMamw8xe+=yakGjfuMgbvgFrQA-t=VXQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 07:30, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/23/2018 10:40 AM, Shawn Lin wrote:
>> Hi Alexey,
>>
>> On 2018/2/23 3:45, Alexey Roslyakov wrote:
>>> cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
>>> Unfortunately, inline documentation was not updated so far.
>>>
>>> Fix @lock field documentation in Locking section.
>>> Move @mrq field of struct dw_mci_slot mention closer to it
>>> description, so no one could miss this slightest detail.
>>>
>>> Couple of code style fixes as a bonus.
>>>
>>
>> Thanks for updating these.
>>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Thanks! Will apply this with Shawn's Reveiwed-by tag.

Dear Jaehoon, I picked this up for next and by adding your ack. Tell
me if you have objections!

[...]

Thanks and kind regards
Uffe

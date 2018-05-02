Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEBOhO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:37:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34716 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:37:11 -0400
X-Google-Smtp-Source: AB8JxZo4+X0bkQbl2Vr0D6UmT7poPyjNjwjzompipiNS1rFxwQi828fJXOYHIA2Oa+Bn2VI7sbPYE0IHeFQtRTJSppo=
MIME-Version: 1.0
In-Reply-To: <20180502043230.GQ6014@localhost>
References: <2484918.HKVQc3yJkt@bear> <20180502043230.GQ6014@localhost>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Wed, 2 May 2018 10:37:09 -0400
Message-ID: <CAJz5OpfTVD7aEH8DK-nSdSrbaS-1DcSK+44FKHkej59KDUX=dw@mail.gmail.com>
Subject: Re: [PATCH] Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod Koul <vinod.koul@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 12:32 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Sat, Apr 28, 2018 at 05:50:58PM -0400, Frank Mori Hess wrote:
>> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
>>
>
> I am dropping the orignal patch for queue, so no need for revert patch.
>

I don't understand, 88987d2c7534a0269f567fb101e6d71a08f0f01d made it
into the mainline kernel in 2015?


-- 
Frank

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeDCXdx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:33:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33765 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753540AbeDCXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:33:51 -0400
X-Google-Smtp-Source: AIpwx49O9b9T+X1hIxBqVHzmB3rI5mJub5bFSjlUpUQd2yiViTGN9jbFdbtTRqzxPPh0tKOUqHKHGA==
Subject: Re: [PATCH 00/12] SWIM driver fixes
From: Jens Axboe <axboe@kernel.dk>
To: Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1522546571.git.fthain@telegraphics.com.au>
 <bdeed6f8-674a-3700-1510-c574da676d81@kernel.dk>
Message-ID: <9ac0587d-6a45-c7c4-c78e-88e10fce75cb@kernel.dk>
Date: Tue, 3 Apr 2018 17:33:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bdeed6f8-674a-3700-1510-c574da676d81@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/18 5:32 PM, Jens Axboe wrote:
> On 3/31/18 7:41 PM, Finn Thain wrote:
>> This patch series has fixes for bugs in the SWIM floppy disk controller
>> driver, including an oops and a soft lockup.
>>
>> There are also patches to add support for SWIM devices connected to IOPs.
>>
>> Geert, would you please take this series through the m68k tree once the
>> necessary "acked-by" tags arrive?
>>
>> Jens, I've Cc'd you too because there's no official maintainer for
>> drivers/block/swim.c and none for the drivers/block/ directory either.
> 
> The latter should just be added to the BLOCK LAYER entry.

Actually, when Linus takes the pull request, it will be there:


commit fc9de9a52e993829d928825d05fc9d3f41ce33fa
Author: Ross Zwisler <ross.zwisler@linux.intel.com>
Date:   Fri Mar 9 09:38:26 2018 -0700

    MAINTAINERS: add coverage for drivers/block

-- 
Jens Axboe

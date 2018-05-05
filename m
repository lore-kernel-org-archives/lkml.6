Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEEAf3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:35:29 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:39258 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeEEAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:35:28 -0400
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Re: Oops on the system startup in the function part_in_flight()
Organization: Candela Technologies
Message-ID: <b0b6d6b6-b9ba-a9d8-749a-5f252a738fae@candelatech.com>
Date: Fri, 4 May 2018 17:35:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to bisect a pktgen related performance regression that appears to
be between the 4.13 and 4.14 kernels.  But, my system keeps crashing due to part_in_flight
oops so bisecting is not going well.

It looks like this oops was fixed, but the link to the patch in the email is no longer
valid.  Can someone let me know what patch fixes this crash so I can apply it while
bisecting?

https://www.spinics.net/lists/linux-block/msg17809.html

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeEECAw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:00:52 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36313 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeEECAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:00:51 -0400
X-Google-Smtp-Source: AB8JxZpq2vXDkcoZVDN5go8OxGujv8iUs1C8loKOo0DwFrfMwXlGLhDLj7jtzVmpBPUQh4bjFCSIRA==
Subject: Re: Oops on the system startup in the function part_in_flight()
To: Ben Greear <greearb@candelatech.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b0b6d6b6-b9ba-a9d8-749a-5f252a738fae@candelatech.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0ce582fd-8630-9e48-a0fe-52426618936e@kernel.dk>
Date: Fri, 4 May 2018 20:00:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b0b6d6b6-b9ba-a9d8-749a-5f252a738fae@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/18 6:35 PM, Ben Greear wrote:
> Hello,
> 
> I am trying to bisect a pktgen related performance regression that appears to
> be between the 4.13 and 4.14 kernels.  But, my system keeps crashing due to part_in_flight
> oops so bisecting is not going well.
> 
> It looks like this oops was fixed, but the link to the patch in the email is no longer
> valid.  Can someone let me know what patch fixes this crash so I can apply it while
> bisecting?
> 
> https://www.spinics.net/lists/linux-block/msg17809.html

Should be this one:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=f5c156c4c29a3d87176dd6e5c099388e187ec29b

-- 
Jens Axboe

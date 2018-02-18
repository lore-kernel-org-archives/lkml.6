Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeBRO6P (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:58:15 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:46952 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeBRO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:58:13 -0500
X-Google-Smtp-Source: AH8x227AryyS6ZuclJBSd2KUqTSGfQSWZPOUeMTVx5Pu1ybLQxebvNrVS2pAew7LN6fQgVOGRWU+yXWkBLswqQ4kBMk=
MIME-Version: 1.0
In-Reply-To: <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
 <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com> <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:58:12 +0200
Message-ID: <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
Subject: Re: [PATCH] i40evf: remove redundant array comparisons to 0 checks
To: Colin Ian King <colin.king@canonical.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 6:53 PM, Colin Ian King
<colin.king@canonical.com> wrote:
> On 16/02/18 16:51, Andy Shevchenko wrote:
>> On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:

>>> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>>>                                                         cpu_to_be32(0xffffffff);
>>
>> Can it be one line then?
>
> I re-adjusted the text because checkpatch was complaining.

>>
>>> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>>>                                                         cpu_to_be32(0xffffffff);

For the rest OK, but for the above two how much over 80 it went if
would be one line?
If it 2-3 characters, consider to make it one line. It would increase
readability.

-- 
With Best Regards,
Andy Shevchenko

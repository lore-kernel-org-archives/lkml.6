Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeFAKzq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:55:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33743 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFAKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:55:43 -0400
X-Google-Smtp-Source: ADUXVKLA7rawAksjUDNO/kGfawZ7x2kpGXjgeYE+k4SZhofMtDBv9Cb0CXgKACRAfzb4WAxRJoTlzw82uE77o2/1+uU=
MIME-Version: 1.0
In-Reply-To: <1527778958.3427.16.camel@linux.vnet.ibm.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com> <1527778958.3427.16.camel@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:55:42 +0300
Message-ID: <CAHp75Vc8Bf-aWkuZ_uzdzp5fRQDWLNSansjCsx8MOTCk21OVmg@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] ima: use match_string() helper
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 6:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2018-05-31 at 19:11 +0800, Yisheng Xie wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-integrity@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>
> In the future, the patch's author Signed-off-by is always first.
>
> Thanks, this patch is now queued in the next-integrity branch.

Hmm... It's interesting since git commit -s checks for author's SoB as
a _last_ in the bunch.

Is it configurable?


-- 
With Best Regards,
Andy Shevchenko

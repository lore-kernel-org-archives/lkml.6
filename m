Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeDBSgf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:36:35 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46091 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeDBSgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:36:33 -0400
X-Google-Smtp-Source: AIpwx4+XB+uxqTAcHbTkyFxFLLV73M6zzmTlsRb+uAvoQwcqQingYipEQBeJ0k83r4F9SwT+Ldtk0H1rIWsK6ygpTps=
MIME-Version: 1.0
X-Originating-IP: [95.244.238.104]
In-Reply-To: <20180402091920.2d923720@w520.home>
References: <20180326194121.10256.27009.stgit@gimli.home> <20180402091920.2d923720@w520.home>
From: Alvise Rigo <a.rigo@virtualopensystems.com>
Date: Mon, 2 Apr 2018 20:36:17 +0200
Message-ID: <CAH47eN05NqdkZ8nM5=hC2YZm1ZXjUVmXzThtjOurtTQDjSdFFQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: vfio/platform: Update sub-maintainer
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

As I wrote in the other thread, it was OK by me to be reviewer. I
though only Eric needed to ACK this patch as new sub-maintainer.

Is it too late for ACK-ing it now?

Acked-by: Alvise Rigo <a.rigo@virtualopensystems.com>

Best regards,
alvise

On Mon, Apr 2, 2018 at 5:19 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 26 Mar 2018 13:42:02 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
>> Baptiste has changed positions and has not been active with
>> vfio-platform, replace with the current, de-facto sub-maintainer
>> Eric Auger.  Also add Alvise Rigo as a designated reviewer.
>>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alvise Rigo <a.rigo@virtualopensystems.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>  MAINTAINERS |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 205c8fc12a9c..c6680c189f2b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14687,7 +14687,8 @@ F:    include/linux/mdev.h
>>  F:   samples/vfio-mdev/
>>
>>  VFIO PLATFORM DRIVER
>> -M:   Baptiste Reynal <b.reynal@virtualopensystems.com>
>> +M:   Eric Auger <eric.auger@redhat.com>
>> +R:   Alvise Rigo <a.rigo@virtualopensystems.com>
>>  L:   kvm@vger.kernel.org
>>  S:   Maintained
>>  F:   drivers/vfio/platform/
>>
>
> Receiving only Eric's review, I've committed this with only Eric's
> entry and an updated commit log to reflect that.  Thanks,
>
> Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933590AbeDXN7Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:59:25 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33990 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757821AbeDXN7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:59:17 -0400
X-Google-Smtp-Source: AIpwx4+AJLrWA7y/VVvzWVOMWN0xRD4Ukadn9XNupNHWHhYYJoKfnjTbYpchPBrs3fnm7omlvQAn/w==
Subject: Re: [PATCH v2 1/5] ALSA: xen-front: Introduce Xen para-virtualized
 sound frontend driver
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-2-andr2000@gmail.com> <s5htvs0so92.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <6f9b9e79-e6c8-493a-6dd5-717ec9fab881@gmail.com>
Date: Tue, 24 Apr 2018 16:59:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5htvs0so92.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 04:55 PM, Takashi Iwai wrote:
> On Mon, 16 Apr 2018 08:24:49 +0200,
> Oleksandr Andrushchenko wrote:
>> --- /dev/null
>> +++ b/sound/xen/Kconfig
>> @@ -0,0 +1,10 @@
>> +# ALSA Xen drivers
>> +
>> +config SND_XEN_FRONTEND
>> +	tristate "Xen para-virtualized sound frontend driver"
>> +	depends on XEN && SND_PCM
> Please do select SND_PCM instead of depends.
will do
>> +	select XEN_XENBUS_FRONTEND
>> +	default n
> "default n" is superfluous, drop it.
will drop
>
> thanks,
>
> Takashi
Thank you,
Oleksandr

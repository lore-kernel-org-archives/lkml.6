Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFDJgz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:36:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39979 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFDJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:36:53 -0400
X-Google-Smtp-Source: ADUXVKLTvfWcbtBZV+jNtiZoXOtsbA0Uf/e7mcnVkc38mBv2w2VjkF30j3voOpJ+I+ZtPhSuClUu/oNJfzSRKn1hUbc=
MIME-Version: 1.0
In-Reply-To: <1528104679.2728.8.camel@pengutronix.de>
References: <20180529134727.GA18374@jordon-HP-15-Notebook-PC> <1528104679.2728.8.camel@pengutronix.de>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 4 Jun 2018 15:06:51 +0530
Message-ID: <CAFqt6zaQAw3sXq__THz-w=Z6MJjgGDazOiQi3-ZPhzwGzRrsOg@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: etnaviv: Change return type to vm_fault_t
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, airlied@linux.ie,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, linux+etnaviv@armlinux.org.uk,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 3:01 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 29.05.2018, 19:17 +0530 schrieb Souptick Joarder:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_page() returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_page() will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> vmf_error() is the newly introduce inline function
>> in 4.17-rc6.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> Thanks, applied.
>
> This won't be part of 4.18, as it's obviously too late for this
> release, but will work it's way upstream with the next batch of etnaviv
> updates.
>
> Regards,
> Lucas
>

Thanks Lucas :)

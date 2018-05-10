Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966175AbeEJPVn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:21:43 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:37522 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964827AbeEJPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:21:42 -0400
X-Google-Smtp-Source: AB8JxZoQXj70By09vHtRGJb/wld794a5AhGIdkJRyuYOGKJ1BvOz73eWnGxuZPrxZ/qxLvhTkEZWeKZ10tV7L37WOds=
MIME-Version: 1.0
In-Reply-To: <20180424123513.53opt3ufe47i5db7@sirius.home.kraxel.org>
References: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
 <20180423104924.ozalv7x5ppjifnxc@sirius.home.kraxel.org> <20180424121151.GX31310@phenom.ffwll.local>
 <20180424123513.53opt3ufe47i5db7@sirius.home.kraxel.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 10 May 2018 20:51:39 +0530
Message-ID: <CAFqt6zYwCgzBkbeRFgOHGRaYT5EqaAybXQ5_E73cBLEc7Hzv8A@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: qxl: Adding new typedef vm_fault_t
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd /Daniel,

On Tue, Apr 24, 2018 at 6:05 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Tue, Apr 24, 2018 at 02:11:51PM +0200, Daniel Vetter wrote:
>> On Mon, Apr 23, 2018 at 12:49:24PM +0200, Gerd Hoffmann wrote:
>> > On Tue, Apr 17, 2018 at 07:08:44PM +0530, Souptick Joarder wrote:
>> > > Use new return type vm_fault_t for fault handler. For
>> > > now, this is just documenting that the function returns
>> > > a VM_FAULT value rather than an errno. Once all instances
>> > > are converted, vm_fault_t will become a distinct type.
>> > >
>> > > Reference id -> 1c8f422059ae ("mm: change return type to
>> > > vm_fault_t")
>> >
>> > Hmm, that commit isn't yet in drm-misc-next.
>> > Will drm-misc-next merge with 4.17-rcX soon?
>>
>> For backmerge requests you need to cc/ping the drm-misc maintainers.
>> Adding them. I think the hold-up also was that Dave was on vacations
>> still.
>
> Ah, ok.
>
> So my expectation that a backmerge happens anyway after -rc1/2 is in
> line with reality, it is just to be delayed this time.  I'll stay
> tuned ;)

Is this patch already merged in drm-misc-next tree ?

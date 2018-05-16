Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeEPEfM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:35:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46193 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeEPEfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:35:10 -0400
X-Google-Smtp-Source: AB8JxZp3e9vGX7eC2WzG2zkdlnB/IGDl7jRd8YTr1GSe9VHK5ctsNY4339kNOiLDwXWjM6NbSx2+n0ZuCqeocANyslY=
MIME-Version: 1.0
In-Reply-To: <20180511092205.GB16141@n2100.armlinux.org.uk>
References: <20180510150448.GA26306@jordon-HP-15-Notebook-PC> <20180511092205.GB16141@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 16 May 2018 10:05:08 +0530
Message-ID: <CAFqt6zY2amJC4bkRZJgjs7=wCuTTxZbufk9cXcMZLE8VGh_dww@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 2:52 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, May 10, 2018 at 08:34:48PM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler in
>> struct vm_operations_struct. For now, this is just
>> documenting that the function returns a VM_FAULT
>> value rather than an errno. Once all instances are
>> converted, vm_fault_t will become a distinct type.
>>
>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_pfn() returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_pfn() will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Thanks.

If no further comment, we would like to get this patch in queue
for 4.18.

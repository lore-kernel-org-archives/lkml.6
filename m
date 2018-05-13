Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeEMCvT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:51:19 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:40351 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeEMCvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:51:18 -0400
X-Google-Smtp-Source: AB8JxZp/+v74RA1IRvxjkueQBB6nEJxhzfxj2RoyGlht78DXHkY/dAQTokqWhdmJNCisn++EF3WKi3Np45ITjfL+0ac=
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb9KzPw0ih3fOs6DNd3RCcy9GYmxZ607_w7obn0Kym7Kw@mail.gmail.com>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
 <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
 <20180512142451.GB24215@bombadil.infradead.org> <CAFqt6zb9KzPw0ih3fOs6DNd3RCcy9GYmxZ607_w7obn0Kym7Kw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 12 May 2018 19:51:17 -0700
Message-ID: <CAPcyv4gYp4_9h1hsQOiHeEUX3TBZCsFWZkzrdcCi+YZ2QOKhxw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 12:14 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> It'd be nicer to realign the 2nd and 3rd arguments
>>> on the subsequent lines.
>
>>>
>>>       vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>>>                           struct vm_area_struct *vma,
>>>                           struct vm_fault *vmf);
>>>
>>
>
>> It'd be nicer if people didn't try to line up arguments at all and
>> just indented by an extra two tabs when they had to break a logical
>> line due to the 80-column limit.
>
> Matthew, there are two different opinions. Which one to take ?

Unfortunately this is one of those "maintainer's choice" preferences
that drives new contributors crazy. Just go with the two tabs like
Matthew said and be done.

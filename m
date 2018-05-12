Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeELTO0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 15:14:26 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35202 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeELTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 15:14:25 -0400
X-Google-Smtp-Source: AB8JxZoLIc1QED3JTh/hpOy3ZiqLCGtY2BIMPX0OHR7J39/5DvIOy7QAhr0U0t/VAjFJ0RACLWjrG7zo+t47eU6Miqc=
MIME-Version: 1.0
In-Reply-To: <20180512142451.GB24215@bombadil.infradead.org>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
 <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com> <20180512142451.GB24215@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 13 May 2018 00:44:23 +0530
Message-ID: <CAFqt6zb9KzPw0ih3fOs6DNd3RCcy9GYmxZ607_w7obn0Kym7Kw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> It'd be nicer to realign the 2nd and 3rd arguments
>> on the subsequent lines.

>>
>>       vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>>                           struct vm_area_struct *vma,
>>                           struct vm_fault *vmf);
>>
>

> It'd be nicer if people didn't try to line up arguments at all and
> just indented by an extra two tabs when they had to break a logical
> line due to the 80-column limit.

Matthew, there are two different opinions. Which one to take ?

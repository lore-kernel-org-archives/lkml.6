Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEJXTj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:19:39 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33120 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeEJXTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:19:35 -0400
X-Google-Smtp-Source: AB8JxZqooa2b9KnuqUNdsx1gPhVBl+XIDQedf5qQ1XzGRf8DVneTNYud9qaLY2I2L1ZpOy26DNXWu+57VCqdcJFWO8A=
MIME-Version: 1.0
In-Reply-To: <20180510161242.0f9f97686a9c0a47f07eef4e@linux-foundation.org>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180508174424.GA12638@linux.intel.com> <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
 <CAPcyv4hy40dRr81aO7mr5LhC4L=es6NXE_kDCO2+USGXovGDiQ@mail.gmail.com> <20180510161242.0f9f97686a9c0a47f07eef4e@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 10 May 2018 16:19:34 -0700
Message-ID: <CAPcyv4jpxLarYA3UmWdCu54MR-eYZJO9j22h7_VR27Bkaejkdw@mail.gmail.com>
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 4:12 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 10 May 2018 15:54:53 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
>> > - The Fixes: tag
>> > - The Reported-by
>>
>> Those were there.
>>
>> > - Jan's reviewed-by
>>
>> Right, Jan's came after I pushed it for -next soaking, but I updated it.
>>
>> > - the cc:stable tag
>>
>> That was there too, not sure where you were looking.
>
> git show 4272afac65e0debacae7eb6af4591e31ba89dcad

That was the unit test suite patch, see the following actual fix:

7fa96cd88dbc: before Jan's reviewed-by

ce376ed6b706: after

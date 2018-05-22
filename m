Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbeEVVU6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:20:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36778 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeEVVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:20:54 -0400
X-Google-Smtp-Source: AB8JxZr5wWf4ArLHadP/M1DZvs44+tWm+7YgjefYgHkJjI0UZatzz4c205qhk3ShtyDI8+Zgsreh4KH9lqtxlV0oghc=
MIME-Version: 1.0
In-Reply-To: <27199a35-922b-c57d-3c50-e9954a5d80a0@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com> <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com> <CAJZ5v0hOC5P79OGAfutLcWzRuh+r9wrf2i3LOVs5VfGqbmoitA@mail.gmail.com>
 <27199a35-922b-c57d-3c50-e9954a5d80a0@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 23:20:53 +0200
X-Google-Sender-Auth: ZSFx_nS99zPYZIfw2g-2VrhhjZs
Message-ID: <CAJZ5v0gF4XtEWyWV-Dwu6NttN8R-a4VPOSp0EsFaQF7tvHk_Lg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to ghes_cper_severity()
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 8:20 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
> On 05/22/2018 01:13 PM, Rafael J. Wysocki wrote:
> (snip)
>>
>> Of course, you are free to have a differing opinion and I don't have
>> to convince you about my point.  You need to convince me about your
>> point to get the patch in through my tree, which you haven't done so
>> far.
>
>
> My point is that crossing your arms and saying "impress me" doesn't give me
> a good idea of how you'd like to see the problem resolved.

I do not recall having said "impress me" at any time during our
conversation so far.

Also this problem space is not the one I'm focusing on and I can't
tell you how to address the problem you want to address in that space
from the top of my head.  I can only look at what you post and decide
whether or not I agree with that.  It has to be well documented and
convincing enough, however, and it hasn't been so far in my view.  As
a rule, I'd rather not apply patches that I don't feel confident of.

Tony seems to agree with you, so maybe work with him on making your
case stronger.

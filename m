Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeEVSN1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:13:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43018 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeEVSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:13:24 -0400
X-Google-Smtp-Source: AB8JxZrlhoNXIB2GiqlIBv95F4JZcO4Au3eng1zk7vtFVob/9OEb5NHKc0bzqm+IpJsj7DjfVtWelIFmQ0W2dUHHLSg=
MIME-Version: 1.0
In-Reply-To: <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com> <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com> <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 20:13:22 +0200
X-Google-Sender-Auth: q9WrEqnZKK6Hm3tg1ra28amYSy8
Message-ID: <CAJZ5v0hOC5P79OGAfutLcWzRuh+r9wrf2i3LOVs5VfGqbmoitA@mail.gmail.com>
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

On Tue, May 22, 2018 at 3:38 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
>
>
> On 05/22/2018 03:55 AM, Rafael J. Wysocki wrote:
>> On Mon, May 21, 2018 at 3:49 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>>> ghes_severity() is a misnomer in this case, as it implies the severity
>>> of the entire GHES structure. Instead, it maps one CPER value to a
>>> GHES_SEV* value. ghes_cper_severity() is clearer.
>>
>> It looks like the *real* reason for this change is that you
>> re-introduce ghes_severity() as a different function in the second
>> patch.
>
> /me holds fist at Borislav
>
>> There are a couple of reasons to avoid that, one of them being that
>> people will now have to remember what the function did in which kernel
>> versions.
>
> So?
>
>> Also, the current name is good enough IMO,
>
> Two other reviewers were extremely confused by the vague name, so no,
> this is not good enough.

Of course, you are free to have a differing opinion and I don't have
to convince you about my point.  You need to convince me about your
point to get the patch in through my tree, which you haven't done so
far.

>> so I'm not going to apply this patch.

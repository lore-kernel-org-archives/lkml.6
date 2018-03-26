Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCZSET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:04:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34150 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:04:17 -0400
X-Google-Smtp-Source: AG47ELtd9AS9zKpfcYcPVE5uGZIZhCW1PN8mNI+u60GIjC5cnXtodJxES3nt5jEMVLYNEsTfYPsMr4IPdT+fqZCwVeA=
MIME-Version: 1.0
In-Reply-To: <91363263-1ab8-5513-23a3-bbcea802d788@citrix.com>
References: <20180320195658.17498-1-mudongliangabcd@gmail.com> <91363263-1ab8-5513-23a3-bbcea802d788@citrix.com>
From: =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date: Mon, 26 Mar 2018 14:03:45 -0400
Message-ID: <CAD-N9QV0NCfcickCB-paV0Nvqzso4NRgxKDtWSWqEwZ8bMxytA@mail.gmail.com>
Subject: Re: [PATCH] fix one dead link in ia64/xen.txt
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, yamada.masahiro@socionext.com,
        Sergei Trofimovich <slyfox@gentoo.org>, tony.luck@intel.com,
        =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 4:17 PM, Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
> On 20/03/18 19:56, Dongliang Mu wrote:
>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>> ---
>>  Documentation/ia64/xen.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ia64/xen.txt b/Documentation/ia64/xen.txt
>> index a12c74ce2773..464d4c29b8b5 100644
>> --- a/Documentation/ia64/xen.txt
>> +++ b/Documentation/ia64/xen.txt
>> @@ -26,8 +26,8 @@ Getting and Building Xen and Dom0
>>      DomainU OS  : RHEL5
>>
>>   1. Download source
>> -    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
>> -    # cd xen-unstable.hg
>> +    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
>> +    # cd xen-unstable
>>      # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
>>
>>   2. # make world
>
> The last commit in that repository is almost 9 years old, and IA64
> support was dropped from Xen mainline6 years ago.
>
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=570c311ca2c7a1131570cdfc77e977bc7a9bf4c0
>
> There are a number of other dead links in this doc, and those which
> aren't dead refer to Linux 2.6.x.  I'd just remove the entire file,
> rather than pretend that any of this still might work.  (If by some
> miracle it does still function, its 10 years behind on security fixes...)
>

If the situation is like that, I agree to delete this file.

> ~Andrew

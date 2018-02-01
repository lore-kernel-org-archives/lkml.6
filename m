Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBAWqR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:46:17 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44260 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeBAWqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:46:10 -0500
X-Google-Smtp-Source: AH8x226vlIgrUrK41s6afDWPRxZLWk9oqMaKPSoqsSvQFhVRX6+dAtaImmn/XxScga3wojhHITDvAw==
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc: initramfs <initramfs@vger.kernel.org>,
        Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
From: Rob Landley <rob@landley.net>
Message-ID: <a9249307-9c95-ea75-bc83-7b95412e6ec4@landley.net>
Date: Thu, 1 Feb 2018 16:46:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517458921.3329.2.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/31/2018 10:22 PM, Mimi Zohar wrote:
> On Wed, 2018-01-31 at 21:03 -0500, Arvind Sankar wrote:
>> On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
>>> On 01/31/2018 04:07 PM, Mimi Zohar wrote:
>>>> On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I configured in tmpfs and am using rootfs but I want that
>>> rootfs
>>>>> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
>>>>> it?)
>>>>
>>>> I must be missing something.  Which systems don't specify "root=" on
>>>> the boot command line.
>>>
>>> Any system using initrd or initramfs?
>>>
>>
>> Don't a lot of initramfs setups use root= to tell the initramfs which
>> actual root file system to switch to after early boot?
> 
> With your patch and specifying "root=tmpfs", dracut is complaining:
> 
> dracut: FATAL: Don't know how to handle 'root=tmpfs'
> dracut: refusing to continue

"The kernel can't break this buggy userspace package."

"The kernel must give access to a new feature to this buggy userspace
package".

I think kernel policy asks you to pick one, but I could be wrong...

Rob

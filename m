Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeCOGHw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:07:52 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:50736 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeCOGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:07:51 -0400
X-Google-Smtp-Source: AG47ELvNOv3Nzg0a6sXHFEeeqrpBhREP6A/dYyBx4W2HFAPq9kHexwL+eW20VN3j8BJAdGxBwLmoNNqXLSq17ytI3vI=
MIME-Version: 1.0
In-Reply-To: <d5d16cfa-dbd2-b874-38e4-cbb9d7d783ff@infradead.org>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu> <d5d16cfa-dbd2-b874-38e4-cbb9d7d783ff@infradead.org>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Wed, 14 Mar 2018 23:07:49 -0700
Message-ID: <CAD4SzjtM_q13FaqdjH9bgUCGJ0viYg5TN_8CTa72aHfJe8o0gA@mail.gmail.com>
Subject: Re: [RFC v2 83/83] Sysfs support.
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com, swhiteho@redhat.com,
        miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 5:33 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 03/10/2018 10:19 AM, Andiry Xu wrote:
>> Sysfs support allows user to get/post information of running NOVA instance.
>> After mount, NOVA creates four entries under proc directory
>> /proc/fs/nova/pmem#/:
>>
>> timing_stats  IO_stats        allocator       gc
>
> Hi,
>
> This is all procfs, not sysfs, so the name is (or can be) confusing.
>
> Please change it.
>

Thanks, will fix.

Andiry

> --
> ~Randy

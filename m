Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeBVDgo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 22:36:44 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43494 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 22:36:43 -0500
X-Google-Smtp-Source: AH8x224OgL437BD9FW24S476Hz0gzKMAgvuFnStsNLlrWiqvkhzvJNKZWHc01aOy8Ltz2rCfswOh4WcPIPgtbXiT0Eg=
MIME-Version: 1.0
In-Reply-To: <20180222112931.7001de9e@canb.auug.org.au>
References: <CAEbi=3dGZe8S4pH-jwCZNm4EDA6FnJdUgPZv3CMPRgD=7SpH4Q@mail.gmail.com>
 <20180222112931.7001de9e@canb.auug.org.au>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 22 Feb 2018 11:36:02 +0800
Message-ID: <CAEbi=3ef0YhsWj9Sh6FZPWoaYJEZgtXq6_3u4CnXuqjCCLNOww@mail.gmail.com>
Subject: Re: Pull Request for linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-22 8:29 GMT+08:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Greentime,
>
> On Wed, 21 Feb 2018 16:14:39 +0800 Greentime Hu <green.hu@gmail.com> wrote:
>>
>> Could you please add https://github.com/andestech/linux.git next
>> to linux-next
>>
>> I will be sending pull requests to Linus for nds32 to be
>> included for 4.17 release.
>>
>> https://lkml.org/lkml/2018/2/14/423
>
> OK, I can't actually use your tree as it is at the moment.  It contains
> a set of patches that are copies of some commits in Linus' tree - it
> looks like a rebase gone wrong.  Please fix that up and try again.

Hi, Stephen:

Sorry about that.
I did the following steps this time and please pull again.

git remote add mainline https://github.com/torvalds/linux
git fetch --all
git checkout -b next v4.16-rc1
git am ./tmp/*.patch

Please let me know if I did something wrong.

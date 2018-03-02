Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428120AbeCBNYx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:24:53 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40381 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428105AbeCBNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:24:51 -0500
X-Google-Smtp-Source: AG47ELu7iLg1YHrZ5eS+lTxi5MmuKnZY/AygiVA7elWoTYjgJRyJCznBEIPNSt9t3+4WLjQLc30Fkdf0gqjK/LCVMUo=
MIME-Version: 1.0
In-Reply-To: <09fabc35-438c-2634-b582-bf5a7888b930@mentor.com>
References: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkda26vE3vfuX3ioJduuTh8fyWOZgsZ-e1BbQiwAf=3ZuAg@mail.gmail.com> <09fabc35-438c-2634-b582-bf5a7888b930@mentor.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 14:24:50 +0100
Message-ID: <CACRpkdaCrwn=AZXXvqPL+TR9mfFnJ4RdMRTb+O1EyPkudghnsg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Export host capabilities to debugfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 2:17 PM, Harish Jenny K N
<harish_kandiga@mentor.com> wrote:
> On Thursday 01 March 2018 07:54 PM, Linus Walleij wrote:
>> On Thu, Mar 1, 2018 at 2:17 PM, Harish Jenny K N
>> <harish_kandiga@mentor.com> wrote:
>>
>> Thanks for your patch!
>>
>>> This patch exports the host capabilities to debugfs
>>>
>>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> Is there a corresponding patch to the mmc utils to make use
>> of the exported information? An opaque u32 seems pretty hard
>> to interpret.
>>
>> Yours,
>> Linus Walleij
>
> A sample patch "[RFC PATCH] mmc-utils: host_caps: Add parser to read host capabilities" is submitted.

Nice! :)

Good work.

Yours,
Linus Walleij

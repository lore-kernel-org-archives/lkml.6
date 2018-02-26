Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeBZWBV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:01:21 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34304 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBZWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:01:19 -0500
X-Google-Smtp-Source: AH8x226SFvaXE+ghbIrnwaIJ9ebo7LnWewlPn30zi0PplG/4EkqIFwEl0lnOMHshgm/cJS7b3J0s1eMckzrxaxsTat4=
MIME-Version: 1.0
In-Reply-To: <1519682116.10722.206.camel@linux.intel.com>
References: <20180223220612.35181-1-tony@atomide.com> <1519565632.10722.150.camel@linux.intel.com>
 <20180226215102.GG16043@atomide.com> <1519682116.10722.206.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2018 23:01:18 +0100
X-Google-Sender-Auth: Lgd5ZMEbiZGCYmIrjC78J0w2TWg
Message-ID: <CAJZ5v0i=GShDnTSSNzo8kB0E=8exLCLFmbq42RsT8=No+AP9cQ@mail.gmail.com>
Subject: Re: [PATCHv2] PM / wakeirq: Add wakeup name to dedicated wake irqs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:55 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-02-26 at 13:51 -0800, Tony Lindgren wrote:
>> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180225 13:37]:
>> > On Fri, 2018-02-23 at 14:06 -0800, Tony Lindgren wrote:
>> > >
>
>
>> +     wirq->name = kasprintf(GFP_KERNEL, "%s:wakeup",
>> +                            dev_name(dev));
>
> Can it make one line?

I can fix this up.

>
> In any case,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'll queue up the patch for 4.17 shortly.

Thanks!

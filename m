Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeERIdM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:33:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34736 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeERIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:33:09 -0400
X-Google-Smtp-Source: AB8JxZoqTw8YCLZAvNNU+o1iKWCFV5tPR/29E9z4GyAenbAooYrxiugBgXUdtiTaOYvcd9/XuAYZ4rpEYCMCwQpxH6g=
MIME-Version: 1.0
In-Reply-To: <1a66e15a401b2e1602f26cff5e904f12@codeaurora.org>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-2-git-send-email-skannan@codeaurora.org> <CAJZ5v0geHvVUfL=+x-XNMQt4ygpt8QumOaWSjG268Sbtw9oeKw@mail.gmail.com>
 <1a66e15a401b2e1602f26cff5e904f12@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 10:33:08 +0200
X-Google-Sender-Auth: lrvKsKcdPkbvukxzWttP5tMJpGg
Message-ID: <CAJZ5v0i_nCj=sBSwrTjxCbL74Q-AwXJb5L2fV1e9SEMYACZC=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "cpufreq: Remove policy create/remove notifiers"
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:31 AM,  <skannan@codeaurora.org> wrote:
> On 2018-05-18 01:29, Rafael J. Wysocki wrote:
>>
>> On Fri, May 18, 2018 at 10:24 AM, Saravana Kannan
>> <skannan@codeaurora.org> wrote:
>>>
>>> This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.
>>
>>
>> No explanation, no cake. :-)
>>
>>> Change-Id: Iddde3ef56c9e5b14dcb14f8737899b85e56f5b43
>>
>>
>> S-o-b missing.
>
>
> Sorry, forgot the S-o-b. But there's a long explanation in the cover letter
> :)

Cover letters don't go into git repositories, so please move it to the
patch itself.

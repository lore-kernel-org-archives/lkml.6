Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeERI74 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:59:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39600 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeERI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:59:53 -0400
X-Google-Smtp-Source: AB8JxZpatSd7aNxnKPmskShZWbkut+hMu2ezGPi59nz5MEUkf1XMeJTTF8YsIA++EfmfGoCoPEdNlv+ZiUrEmNZ4Pw8=
MIME-Version: 1.0
In-Reply-To: <e86a168756927b9fe4fb1c6bcc4eb198@codeaurora.org>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-2-git-send-email-skannan@codeaurora.org> <CAJZ5v0geHvVUfL=+x-XNMQt4ygpt8QumOaWSjG268Sbtw9oeKw@mail.gmail.com>
 <1a66e15a401b2e1602f26cff5e904f12@codeaurora.org> <CAJZ5v0i_nCj=sBSwrTjxCbL74Q-AwXJb5L2fV1e9SEMYACZC=g@mail.gmail.com>
 <e86a168756927b9fe4fb1c6bcc4eb198@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 10:59:52 +0200
X-Google-Sender-Auth: V9avNZKyRPjaP1f8s3HnDJvIcb8
Message-ID: <CAJZ5v0iF+76_voPhaUgGDzAzLxPwbNqcxaqU7zSdXXw7m68Jdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "cpufreq: Remove policy create/remove notifiers"
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:47 AM,  <skannan@codeaurora.org> wrote:
> On 2018-05-18 01:33, Rafael J. Wysocki wrote:
>>
>> On Fri, May 18, 2018 at 10:31 AM,  <skannan@codeaurora.org> wrote:
>>>
>>> On 2018-05-18 01:29, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Fri, May 18, 2018 at 10:24 AM, Saravana Kannan
>>>> <skannan@codeaurora.org> wrote:
>>>>>
>>>>>
>>>>> This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.
>>>>
>>>>
>>>>
>>>> No explanation, no cake. :-)
>>>>
>>>>> Change-Id: Iddde3ef56c9e5b14dcb14f8737899b85e56f5b43
>>>>
>>>>
>>>>
>>>> S-o-b missing.
>>>
>>>
>>>
>>> Sorry, forgot the S-o-b. But there's a long explanation in the cover
>>> letter
>>> :)
>>
>>
>> Cover letters don't go into git repositories, so please move it to the
>> patch itself.
>
>
> Will do. Do you have any opposition to what the series is trying to do?

I'm not a devfreq maintainer, so I can afford having no opinion. :-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeD2Gh6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 02:37:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52483 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeD2Gh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 02:37:57 -0400
X-Google-Smtp-Source: AB8JxZoAbuOwJq5yhRfSJiDQQ1Bn1FZY8oK2nO1icmb3i1UYXPJBGxwqf1Wy7turX51Fk0rFA4YD03SVnvxRQZl339o=
MIME-Version: 1.0
In-Reply-To: <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com> <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Sat, 28 Apr 2018 23:37:55 -0700
Message-ID: <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
To: Julien Thierry <julien.thierry@arm.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        daniel.thompson@linaro.org, Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2018 at 4:10 AM, Julien Thierry <julien.thierry@arm.com> wrote:
> Hi,
>
> On 17/01/18 11:54, Julien Thierry wrote:
>>
>> This series is a continuation of the work started by Daniel [1]. The goal
>> is to use GICv3 interrupt priorities to simulate an NMI.
>>
>
>
> I have submitted a separate series making use of this feature for the ARM
> PMUv3 interrupt [1].

I guess the hard lockup detector using NMI could be a nice next step
to see how well it works with lock up detection. That's the main
usecase for my interest. However, perf profiling is also a strong one.

thanks,

- Joel

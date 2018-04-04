Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeDDLuK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:50:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45864 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDDLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:50:09 -0400
X-Google-Smtp-Source: AIpwx4+IdVk5OAWEx2+dBrSRLZeP6sjnf+C1pVQTdbx3hdQgTtJ0swOZeexmF9eYLU58wd0yRxf2sHPJ0ZH0+rhYdgM=
MIME-Version: 1.0
In-Reply-To: <3099c108-6acc-fd54-2aa4-dc323f566291@intel.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
 <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
 <CAPDyKFp_MYRTQmLcfkrZe+Ux9ZBZQgsAaZSzzLteVYS7sW0VCw@mail.gmail.com> <3099c108-6acc-fd54-2aa4-dc323f566291@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 13:50:08 +0200
Message-ID: <CAPDyKFqOn7AfDw31DisPrXbHQqEAiNg=1=OneUa_wvCi7i1xKw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 April 2018 at 13:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/04/18 13:17, Ulf Hansson wrote:
>> On 4 April 2018 at 11:05, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>>> Hi Ulf,
>>>
>>> Do you have some comments on this patch-set?
>>
>> No objections from my side of the series, however I am relying on
>> Adrian's ack before I pick any of the patches.
>
> We don't have any drivers that enable v4 mode.  Really we need that, so that
> we are supporting features that are actually in use.  Equally some evidence
> of testing would be expected.

Right, this makes perfect sense to me as well!

Kind regards
Uffe

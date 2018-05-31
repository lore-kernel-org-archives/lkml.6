Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeEaKsa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:48:30 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2638 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbeEaKs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:48:28 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 31 May 2018 03:48:31 -0700
Subject: Re: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org>
 <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
 <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
 <e313f870-ef27-7721-9395-31671f00ef4a@nvidia.com>
 <CAPDyKFrtSGF79pFf-sx41ru_EVLk3BMg_f_5rK64k==dW=OXPA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6dce0c20-f17f-b1be-6654-4bd7ff6f9b62@nvidia.com>
Date: Thu, 31 May 2018 11:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtSGF79pFf-sx41ru_EVLk3BMg_f_5rK64k==dW=OXPA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/18 11:44, Ulf Hansson wrote:
> On 31 May 2018 at 10:03, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> On 31/05/18 07:17, Ulf Hansson wrote:
>>> [...]
>>>
>>>>> +/**
>>>>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>>>>> + * @dev: Device to attach.
>>>>
>>>> Can you update the description of the above as well?
>>>
>>> Yes, like below?
>>>
>>> genpd_dev_pm_attach_by_id() - Associate a device with one of its PM domains.
>>> @dev: The device used to lookup the PM domain.
>>
>> Yes perfect.
> 
> I assume I can consider this as an ack and tested by tag, both for
> patch 8 and 9?

Yes you can.

Cheers
Jon

-- 
nvpublic

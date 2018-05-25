Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936015AbeEYIXA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:23:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13585 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935921AbeEYIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:22:58 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 May 2018 01:22:57 -0700
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rajendra Nayak <rnayak@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-tegra@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
 <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com>
 <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
 <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
 <1687797a-93f1-7e5c-6060-01c12c070964@nvidia.com>
 <CAPDyKFravSx3h6UnsjNGM2ViZtkxvPMULyVQnoVT9jsEP5az+A@mail.gmail.com>
 <96169281-49b2-121f-0b7e-f54aae66db91@nvidia.com>
 <CAPDyKFp3nMoUoM0LfxcSvJKthwrAKK7yCLAkZMGW-oapUsK7GA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a8064cdb-d11d-ef85-1da3-28113b86af3b@nvidia.com>
Date: Fri, 25 May 2018 09:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp3nMoUoM0LfxcSvJKthwrAKK7yCLAkZMGW-oapUsK7GA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/18 22:21, Ulf Hansson wrote:

...

>> OK, so this bit is a to-do as that is not yet exposed AFAICT. I see that you
>> said 'although we need to extend it to cover cleanup of the earlier
>> registered device, via calling device_unregister().' So if we do this then
>> that would be fine.
> 
> Let me clarify the changelog. It's not a to-do, as it's already done
> as part of $subject patch.

Yes I see it now. OK, then that's fine.

Jon

-- 
nvpublic

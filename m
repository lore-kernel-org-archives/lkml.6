Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeBSQcU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:32:20 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38097 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeBSQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:32:19 -0500
X-Google-Smtp-Source: AH8x2255DjI1a8ncIp4IfGskJCm1Zw5FJXbpTvkLuxQyhQJxkWYLewf4TZnV6t4eC+zYyRJIuq2kAw==
Subject: Re: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc
 on resume
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-7-hdegoede@redhat.com>
 <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
 <e32ac973-fb6a-37f9-ed65-b6865c13d9dd@redhat.com>
 <20180219162919.GH32761@sirena.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <96d18475-c47b-d3d1-9a65-cd3a056e1857@redhat.com>
Date: Mon, 19 Feb 2018 17:32:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219162919.GH32761@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-18 17:29, Mark Brown wrote:
> On Mon, Feb 19, 2018 at 03:02:03PM +0100, Hans de Goede wrote:
> 
>> The is the net/* style of multi-line comments which is used in quite a few
>> places in the sounds/soc dir. I think both styles are accepted under sound/soc?
> 
> I really don't care, whatever people want.

Ok, good to know, so then there is no need to fixup the
comment style here.

Mark, is there anything specific you're waiting for before
merging this series, or are you just waiting a bit to give
people a chance to review it?

Regards,

Hans

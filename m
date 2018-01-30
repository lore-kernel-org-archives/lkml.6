Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeA3CbA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:31:00 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:38391 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeA3Ca7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:30:59 -0500
Subject: Re: [PATCH v19 03/10] video: backlight: Add of_find_backlight helper
 in backlight.c
To: Lee Jones <lee.jones@linaro.org>
Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1516810725.git.meghana.madhyastha@gmail.com>
 <116d160ba78be2e6dcbdcb6855622bce67da9472.1516810725.git.meghana.madhyastha@gmail.com>
 <20180126094839.iksjiw4xj2n62yzn@dell>
 <b9221c2e-590e-405b-349f-908b7f89e6b9@infradead.org>
 <20180129091120.xs74nu75fype2amq@dell>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e7d888c0-03db-94e2-0e2f-25a864a306aa@infradead.org>
Date: Mon, 29 Jan 2018 18:30:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180129091120.xs74nu75fype2amq@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2018 01:11 AM, Lee Jones wrote:
> On Fri, 26 Jan 2018, Randy Dunlap wrote:
> 
>> On 01/26/2018 01:48 AM, Lee Jones wrote:
>>> On Wed, 24 Jan 2018, Meghana Madhyastha wrote:
>>>
>>>> Add of_find_backlight, a helper function which is a generic version
>>>> of tinydrm_of_find_backlight that can be used by other drivers to avoid
>>>> repetition of code and simplify things.
>>>>
>>>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
>>>> Reviewed-by: Sean Paul<seanpaul@chromium.org>
>>>> Signed-off-by: Meghana Madhyastha <meghana.madhyastha@gmail.com>
>>>
>>> Nit: These should be in chronological order.
>>
>> Where does that tidbit of information come from?
>> I have never heard or read that.
> 
> Not sure it is documented anywhere.  It appeared to be the widely
> used, most sensible approach, so I adopted it a few years ago.
> 
> This method provides us with information which would otherwise be
> absent; including description of the patch submission/acceptance path
> and an idea of who did what, when.
> 
> For example:
> 
> Original Author sign-off
> Original Co-author sign-off
> [Additional contributions: rebase, API changes, fix-ups]
> Re-worker's sign-off
> Tester's tested-by
> Reviewer's acked-by/reviewed-by
> Level-2 Maintainer sign-off
> Level-1 Maintainer sign-off
> 
> Are you aware of a more functional/practical/useful method?

No, I'm not.

Do you do anything else with this chronological order?  E.g., do you verify
that someone actually did Ack or Test or Review a patch?

Sean: that dim tool looks interesting. I'll check it out.

thanks,
-- 
~Randy

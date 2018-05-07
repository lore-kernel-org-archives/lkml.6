Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeEGX1B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:27:01 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41378 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeEGX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:26:58 -0400
X-Google-Smtp-Source: AB8JxZri3rLCgIF+5zgTjgX/hNE+oUHT169p9nIzSGZY+3BiFH+TUb+ATDv1D94mwOOYoGQzpMvwTA==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH 00/28] Venus updates
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
 <29a88d99-537f-5fdc-9e6a-8238703ea8d1@xs4all.nl>
Message-ID: <431ff7a2-cef0-59e4-4540-4ed8e8180e55@linaro.org>
Date: Tue, 8 May 2018 02:26:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <29a88d99-537f-5fdc-9e6a-8238703ea8d1@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On  7.05.2018 13:41, Hans Verkuil wrote:
> On 24/04/18 14:44, Stanimir Varbanov wrote:
>> Hello,
>>
>> This patch set aims to:
>>
>> * add initial support for Venus version 4xx (found on sdm845).
>>
>> * introduce a common capability parser to enumerate better
>>    supported uncompressed formats, capabilities by codec,
>>    supported codecs and so on.
>>
>> * also contains various cleanups, readability improvements
>>    and fixes.
>>
>> * adds HEVC codec support for the Venus versions which has
>>    support for it.
>>
>> * add multi-stream support (secondary decoder output), which
>>    will give as an opportunity to use UBWC compressed formats
>>    to optimize internal interconnect bandwidth on higher
>>    resolutions.
> 
> I'm a bit confused about this: is this a purely driver-internal thing,
> or is this exposed somehow to userspace as well? It seems to be purely
> internal.

For now it'll be internal for the driver. In downstream driver it is 
exposed to userspace via custom v4l_control but that is not generic and 
I decided to not expose it.

regards,
Stan

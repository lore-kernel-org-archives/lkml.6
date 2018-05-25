Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965081AbeEYIyk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:54:40 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34662 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964804AbeEYIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:54:38 -0400
X-Google-Smtp-Source: ADUXVKIt2dqLZ9NpTB7jfigNlUYkzw9btLpxqRA1edTL+QvbE3CAKoVfE4zfyIv+ssKo+b7RuMLnH9LBTnfzEOq+wd4=
MIME-Version: 1.0
In-Reply-To: <20180518165408.GA31804@rob-hp-laptop>
References: <44b17778d8f0bf897a316a39516ba2cafecf43c9.1525928437.git.baolin.wang@linaro.org>
 <20180518165408.GA31804@rob-hp-laptop>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 25 May 2018 16:54:37 +0800
Message-ID: <CAMz4kuKsJkMNm0MJQ5_7STU8h-Mr0wGHtHFL8HPU3Mmhkqh1yQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx
 vibrator documentation
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2018 at 00:54, Rob Herring <robh@kernel.org> wrote:
> On Thu, May 10, 2018 at 01:08:33PM +0800, Baolin Wang wrote:
>> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> vibrator device.
>>
>> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v3:
>>  - Change compatible string to explicit Soc name.
>>  - Add parent MFD node.
>>
>> Changes since v2:
>>  - No updates.
>>
>> Changes since v1:
>>   - No updates.
>> ---
>>  .../bindings/input/sprd,sc27xx-vibra.txt           |   23 ++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Hi Dmitry,

Could you apply this patch set if there are no other issues? Thanks.

-- 
Baolin.wang
Best Regards

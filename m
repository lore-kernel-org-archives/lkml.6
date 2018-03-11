Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932511AbeCKW36 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:29:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52420 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbeCKW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:29:56 -0400
X-Google-Smtp-Source: AG47ELtCj5gb7o4iRd9E0ZJx55cnU0w7rAR9SDrIPA4KFyOpX1gIrp3RFL9ttbFV8SVZtp2thii+Jg==
Subject: Re: [PATCH v1 3/5] dt-bindings: clock: add clocks for MT2712
To: Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
 <20180222054851.26096-5-weiyi.lu@mediatek.com>
 <20180301224555.44pvl67l5oqibbkg@rob-hp-laptop>
 <1519957404.14513.5.camel@mtksdaap41>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d1f7b0e7-fa9b-cc87-80df-3479db8b9281@gmail.com>
Date: Sun, 11 Mar 2018 23:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519957404.14513.5.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2018 03:23 AM, Weiyi Lu wrote:
> On Thu, 2018-03-01 at 16:45 -0600, Rob Herring wrote:
>> On Thu, Feb 22, 2018 at 01:48:49PM +0800, Weiyi Lu wrote:
>>> add new clocks according to ECO design change
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> ---
>>>  include/dt-bindings/clock/mt2712-clk.h | 294 +++++++++++++++++----------------
>>>  1 file changed, 151 insertions(+), 143 deletions(-)
>>
>> You can't just renumber your clocks. They are an ABI. Plus, for an ECO 
>> there can't have been that much change.
>>
> Hi Rob,
> Got it! Is it correct if I append those new added clocks at the bottom
> of each own subsystem? If the answer is yes, I'll resend a new version.

Yes, that will work. Please do that and resubmit.

Thanks,
Matthias

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDSKKX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:10:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48875 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDSKKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:10:13 -0400
Subject: Re: [PATCH v8 1/2] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, <architt@codeaurora.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <geert@linux-m68k.org>, <niklas.soderlund@ragnatech.se>,
        <sergei.shtylyov@cogentembedded.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
References: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357590-3841-2-git-send-email-jacopo+renesas@jmondi.org>
 <29caaf6f-1783-9b01-5304-8748398d41c6@mentor.com>
 <55ac6669-3dc6-8c6f-d9a0-f6c44f7f0953@mentor.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <eee8f364-3f3f-564a-515c-82f848b23ca8@mentor.com>
Date: Thu, 19 Apr 2018 13:10:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <55ac6669-3dc6-8c6f-d9a0-f6c44f7f0953@mentor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 04/19/2018 12:48 PM, Vladimir Zapolskiy wrote:
> Hi Jacopo,
> 
> On 04/19/2018 12:44 PM, Vladimir Zapolskiy wrote:
>> Hi Jacopo, Laurent,
>>
>> On 04/10/2018 01:53 PM, Jacopo Mondi wrote:
>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>
>>> ---

[snip]

>>> +Optional properties:
>>> +- powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low
>>
> 
> sorry for a follow-up, I've just noticed it, could you please double check
> spelling PDWN vs PWDN? Thank you in advance.
> 

please ignore it, I did it myself and the datasheet describes pin as /PDWN,
I won't exclude a typo in the datasheet though...

--
With best wishes,
Vladimir

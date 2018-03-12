Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeCLLDu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:03:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52489 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:03:49 -0400
X-Google-Smtp-Source: AG47ELt3G37haOlCOBzoQb30dhge39U07ktjc2F6bpc4WWdITMNhzieU2XHd2avMiXCk5Cj3TaqyPA==
Subject: Re: [PATCH v1 04/19] dt-bindings: arm: mediatek: add support for more
 mt7623 reference boards
To: Rob Herring <robh@kernel.org>, sean.wang@mediatek.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <e77690ea7f7332e9e1ee64204a4e72c759c41aa9.1519378871.git.sean.wang@mediatek.com>
 <20180302160022.ub6vinw6br3l2dyb@rob-hp-laptop>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <adeee56f-97c6-1999-4f1c-d420ce24ee13@gmail.com>
Date: Mon, 12 Mar 2018 12:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302160022.ub6vinw6br3l2dyb@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2018 05:00 PM, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 06:16:24PM +0800, sean.wang@mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Update binding document for more mt7623[A,N] reference boards being
>> supported.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/arm/mediatek.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Pushed to v4.16-next/dts32

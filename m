Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeCFCdF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:33:05 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:39204 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCFCdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:33:04 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: robh@kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <66e58c0c608f2c1e91afbb84c53d1462>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A9DFDCD.7040107@rock-chips.com>
Date: Tue, 06 Mar 2018 10:32:45 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: linux-kernel@vger.kernel.org, jcliang@chromium.org,
        robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v6 09/14] dt-bindings: iommu/rockchip: Add clock
 property
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com> <20180301101837.27969-10-jeffy.chen@rock-chips.com> <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
In-Reply-To: <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your reply.

On 03/06/2018 10:27 AM, Rob Herring wrote:
> On Thu, Mar 01, 2018 at 06:18:32PM +0800, Jeffy Chen wrote:
>> Add clock property, since we are going to control clocks in rockchip
>> iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v6: None
>
> Really? There was a different number of clocks before.
hmm, right, forgot to modify the change log, sorry...
>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
>
>

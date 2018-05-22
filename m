Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeEVUuR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:50:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55199 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeEVUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:50:15 -0400
X-Google-Smtp-Source: AB8JxZqt9Yyh8zcu2w8DcZ81A+SgWnu3W5hnuCxRGEJ1wO63d9+gAolb02Qhvj3MPEcAWbH72GljHA==
Subject: Re: [PATCH net-next v2 1/7] net: dsa: qca8k: Add QCA8334 binding
 documentation
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, andrew@lunn.ch,
        mark.rutland@arm.com, davem@davemloft.net, michal.vokac@ysoft.com
References: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
 <1526987792-56861-2-git-send-email-michal.vokac@ysoft.com>
 <20180522194039.GA15413@rob-hp-laptop>
From: Michal <vokac.m@gmail.com>
Message-ID: <67783b3a-e7df-2b22-eba5-a86e5de22c32@gmail.com>
Date: Tue, 22 May 2018 22:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522194039.GA15413@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.5.2018 21:40, Rob Herring wrote:
> On Tue, May 22, 2018 at 01:16:26PM +0200, Michal Vokáč wrote:
>> Add support for the four-port variant of the Qualcomm QCA833x switch.
>>
>> The CPU port default link settings can be reconfigured using
>> a fixed-link sub-node.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> Changes in v2:
>>   - Add commit message and document fixed-link binding.
>>
>>   .../devicetree/bindings/net/dsa/qca8k.txt          | 23 +++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.txt b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
>> index 9c67ee4..15b9057 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.txt
>> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
>> @@ -2,7 +2,10 @@
>>   
>>   Required properties:
>>   
>> -- compatible: should be "qca,qca8337"
>> +- compatible: should be one of:
>> +    "qca,qca8334"
>> +    "qca,qca8337"
>> +
>>   - #size-cells: must be 0
>>   - #address-cells: must be 1
>>   
>> @@ -14,6 +17,20 @@ port and PHY id, each subnode describing a port needs to have a valid phandle
>>   referencing the internal PHY connected to it. The CPU port of this switch is
>>   always port 0.
>>   
>> +A CPU port node has the following optional property:
> 
> s/property/node/
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Good catch, I will correct this.
Thanks for the review Rob.

Michal

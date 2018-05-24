Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966064AbeEXJfH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:35:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45108 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965978AbeEXJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:35:00 -0400
X-Google-Smtp-Source: AB8JxZrNmJ4sC0WGarSGtzqFSWgjXoijBBbmjsxiAjuHxcsWWz/ZT0SbiJuGtuXcNvvA6Aa5VttKZw==
Subject: Re: [PATCH net-next v3 0/7] Add support for QCA8334 switch
To: Florian Fainelli <f.fainelli@gmail.com>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net,
        michal.vokac@ysoft.com
References: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
 <29ea7cdd-5690-e39a-a2ef-4f48fbcb7659@gmail.com>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <vokac.m@gmail.com>
Message-ID: <f8bf325c-77a5-d44b-34c3-93ea4b11fd84@gmail.com>
Date: Thu, 24 May 2018 11:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <29ea7cdd-5690-e39a-a2ef-4f48fbcb7659@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.5.2018 17:39, Florian Fainelli wrote:
> 
> 
> On 05/22/2018 11:20 PM, Michal Vokáč wrote:
>> This series basically adds support for a QCA8334 ethernet switch to the
>> qca8k driver. It is a four-port variant of the already supported seven
>> port QCA8337. Register map is the same for the whole familly and all chips
>> have the same device ID.
>>
>> Major part of this series enhances the CPU port setting. Currently the CPU
>> port is not set to any sensible defaults compatible with the xGMII
>> interface. This series forces the CPU port to its maximum bandwidth and
>> also allows to adjust the new defaults using fixed-link device tree
>> sub-node.
>>
>> Alongside these changes I fixed two checkpatch warnings regarding SPDX and
>> redundant parentheses.
> 
> Looks great, thanks Michal! Do you have any features or things you are
> working on that would be added later to the driver?

Thank you too Florian. And also big thank to you Andrew. You helped me
a lot to debug the RGMII issue. I have been stuck at that for more than
a month and would not resolve it without your help.

As I have done this in a process of upgrading our BSP to a more recent
kernel, and hopefully mainline, I now need to move on to other parts of
the board. So unfortunately no, I do not have any other enhancements
planned to this driver for now. But as we are probably one of the few
with access to the NDA covered Qualcomm documentation I see a great
opportunity to work on that later. I am afraid "later" means something
like next year in this case as I am basically the only kernel developer
in our company and not yet very experienced.

Thank you all for your time,
Michal

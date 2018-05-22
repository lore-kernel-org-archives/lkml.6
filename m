Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEVFtn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 01:49:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34508 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeEVFtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 01:49:40 -0400
X-Google-Smtp-Source: AB8JxZqsoWfy2kOEVTGp3PEf2DrQBggfCKWspdB5RixiuWoBfl49hR6DRPcDSs7ODeWTW3CkRki+Mw==
Subject: Re: [PATCH net-next 6/7] net: dsa: qca8k: Replace GPL boilerplate by
 SPDX
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: michal.vokac@ysoft.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
 <1526909293-56377-7-git-send-email-michal.vokac@ysoft.com>
 <200f2431-63c1-bafe-8802-3a117fbf8433@gmail.com>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <vokac.m@gmail.com>
Message-ID: <f627c843-30b3-f173-56b5-2c6432479ed6@gmail.com>
Date: Tue, 22 May 2018 07:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <200f2431-63c1-bafe-8802-3a117fbf8433@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.5.2018 17:20, Florian Fainelli wrote:
> 
> On 05/21/2018 06:28 AM, Michal Vokáč wrote:
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I don't know if we need all people who contributed to that driver to
> agree on that, this is not a license change, so it should be okay I presume?

I did that with the same idea on my mind, that this is not a license change.
Prior to the change I also went through the log and reviewed few commits that
did exactly the same thing and did not receive Ack or something from the
original authors nor further contributors.

Just one example:

4ac0d3f ("eeprom: at24: use SPDX identifier instead of GPL boiler-plate")

Thanks,
Michal

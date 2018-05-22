Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVF2r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 01:28:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55719 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVF2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 01:28:43 -0400
X-Google-Smtp-Source: AB8JxZo1GT6OYBc4oPgcrSyIu5HrS96FCGi4wPohABYWSoHcxj04BS9lAv9owEUQsxp46qWsvHMT7A==
Subject: Re: [PATCH net-next 3/7] net: dsa: qca8k: Enable RXMAC when bringing
 up a port
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: michal.vokac@ysoft.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
 <1526909293-56377-4-git-send-email-michal.vokac@ysoft.com>
 <0e72750c-5567-d12c-8d9c-5a25520ab104@gmail.com>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <vokac.m@gmail.com>
Message-ID: <42a8bf22-6def-bfdd-02fb-ab1112ee3c50@gmail.com>
Date: Tue, 22 May 2018 07:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0e72750c-5567-d12c-8d9c-5a25520ab104@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.5.2018 17:17, Florian Fainelli wrote:
> 
> On 05/21/2018 06:28 AM, Michal Vokáč wrote:
>> When a port is brought up/down do not enable/disable only the TXMAC
>> but the RXMAC as well. This is essential for the CPU port to work.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Should this have:
> 
> Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")?

Yes, I think it is a good idea to can add this. Will do it in v2.

Thanks,
Michal

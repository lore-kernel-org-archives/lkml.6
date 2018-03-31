Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeCaRUo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 13:20:44 -0400
Received: from smtp01.mail.online.nl ([194.134.25.71]:64606 "EHLO
        smtp01.mail.online.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeCaRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 13:20:42 -0400
Subject: Re: [PATCH v4 0/2] of_net: Implement of_get_nvmem_mac_address helper
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        robh+dt@kernel.org, frowand.list@gmail.com
References: <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
 <1522301389-11034-1-git-send-email-mike.looijmans@topic.nl>
 <20180330.104054.147506012234775496.davem@davemloft.net>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <56a0d45c-bf2a-0d9a-fa2e-9f6531caa61c@topic.nl>
Date: Sat, 31 Mar 2018 19:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180330.104054.147506012234775496.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-18 16:40, David Miller wrote:
> From: Mike Looijmans <mike.looijmans@topic.nl>
> Date: Thu, 29 Mar 2018 07:29:47 +0200
> 
>> Posted this as a small set now, with an (optional) second patch that shows
>> how the changes work and what I've used to test the code on a Topic Miami board.
>> I've taken the liberty to add appropriate "Acked" and "Review" tags.
>>
>> v4: Replaced "6" with ETH_ALEN
>>
>> v3: Add patch that implements mac in nvmem for the Cadence MACB controller
>>      Remove the integrated of_get_mac_address call
>>
>> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>>      Use void* instead of char*
>>      Add devicetree binding doc
> 
> Series applied to net-next, thank you.
> 

Got a kbuild bot error message in the e-mail, with errors like: 
"undefined reference to `of_nvmem_cell_get'"

Should I add an "#if CONFIG_NVMEM" guard around the new code and make a 
v5 patch?

-- 
Mike Looijmans

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeD0Xia (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:38:30 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39326 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeD0Xi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:38:28 -0400
X-Google-Smtp-Source: AB8JxZqLwiHkbMFp99Mpp1PX15lm/HCc5QeQbQq741R+rGkriHNZq46ahHHWfxCCLq5Rg0chVMAf5Q==
Subject: Re: [PATCH 2/4] fpga: manager: change api, don't use drvdata
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <20180427012605.28981-1-mdf@kernel.org>
 <20180427012605.28981-3-mdf@kernel.org>
 <152cb232-ea4d-292b-8b60-8bdc1732dc23@gmail.com>
 <CANk1AXTZhCA78eX9j5dg1VeNyg8G4+hsiSgG_CYpZObjJw+wfw@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8938518c-6e12-51f5-4747-8caab916fc3a@gmail.com>
Date: Fri, 27 Apr 2018 16:38:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANk1AXTZhCA78eX9j5dg1VeNyg8G4+hsiSgG_CYpZObjJw+wfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 04:30 PM, Alan Tull wrote:
> On Fri, Apr 27, 2018 at 1:26 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 04/26/2018 06:26 PM, Moritz Fischer wrote:
>>> From: Alan Tull <atull@kernel.org>
>>>
>>> Change fpga_mgr_register to not set or use drvdata.  This supports
>>> the case where a PCIe device has more than one manager.
>>>
>>> Add fpga_mgr_create/free functions.  Change fpga_mgr_register and
>>> fpga_mgr_unregister functions to take the mgr struct as their only
>>> parameter.
>>>
>>>   struct fpga_manager *fpga_mgr_create(struct device *dev,
>>>                 const char *name,
>>>                 const struct fpga_manager_ops *mops,
>>>                 void *priv);
>>>   void fpga_mgr_free(struct fpga_manager *mgr);
>>>   int fpga_mgr_register(struct fpga_manager *mgr);
>>>   void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>
>>> Update the drivers that call fpga_mgr_register with the new API.
>>
>> Apologies for chiming in so late, this commit does not make it clear
>> that fpga_mgr_unregister() now also free the 'mgr' argument by calling
>> fpga_mgr_free(), this is kind of detail, but an API should make that
>> clear IMHO.
> 
> If people follow the usage information, in
> Documentation/fpga/fpga-mgr.txt, they'll do the right thing.  But I
> can add a patch that clarifies the description of fpga_mgr_unregister
> in fpga-mgr.c that it "unregisters and frees" the manager.

Just mentioning that because not all APIs do this, take the network
devices: there is an unregister_netdev() and a free_netdev(). Either way
is fine with me as long as it is documented as such, I had to look at
the API implementation to figure out that, no, all the drivers were not
leaking their fpga_manager instance in their .remove() function :)
-- 
Florian

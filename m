Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeBLSFp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:05:45 -0500
Received: from [195.159.176.226] ([195.159.176.226]:43794 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeBLSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:05:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/4] usb: gadget: fotg210-udc: Fixes and cleanup
Date: Mon, 12 Feb 2018 19:05:16 +0100
Message-ID: <p5sksu$4pc$1@blaine.gmane.org>
References: <cover.1515791144.git.christophe.jaillet@wanadoo.fr>
 <871shqbnln.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
In-Reply-To: <871shqbnln.fsf@linux.intel.com>
Content-Language: en-US
Cc: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/02/2018 à 09:48, Felipe Balbi a écrit :
> 
> Hi,
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
>> This serie aims to fix 2 issues. (path 2 & 4)
>>
>> The 2nd patch fixes a memory leak. It uses devm_ function a simplify the
>> handling of the memory.
>>
>> The 4th patch fixes a potential invalid pointer dereference.
>>
>> The 2 other ones, are just clean-ups to remove useless code and add other
>> uses of devm_ function to simplify code.
>>
>> I've left the request_irq/free_irq because I'm unsure of potential side
>> effects if some other resources are freed while an IRQ can still be
>> triggered. So I've preferred to leave it as-is.
>>
>> Christophe JAILLET (4):
>>    usb: gadget: fotg210-udc: Remove a useless
>>    usb: gadget: fotg210-udc: Fix a memory leak
>>    usb: gadget: fotg210-udc: Simplify code
>>    usb: gadget: fotg210-udc: Fix a potential invalid pointer dereference
> 
> you should NEVER make fixes depend on cleanups. It should be the other
> way around :-) First fixes, then cleanups. The reason is that fixes can
> get accepted during -rc cycle, but cleanups must wait until the next
> merge window.
> 
> Please fix up your patches, otherwise I'll have to apply the entire
> series for v4.17
> 

I agree with you. I will be more careful in the future.
However, I will not re-send an updated version. Development on this 
driver does not seem to be very active. So the proposed fix (2/4) and 
cleanups can wait a few more months.
Feel free to update yourself 2/4 (and eventually drop 1/4 completely to 
avoid the time to re-work it) if you think that it worth it.

Best regards,
CJ


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

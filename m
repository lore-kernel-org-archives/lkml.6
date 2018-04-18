Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3768412-1524033129-2-10536091509407450837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524033080; b=pFE1EbOrh+OUV6xJi21K4kgIVPGWBPU2/3E1KN/MMDr+4UKZ+e
    ZtuLQv4rQfA2pKcUg488DHeuYcUuwGP0SmsHmHUQ3T9HxRyAqElxDGeUQE5fVvII
    Vp9Xn8Y+9/o6MthcNjLHkF9O4DZykT3/1DSVl3yU1zU/K4aduk4CFFguvT+p9cKG
    Hn8MAtCPn5cmBb+6W41ui9ryiul9Wndl6C5p8gWeFMC5dVca/L7axNb8SZZjJtzx
    rr2SnHB/KH3bsLTbyPOWnJyECqlkFnSpp4BOOSWIDngf3fKs97QwfZVtTkxUF1ef
    W4DP4HWaHH/B8W/9eSgApdDDhg1oJ0I5W2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524033080;
    bh=bUHch9x85XtTfKPsZwDD7i1wMGjLsSfIaeXbr/g10zw=; b=frhRXF0qSOmJ
    qvDU6M2ZvhV1BSS2x1PTXG9NKkx79IO2NCOYDapV5Fdq4PtK4Y8N5lm9WFnVofOK
    3xW4kbn1dZ/t9JH3tfOwTK2fP2FsgXGxrJIbnC7ZOtHZv72h3XcEoh8Y8XJB45gr
    Gh7eFHDIrc/1EDCfwiiUttABs7UUR5Otev4zBHye2eJL9MY65GMqWNCzHSyE8Qy+
    3ptGe6NDTDzmCP9kazeQMXstWnXyJzkfmPyG1lWCA84fmqD/riALBACQ3neCZW8F
    vKrnMAHX7qx5VnEN53sDOWXWUAmO1dJvi9Nn0HWtzbmf46uVEESS9ts0SyWDNh6d
    oNVtNOvt1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=F59eQ1ek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=F59eQ1ek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFCmJ8sGehmXhqcq4eMH6zxrpbwtwF3mlp/NFKPijMPL/PV8m+SoJchsxw/CVtZin38cdqVPbONdLiNEw/O6zERkbTvsRx/t6T4yH4lngRNiDlcdBWN
    4W7Fzhh5aStQGSxi/NnV/Zp/7LsxuIYchgvSjSZGkTXJMVSWBQXgdrX9vgPp1pzH2gBm0F00yGXUlwlw9zn15RxGhHGl+8PSS+k9Kn+sbPzW1zxBELHeFnVZ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=hXhQfpdcRjNPdIuxo5MA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDRGbG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 02:31:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49116 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeDRGbF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 02:31:05 -0400
Subject: Re: [PATCH] usb: always build usb/common/ targets; fixes
 extcon-axp288 build error
To: Hans de Goede <hdegoede@redhat.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
 <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91b04197-fc92-84f9-8c5a-0399a922ccd0@infradead.org>
Date: Tue, 17 Apr 2018 23:30:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/18 02:01, Hans de Goede wrote:
> Hi,
> 
> On 17-04-18 07:14, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
>> Makefile does not currently build drivers/usb/common/ (where
>> USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
>> the USB Makefile to always descend into drivers/usb/common/
>> to build its configured targets.
>>
>> Fixes these build errors:
>>
>> ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
>> ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!
>>
>> An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
>> driver Kconfig entry, but this would build more code in
>> drivers/usb/common/ than is necessary.
> 
> Ah, that variant of fixing this got posted yesterday and I acked that,
> but I agree that this version is better.

That was my first patch version, but I didn't like it.

However, I missed that patch. If I had seen it, I wouldn't have posted
this patch.


> Greg, what is your take on this fix?
> 
> Chanwoo Choi, please wait with merging the fix from yesterday until
> we've a decision which fix to use.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: linux-usb@vger.kernel.org
>> ---
>>   drivers/usb/Makefile |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-417-rc1.orig/drivers/usb/Makefile
>> +++ lnx-417-rc1/drivers/usb/Makefile
>> @@ -60,7 +60,7 @@ obj-$(CONFIG_USB_CHIPIDEA)    += chipidea/
>>   obj-$(CONFIG_USB_RENESAS_USBHS)    += renesas_usbhs/
>>   obj-$(CONFIG_USB_GADGET)    += gadget/
>>   -obj-$(CONFIG_USB_COMMON)    += common/
>> +obj-y                += common/
>>     obj-$(CONFIG_USBIP_CORE)    += usbip/
>>  
>>
> 


-- 
~Randy

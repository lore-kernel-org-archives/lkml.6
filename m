Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656C7205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547735487;
	bh=QJEjP6nJ36WutPlVKF40u0LfwBxRFrXJh7PoN5SmP9I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bi9bFXqFVGGC/OH2jC6ndh/KSGcpjuGNK+qVVAZM4zv6KudvmwedVvn3f0wReFs8E
	 7pFvGSI7e/gg7HBZfHBXM6win+zfKFa/EYjA0kGVKCoTH8dKwGVv0AHF7pga+NL5Ea
	 T7i03iNFdrdJkhWKXVEg7CVOxrDwyv1i8kOHIFTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfAQObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfAQObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:31:25 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3087C205C9;
        Thu, 17 Jan 2019 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547735484;
        bh=QJEjP6nJ36WutPlVKF40u0LfwBxRFrXJh7PoN5SmP9I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dRlr94K42St4QFUaIO4bjUjTXzB/gMLiuRFDq6TQbUPs6knK/sETlcOm3ErxihxNB
         +1IKTfyD+CJ/viriiX95P2pxalU1gDJY+oCfmrBI9lW3cjqqJfQglS7TKz8U5EfpnX
         FWPg3SrHBp07lCaR4VdaoKq0P88agWCkXBxkDBJc=
Subject: Re: [PATCH] MAINTAINERS: email address update in MAINTAINERS entries
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190116232820.26180-1-shuah@kernel.org>
 <20190117083224.GA17261@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <7c8ea821-68c8-2c8d-56c3-58612a46d3ce@kernel.org>
Date:   Thu, 17 Jan 2019 07:30:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117083224.GA17261@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 1:32 AM, Greg KH wrote:
> On Wed, Jan 16, 2019 at 04:28:20PM -0700, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Update email address in MAINTAINERS entries.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   MAINTAINERS | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4d04cebb4a71..6ca780f24808 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3979,6 +3979,7 @@ F:	drivers/cpufreq/arm_big_little.c
>>   CPU POWER MONITORING SUBSYSTEM
>>   M:	Thomas Renninger <trenn@suse.com>
>>   M:	Shuah Khan <shuah@kernel.org>
>> +M:	Shuah Khan <skhan@linuxfoundation.org>
>>   L:	linux-pm@vger.kernel.org
>>   S:	Maintained
>>   F:	tools/power/cpupower/
>> @@ -8259,6 +8260,7 @@ F:	include/uapi/linux/sunrpc/
>>   
>>   KERNEL SELFTEST FRAMEWORK
>>   M:	Shuah Khan <shuah@kernel.org>
>> +M:	Shuah Khan <skhan@linuxfoundation.org>
>>   L:	linux-kselftest@vger.kernel.org
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>>   Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
>> @@ -15842,6 +15844,7 @@ F:	drivers/usb/common/usb-otg-fsm.c
>>   USB OVER IP DRIVER
>>   M:	Valentina Manea <valentina.manea.m@gmail.com>
>>   M:	Shuah Khan <shuah@kernel.org>
>> +M:	Shuah Khan <skhan@linuxfoundation.org>
>>   L:	linux-usb@vger.kernel.org
>>   S:	Maintained
>>   F:	Documentation/usb/usbip_protocol.txt
>> -- 
>> 2.17.1
>>
> 
> I can take this through my USB tree as 1/3 of these entries come from
> there, unless you want to take it through your kselftest tree?  If so,
> feel free to add my:
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> to it.
> 
> thanks,
> 
> greg k-h
> 

Greg,

Please go ahead and take this through USB tree.

thanks,
-- Shuah

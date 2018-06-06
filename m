Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M3TpON73"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B68D6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeFFROX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:14:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44783 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeFFROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:14:21 -0400
X-Google-Smtp-Source: ADUXVKImxHEHULIHYRWk7oueZucSgW9eWXabfGC3+MfFvNYsfVx6WCpb4UAHA3a2wsYfG//HWtbYJA==
Subject: Re: [PATCH] ARM: dts: cygnus: Add HWRNG node
To: Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180606093441.16483-1-peron.clem@gmail.com>
 <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
 <c7990001-00e6-d828-bafd-3d472fcfee20@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <676106a4-d763-725c-2342-f8d215fbd169@broadcom.com>
Date: Wed, 6 Jun 2018 10:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c7990001-00e6-d828-bafd-3d472fcfee20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-06-06 09:47 AM, Florian Fainelli wrote:
> On 06/06/2018 09:03 AM, Scott Branden wrote:
>> Hi Clement,
>>
>>
>> On 18-06-06 02:34 AM, Clément Péron wrote:
>>> From: Clément Peron <clement.peron@devialet.com>
>>>
>>> There is a HWRNG in Broadcom Cygnus SoC, so enable it.
>>>
>>> Signed-off-by: Clément Peron <clement.peron@devialet.com>
>> Thanks for upstreaming some missing Cygnus components.
>>
>> But, the problem is the tarball release from Broadcom you are extracting
>> these changes from does not contain git history; so, you are missing the
>> original authors and signed-off's.
>> I checked our internal git repository and for this commit the author is:
>> Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
>>
>> Please adjust author and signed-off appropriately.  If there are other
>> changes you are extracting from the source tarballs you have please
>> contact me so we can construct patch appropriately.
> If you want the original author's Signed-off-by to be preserved, why
> don't you extract it from your internal git tree and submit the patch on
> Mohamed's behalf?
Sure, I can submit the original patch to keep things simple and avoid 
finding a lawyer right now.
>
> AFAICT what Clement is doing here is permissible given the Linux
> developer certificate of origin though I am not a lawyer of course.
But, It would be great to get some guidance and clarification on this 
for sure.
I'm reading:
https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html

The change was created entirely by Broadcom, so seems difficult for 
somebody else to upstream change without appropriate authorship and 
signed off from copyright holder.  Point a) and b) are not met in 
Developer's Certificate of Origin while point c) is being attempted 
(without a or b being certified).

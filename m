Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeFDVaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:30:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41865 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:30:53 -0400
X-Google-Smtp-Source: ADUXVKLwHbybA2MZuKdjQppLrqhpFaQh80nKGrSVINq1XQfu1vRljrlnwZiv5ObQKqkKyrPMqDo27g==
Subject: Re: [PATCH] arm64: dts: stingray: Add otp device node
To: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
 <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <f6f3e76e-eac9-797d-fea5-eac64327ec7f@broadcom.com>
Date: Mon, 4 Jun 2018 14:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,


On 18-06-04 02:24 PM, Florian Fainelli wrote:
> On 05/23/2018 01:17 PM, Scott Branden wrote:
>> Add otp device node for Stingray SOC.
>>
>> Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Applied to devicetree-arm64/next with s/otp/OTP/ and removing the Fixes
> line since that is not a bug fix AFAICT.
It fixes the issue that OTP is not active as it is missing the device node?
>
> Thank you

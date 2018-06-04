Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFDWl6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:41:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38266 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFDWl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:41:56 -0400
X-Google-Smtp-Source: ADUXVKL1c7z1AzDZN134KvNScg3xhpxaBWrany6VTIXG+HrbuXzHFhvDfOqvyP9U946ARYM1Adc6lQ==
Subject: Re: [PATCH] arm64: dts: stingray: Add otp device node
To: Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
 <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
 <f6f3e76e-eac9-797d-fea5-eac64327ec7f@broadcom.com>
 <efaf0373-2959-b238-e5f3-ae7e16534384@gmail.com>
 <e641f180-0b7e-678c-07c4-834ff0676b34@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <2d6cc541-7987-5b4c-a847-6fcbb27e12d2@gmail.com>
Date: Mon, 4 Jun 2018 15:41:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e641f180-0b7e-678c-07c4-834ff0676b34@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 03:33 PM, Scott Branden wrote:
> 
> 
> On 18-06-04 02:33 PM, Florian Fainelli wrote:
>> On 06/04/2018 02:30 PM, Scott Branden wrote:
>>> Hi Florian,
>>>
>>>
>>> On 18-06-04 02:24 PM, Florian Fainelli wrote:
>>>> On 05/23/2018 01:17 PM, Scott Branden wrote:
>>>>> Add otp device node for Stingray SOC.
>>>>>
>>>>> Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>> Applied to devicetree-arm64/next with s/otp/OTP/ and removing the Fixes
>>>> line since that is not a bug fix AFAICT.
>>> It fixes the issue that OTP is not active as it is missing the device
>>> node?
>> By that token, any peripheral that is being added at some point in the
>> lifetime of this DTS would qualify as a bugfix when it is in fact
>> feature/peripheral enabling.
>>
>> I could not see the relationship between the commit being provided in
>> the "Fixes:" tag and OTP, am I missing something?
> The relationship is the fixes tag points was selected to the last tag
> when the commit applies directly against (and is far enough back that it
> covers any possible LTS kernels that would have needed it).

I understand how ones gets to select an appropriate Fixes: tag, what I
don't understand is the relationship between the two changes, like why
would a GPIO Device Tree node influence the OTP peripheral here when
there is no pinmux or GPIO phandle of some sort linking the two. Also,
since you guys were very trigger happy with Fixes: tag lately (referring
to the internal review of Srinath's changes) this one looked a lot like
that.

The only thing I am questioning here is treating that particular
changeset as a bugfix proper. Yes it is technically a fix in that,
without this changeset the OTP node is not there and that is
functionality you want, but it is not preventing the platform from not
booting for instance, or having an incorrect behavior for an established
behavior before, right?

> In this case
> I don't care too much about whether this is fixed in LTS or not.  If
> needed I'll send a request for the commit be ported to stable.

If this is a true fix, I don't mind taking it as-is and keeping the
Fixes: tag, keep in mind the following:

I always treat bug fixes with a higher priority than features, and I
will do my best to queue up fixes (separate branches, all ending in
/fixes) and submit those at any time in the release cycle so they can
land in Linus' tree and in the -stable trees as fast as possible.

Don't bypass the maintainer if you can convince me this is a proper fix,
then I will just move that patch into the appropriate branch, and you
will get those stable backports automatically.

Thanks for reading me.
-- 
Florian

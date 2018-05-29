Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbeE2OUI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:20:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47564 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934329AbeE2OUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:20:03 -0400
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftest: intel_pstate: debug support message from
 aperf.c and return value fix.
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
References: <20180518140550.2280-1-ahiliation@yahoo.co.in>
 <4f51f365-705a-211f-cccb-c634ea750dc6@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=shuah@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b21341a7-1fe4-9874-d5ed-29fb60bf9285@kernel.org>
Date: Tue, 29 May 2018 08:19:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4f51f365-705a-211f-cccb-c634ea750dc6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrin,

On 05/18/2018 01:19 PM, Shuah Khan wrote:
> On 05/18/2018 08:05 AM, Jeffrin Jose T wrote:
>> Additional message along with an error message which is more
>> verbose for debug support from aperf.c and updated with the
>> new return value "KSFT_SKIP".
>>
>> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

Can you please resend this patch. I don't see this posted to the
linux-kselftest mailing list. Please tag it RESEND

thanks,
-- Shuah

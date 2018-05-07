Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525710876; cv=none;
        d=google.com; s=arc-20160816;
        b=HapvQWT9KhuEptBLo7cBYtUknrVbTddCwIKjzx9xs0u1BEAx8ERVoDcxQiUEnOW15Z
         60g9PSTuRC7oiNnr5WsH7CJtCitm06+4PhlB5DJwyg//VQu2Db2acHyqlTdb2drZ+0j5
         txmZNn7R61BRjwiSiQen7iFB7djfIpSK8c2vr2zEznNuF5HSrDOoJvdgAjxj61NJ+c2T
         gI9Yx3M1xpk/dz/3Sv2+9BsOBWu0mHpnZp+3yzzzGSxhRX3+UWi5DIs+/T3P0gXG5tlz
         1Rdf2XWmB1gB02LHX47cLfp3BNnEyxfzAF9Wb/8WsW8rjeDltKJjQNdJIdm37enz9NcB
         1PVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fszeVPylOXNu6DlauVsaIcoQW097apb5J4OLqO2l9lc=;
        b=TjuMVNxHE0M+I1eb4Ua5cuZzlRQ+ywDsLHSOI5E+OgsTGEsVIZRvFF83WWA02k+mjI
         tXCvVoJy3JWodb3XVTglQLG1oeIZbsnUIpAf8d9u1Tkcn1w6V3+6+3gayb8VbnsCG4u4
         lBzKQYJIqZ4PEnIRvOnAsjmXOgkIvXrvprPvEowF+0b0TBDDhmRcjR0nioqFYy4Tz4dZ
         3JWqZl8coKKLpgKlm5Zay5o6ymeYT1R0qRsh3I0X/7JMCnqszXipi4zS/aENGMLlM+Dt
         RBgiBCTv8sFt8Ln1vnb0Z2DF+n6f/P/IVY7DTwN5pmp96v2Gs8LadHRLG5CUDNbiC/NU
         QLXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZq+xgR6cyzS0E6QPZ9XkYGibBO7v4Wmy2VSTv4uR2LiM7NwcVHFfUVD1TflOD695Vwb7wrrUA==
Subject: Re: [PATCH 1/2] staging: android: ion: Fix license identifier comment
 format
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joe Perches <joe@perches.com>, =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?=
 <arve@android.com>, Martijn Coenen <maco@android.com>,
 Todd Kjos <tkjos@android.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20180507011854.12627-1-natechancellor@gmail.com>
 <d157b475-7893-3ab6-87a8-b6ce5aa13b4f@redhat.com>
 <20180507144029.GA2084@localhost>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <88b8b963-eb6d-0912-b17a-dc33cf5449c0@redhat.com>
Date: Mon, 7 May 2018 09:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507144029.GA2084@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599766192344389306?=
X-GMAIL-MSGID: =?utf-8?q?1599823807793474302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 07:40 AM, Nathan Chancellor wrote:
> On Mon, May 07, 2018 at 06:37:52AM -0700, Laura Abbott wrote:
>> On 05/06/2018 06:18 PM, Nathan Chancellor wrote:
>>> checkpatch.pl complains these are invalid because the rules in
>>> Documentation/process/license-rules.rst state that C headers should
>>> have "/* */" style comments.
>>>
>>
>> The SPDX markings are special, but I don't see anything from a
>> quick read of the SPDX specification that says they have to use //.
>> I think this is going to generate a lot of possible noise so it
>> might be worth adjusting checkpatch.
>>
>> Thanks,
>> Laura
> 
> Under section 2 of "License identifier syntax" in the license rules
> file, it shows the preferred style for each type of file. Apparently
> there was some build breakage with // in header files so I assume they
> want /* */ for uniformity sake.
> 
> Thanks!
> Nathan
> 

Ah thanks for pointing me to that. I parsed your commit text completely
wrong. My biggest concern is being consistent and not breaking anything
so assuming this patch aligns with that:

Acked-by: Laura Abbott <labbott@redhat.com>

>>
>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>>> ---
>>>    drivers/staging/android/ion/ion.h  | 2 +-
>>>    drivers/staging/android/uapi/ion.h | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
>>> index ea0897812780..16cbd38a7160 100644
>>> --- a/drivers/staging/android/ion/ion.h
>>> +++ b/drivers/staging/android/ion/ion.h
>>> @@ -1,4 +1,4 @@
>>> -// SPDX-License-Identifier: GPL-2.0
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>    /*
>>>     * drivers/staging/android/ion/ion.h
>>>     *
>>> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
>>> index 825d3e95ccd3..5d7009884c13 100644
>>> --- a/drivers/staging/android/uapi/ion.h
>>> +++ b/drivers/staging/android/uapi/ion.h
>>> @@ -1,4 +1,4 @@
>>> -// SPDX-License-Identifier: GPL-2.0
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>    /*
>>>     * drivers/staging/android/uapi/ion.h
>>>     *
>>>
>>

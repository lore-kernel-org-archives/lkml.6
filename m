Return-Path: <igor.stoppa@huawei.com>
X-Google-Smtp-Source: AH8x224laZivxhPTyRYBGRje0SfxBp+hUXAfrqLICaCx1r4+VRdlG5gjy5eX5ubyetz3S5oR5SqE
ARC-Seal: i=1; a=rsa-sha256; t=1517665327; cv=none;
        d=google.com; s=arc-20160816;
        b=oQeXYnVFVbT9mZmfXz3OtPP1twH+MTaimQDX5XT6h8D7HiEpjC5d4qyuI3k5cwqJ+p
         NbVGcT1RR+yuGlmKExm6EBpCNLE7lMoe2jdgxdDLhvCTt0QAcVA3vGk0gPfEKtifIrqz
         BT5nM9XLn08mpOH8ANONIbsxkrEBqYTe4kjaiHY+u3vcIkBxViFslPIorHD82EAvnnDD
         4NEh5qsTPvn8iln3nOinreFaCCWEHPEmiQAURy9lfRn4MOYXN3wsy85CDzVONxTuuI52
         /kzoiGTgwcz9nI3EQPwt7Qb0Kb0PG8bZBDCaEMd4XJNdrNVapjDqSJ2bNkgV39EzMRW6
         RDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=q/1TpiHkFeW+bT5JNTr0vtZ2n9fW/6Or98kOiVw0xWg=;
        b=jiGJwICFl6vquiHlyDyT5nfubD7Jxi5DZBdvktZzUbLEX7wekc+6LIhWLKk7aYuPD4
         dqUwtu7e3GqQaSrYt7zCNjaFNpdLr08RqZcnjhFVLTLDOErF8n/ZRTVMeh8hNKCPPyQB
         QC10xfEVBLKbCciWsuTfCs6P1AxauzFDfBFPWy9D5S1nVBpvp07CnFbI+P4OgtxK442B
         2MrwK1AcxC7RjTiD9JTGujwnnZPvzUD2dAmKAgJGFzFVur9/CS18sbrLd1tXRBKRdVnE
         DaXkFgHR2SSD5Y8bg/IzvzwwIUlc2ui2wihHSHm59JGvCb4nW3QGJeBn25yP0Uxs6+sk
         TybQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of igor.stoppa@huawei.com designates 194.213.3.17 as permitted sender) smtp.mailfrom=igor.stoppa@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of igor.stoppa@huawei.com designates 194.213.3.17 as permitted sender) smtp.mailfrom=igor.stoppa@huawei.com
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>, Kate Stewart
	<kstewart@linuxfoundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, "Jonathan
 Corbet" <corbet@lwn.net>
References: <20180202154026.15298-1-robh@kernel.org>
 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
 <1517598363.7489.126.camel@perches.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <82b1f083-7df6-9c9f-e0a3-1cfc4a70a765@huawei.com>
Date: Sat, 3 Feb 2018 15:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1517598363.7489.126.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591387438526189753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/02/18 21:06, Joe Perches wrote:
> On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
>> On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>> On 02/02/18 17:40, Rob Herring wrote:
>>>> Add SPDX license tag check based on the rules defined in
>>>
>>> Shouldn't it also check that the license is compatible?
>>>
>>
>> Perhaps we shouldn't try to script legal advice.
> 
> True.
> 
> I believe what was meant was that the
> entry was a valid SPDX License entry
> that already exists as a specific file
> in the LICENSES/ path.

I expect that there is a finite number of compatible licenses.
Maybe I'm too optimistic about what can be taken as legal advice or not,
but I would expect that a warning about unmatched license type does not
constitute legal advice.

Is it too optimistic? :-D

--
igor

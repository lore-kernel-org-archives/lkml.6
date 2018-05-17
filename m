Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZpieknIlnCeoF03OnSBgdxx6A+ER35tAN6E/RtHMw5rbm4Ij+M8uhDDuLPfUeugEFTLjGFZ
ARC-Seal: i=1; a=rsa-sha256; t=1526548113; cv=none;
        d=google.com; s=arc-20160816;
        b=QQYEec0oV7ZF3O2HmZiWhsZZm58C0uqWRh/gC+t4Uj5zSMihabmRHmi0UEasJY7+T2
         +hQUZtevM2wa5dPl5swUUJjXl15ao2ltuQA8TtXxSVVDi3+sCNMSMwM3WXgRgxzv/bqY
         bIExjFZgoxX5SukdppOSE8bAMxWenpVOFgmRT9U/s6pke/Y8Axrz18GcYR8+5ib2bJz0
         SM9cY2CUNPAAezdbXymmRSfPNeWSxG7ygEomAhLzxff1POmAifBdj5Wn3V2roZOVbmhP
         iQxcE+A4qulje3TB6N/L7kRBJi0++ClHmkLGgdKSaUvms+KpRcLNVxNFi/HQX2GeTSQY
         YxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=tOsucbrOdqWMLV1PGIrGK8zEVeIk3W1JLuIdyDT6Ccs=;
        b=IS3RpLP7WTOYW5Su3beeYart+dmb48bvDL02jceL2CRM7U7Gzz4j3Ijght+vFpRK73
         JKiqyYnZrW+oeVfYRKXIlPN60gYHdyk6VVIvVAAAya+9xnu/NTT4ne0TFZMgcZAZtQOn
         cc+wE4eDfM917P4YHw9wUCpyJ1ixBIelp+k3fz6PAuJB5Y1DJnfs67yOPpRHa4Bueg2c
         rEqYSQNzgn4Ta08fcsilI/a2aI5daFRA0BzC1xHpxUJhWFoIzsooMn383T0Qpk4m9Obk
         9C+uVy1Bmd7kYNbfKQcwFjt9s2ZOWhGv4PEjj5yftDloWUZRzO8pGq97Iq63LW0AeB8I
         xcuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Mark.Rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
 vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com,
 Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org,
 john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
 jhugo@codeaurora.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
To: Greg KH <gregkh@linuxfoundation.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Catalin.Marinas@arm.com
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <20180517065449.GA13589@kroah.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <829ce0f6-0234-c0f1-0f30-7fbb36fa6049@arm.com>
Date: Thu, 17 May 2018 10:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517065449.GA13589@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214158032002659?=
X-GMAIL-MSGID: =?utf-8?q?1600701714761220829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 17/05/18 07:54, Greg KH wrote:
> On Tue, May 15, 2018 at 12:15:08PM -0500, Jeremy Linton wrote:
>> Hi Greg,
>>
>> Have you had a chance to look at the cachinfo parts of this patch?
> 
> Nope :)
> 
> I didn't write that, and while it is dumped in the driver core section
> of the kernel, I know nothing about it. 

Sorry for that, I didn't find any better place at that time(neither
now), so I did put it there following topology :)

> If you get an ack from Sudeep for this, which you did, that's fine
> with me, merge away!
> 

Thanks, we plan to take it via ARM64, hence we needed your official
say(ACK) for that.

-- 
Regards,
Sudeep

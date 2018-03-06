Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELvUiyFRM9yeB2rir7OXXW89VwrBihI7lwJZYkgGq/BXoCIfV6FYsQRlVwAsnUJ0JHVU6Y9e
ARC-Seal: i=1; a=rsa-sha256; t=1520355317; cv=none;
        d=google.com; s=arc-20160816;
        b=V8XeY0FBSaEJUenD0HhxCCpEbsXpC3zsADxTG7SokZbuTyeN/oURb6r4Vw8lvSz9Kg
         qhXyclgNjKSHcx89pW6doYucWFIQ9sNpzyzeXLUtDsZv1m08Flbq7NyTPNOaaK4XppkR
         53wpqzLy9aY6kZ059VUsU3tr57K5xBE7NrKLbkhxKsGVO1xA6iCvnnvPNL/4xLus9QBY
         D9VmfY6UM8gqKTNOq3t7fhbEX36s060x3CnM+D0/R+UZNIIpNYvQ1ppSDf6Tm3I9Qdsn
         pEJ4Ob+0YHedJ1r/An59GcISsvgkooj+7XPF1x+w/3GmWv+La+0NnCGUjkx0tJX9Va8w
         9NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=EnHWx5+Xb3cK3/5KADBtd7koXEyE3RpbCpPKo9ZkK3s=;
        b=nrP349E1TyUOBr28XGxlx1HTidhwReRjkxzd6IOkwsXM729Nn+Bk4YMNETtIRcT7yA
         95Rsx3N0/Xv2I5tuLs4zYauiygoQZb6ZsM7pzCk2igOb59Cy+6t7RNsgEnZUS09AASv6
         Xf4Q4K+zMrUp2+kegiUIHCMp5N0HVVBdtysILX+bmMjNq6086Xqrvg7aCRdT0c/3K4N9
         vQdjjl9c8gI1bkNZkpeBt1mplvSAzVnsb10HKpEJ+31QfKds6ix9VQ3faQCK0bR49PCM
         rOC5B5rnCmPhXudP8rxu1uDPqZj3XXKQHDh8MKDG5ys6d1LwP/CVBCctcZWvu2l3O24I
         tO0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 06/13] ACPI: Enable PPTT support on ARM64
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-7-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <776784b6-01ce-1385-0d02-ca5fd1ece61f@arm.com>
Date: Tue, 6 Mar 2018 16:55:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-7-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684151159305303?=
X-GMAIL-MSGID: =?utf-8?q?1594208098186525130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> Now that we have a PPTT parser, in preparation for its use
> on arm64, lets build it.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

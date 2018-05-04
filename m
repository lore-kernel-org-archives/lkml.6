Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZomMsptWwSaZ06ZVf3Bjd6KxAl+LB6clRjxPdVIfyeD1r/eSbHVkBWXlEhaf+p3VLkCynUK
ARC-Seal: i=1; a=rsa-sha256; t=1525434307; cv=none;
        d=google.com; s=arc-20160816;
        b=om9neVFJuDb12gYeauERDO6tfJDDD718eFKNto1Z0JtCXB6UYJU15vjVzhwvGUkJbG
         BREQCkkU2osqFT6TMOYADLVed5BC6BQHYKcsOp2KRucivZHGntgwckcjGEk99ufALzkG
         0IlgbF4Idj53f6JV1AmpfZrHT0rtrwJw7oKzFU5VH8I4OwMgkJG1w5acFyuPh2wYe758
         aAklUfWvZxCZ5K2ZGT2iD6Bidv40/l2LyCHikCxjVQxQL/fHGlOWjTgNo0F7az7mM67N
         bLViOU7yf2p0TgbvO0BG+1OFJqVasXlayZzD5N6zfUgX2ioQ+ZCA8uB/yIdu0pGNbF+n
         RjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=YcdZltrBMhUdQQnc32IP/L0ZZPtSryHGsc+PrOyD5mU=;
        b=zkWi1CXAIQw6YKS62uUBgxendTDx2oHql2VsDViBdQdPUbK+rygc2C+6o8w2tp+PP+
         A1vhIf9KmXTbxaX3R2+nPX/5g4REPMJy6mo+lhEU5SD035V9lyk/7Hd2LVEPR1CFfCc+
         sWQf4OoxN+u6fii6NNdCaHQPC3DBKKLwEBAvzefCt1yi3qWArP66BIzti4kPFfKmrRSp
         s4Lc0DPxy9fihe2Eag5zSKvbOpM8KL0uk/C+iIEd9/aXlxJd0mXUYJ01v1SLiHrP3I5s
         KuaTnsv5wmvjtGdVnaC4tKyEOi0Dy8yhkci023vRf4cZtRCAOx/dcyXSVbkBHDW2dqBc
         nxyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, ahs3@redhat.com, Dietmar.Eggemann@arm.com,
 Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org,
 john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
 jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 00/13] Support PPTT for ARM64
To: vkilari@codeaurora.org, 'Jeremy Linton' <jeremy.linton@arm.com>,
 linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <050a01d3e37f$57678470$06368d50$@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <493de8bf-b59e-cfac-6e34-f4c1443ee0fe@arm.com>
Date: Fri, 4 May 2018 12:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <050a01d3e37f$57678470$06368d50$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310843839266?=
X-GMAIL-MSGID: =?utf-8?q?1599533805003808857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijaya Kumar,

On 04/05/18 09:10, vkilari@codeaurora.org wrote:
> 
[...]

CPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to
>> describe the processor and cache topology. Ideally it is used to
> extend/override

FYI, these messages go no where to the git commit log. Only individual
patch logs/messages will go and not the cover letter ones. Check if you
are happy with those.

-- 
Regards,
Sudeep

Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZr5X4moUApLMQUqvqPqiqx0U8SsKzEI6Q+/REWzJ8LDOs9SO211BX+RMD1cAwhagJefGq2X
ARC-Seal: i=1; a=rsa-sha256; t=1525185655; cv=none;
        d=google.com; s=arc-20160816;
        b=0l7B5EmtIukrg3LLE75xJqBCoKk6q0Yg0LerQsdK7/gY5H9HjU5GcIt1B6eoqZTTet
         eM+LhcrOeysTIfHcNw4kWshF8rIbm9gFGObkU3GszgxH2bG5EYB5yL8RNJq2ge7ek8kt
         7jpHN9N2bZnJZsa/xySG/id+znotYSOQruVzXFmUWMXJY1eMVIRNof4PI/FKyh9RwdTc
         j3X7877bnbhWkTPotkFIlcWu4CD5MAHQRSKYUAeydl+cLVSU9yhBUF4YsPSbAIr8nozW
         W4ipMwrO/S+2K9OpIagLdCCQTpp7eJz49df+ne2mohEvGhvGZuPLUEoIZjq2R7dcjp3e
         wfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=Ig9sLEZuQbFiVMekSmWSfdfjzG5nLW4hpumDkiR5WhM=;
        b=S667TU95Zsc9Dvq+3fC8f8NKkn2M7/THdvmYRXEDWfOuEYzBL+Uh5EzUrYAcATlwwW
         KWrY5HyJ4sJXVzSR7mQNjNumUWm/NOl9WjZP7GRxoeRjn5xW5wnu1Uz7BRrCToLwOn4S
         dcvoI2NfH0EG5rpkkLTYlSWR3d1JkROZQO6pl0ljDy4pZT5nLr5VOj6pvFaH2dZJOtSo
         tPKAUMbTJen0A88nSXzpGA49XHJDJbGFUVm4K3Ey9K4yI6Y84XAeD4ESqq8Xl5x1CgZv
         iVkRsYDk7B03zUV6rnrpbuujXWQAxYRCCNY5mH03yz0TqgLMCtmchrHW7LQ3NWfyO6SN
         UVSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 10/13] arm64: topology: rename cluster_id
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-11-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <06cdff18-8544-8748-4164-9adb20cfb304@arm.com>
Date: Tue, 1 May 2018 15:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-11-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766326590040185?=
X-GMAIL-MSGID: =?utf-8?q?1599273073891894037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 00:31, Jeremy Linton wrote:
> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.

[nit] You can add a note that cluster id is not architectural defined
for ARM platforms just to elaborate on the intention for this change.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

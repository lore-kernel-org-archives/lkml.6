Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELvxlanpfwDUxOD2w7YXbrAed5+VIpyonnAp6CQliaIczkt1zb+59n7P559/O22dRPmydpMu
ARC-Seal: i=1; a=rsa-sha256; t=1520357014; cv=none;
        d=google.com; s=arc-20160816;
        b=g29GW+NPJhGoERlhka4WcKEHkHQgpDg8z4MvGI/RRfo3l1/lvUtTH5xRwfRdT/daGa
         dcwjzlsWLORrGtZZnCu8o1Z42rOwmoQyRLVPxIpBxOjw1o/r/95OtIqDJYPL7l2Y1pFU
         L6Tmrn9q2UMLdWDofpuWaS9dnKc+JXS8leAXa6wSDb9nok2CD/sjargDDGpy9NA5aRKh
         9xF/ZlOSI2WUMR1ljZ2lUWuZD/74nL6Sx/+sHrf218Q0Uu7uNRvuwxXqg1DvxRKpWIMP
         ji+4la8urMjOPUcrfFZZfLG+IaJYOKgZtHNqCcQnEYwds6b3G5Z6glmYKIFcYu8iT5py
         Z33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=hpTo764A4+WmJJXdknSx0EiIFDORwJGvKE7Wmc7imMM=;
        b=d31N1+vzGp/PH9r1xRFhc9Zc3YUVCKnCl8c7oh6h144rfIZlWPPVsmLUQymPGx69jd
         ORtXTbpGgW7iWDxVbFSAO7kL2mqTn99nkOtvqMnniwK8a0PqRuzRGca+lghgvY9XJDIU
         rgJm4WTJ/R41Xxe8QO16suzZk10T/zoEo6DaD6TmBzqQdXBSVLg1bpHZIS2AcX0c4dyW
         P+AdIR9IJAd3VQ8eaTcXFvkJTDBrWvHpYAVQjdGEvn+WSIPQBSoy/nCnEvwmcsMGmen+
         tabi7RZdVAnOt89QSdiM97OOCKF5pQm9cZ7QlPFdOjtsLgsVve7cOU1lPq7yD64i2f8d
         kOWw==
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
Subject: Re: [PATCH v7 08/13] arm64: Add support for ACPI based firmware
 tables
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-9-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <362fcf8a-44f8-7eb5-0f17-a7763f6236e4@arm.com>
Date: Tue, 6 Mar 2018 17:23:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-9-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684154790972814?=
X-GMAIL-MSGID: =?utf-8?q?1594209877131683512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> The /sys cache entries should support ACPI/PPTT generated cache
> topology information. Lets detect ACPI systems and call
> an arch specific cache_setup_acpi() routine to update the hardware
> probed cache topology.
> 
> For arm64, if ACPI is enabled, determine the max number of cache
> levels and populate them using the PPTT table if one is available.
> 

I fail to understand the kbuild failure report association with this
patch(most likely the previous patch could be culprit, I am looking at
it in detail now), but for this patch

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtvEuKlcL81UezE6FAUygwTp1NF78T6P5yFO+3TxNNWpwDoVp1f7Wn8DxIoOp14ZCwEUPc6
ARC-Seal: i=1; a=rsa-sha256; t=1520354709; cv=none;
        d=google.com; s=arc-20160816;
        b=S2YkipcD55PUNGee+j3AzLKFXnWqN4grr+xuRxkvmmo+bZYCTVX+6IcMWwCsNh4QzQ
         qB063aCB41uU8zuhrk++Trlp5HEzlIQ1SY8PgTd7Y58F8yaFP4MPN3vWMPYZGX4wS7xR
         HKK4Iyvy0+esfXczByHUlNMQ/7qGzDehoA3ATfEXT9kNXQ5L1D8Tv4gQ6L0Y5jNXV0Kk
         vdI8AN8CGme27Mjzjyh3voiawX77F1iVnp7P14Cic2aKUQ/9i70vpPfhBDMZl8pLzzo2
         YGSm6ZbL/tTqgKFE9x1URHm3FIUgh6AEvT9fWEbA+q41PpQeNLhsP/XJcU4f6D6RCMas
         1i0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=jxokB72zfR5yjYOEyfDuhDjFOW104bcEbwDhZNhonj0=;
        b=wdPaN4uA5RbYIrHHTdmj9xvK7v+f1LTYI0aDj2Fmd7FwdrW6Ja5QraO2xmzx2kWslm
         zA5KLPcg+O5n7neWB2BhusiUVScnNU6Kb3XE1Ya1I55sysCIusr+C6nH9BgdaWJWqjGH
         9xE2uie00Pqw9Pa3J1AnkuGiVm8fo5tmeju70WYU8uTqkxwva1FyHxXmgotZ7QY+Gzyc
         XExe64J2Behmga9RbWSjiRfJZqs1Y0FnTt76MCmMPdur3JJQVSR64RK/IVXSVVhap4wx
         lgn4rWbjh/7afA53aCdgvP/8aajMeTl6xKTQ0/9QusEghn7omGLXI7UrJt8Exgyi4K3M
         KNxw==
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
Subject: Re: [PATCH v7 03/13] cacheinfo: rename of_node to fw_token
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-4-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <4864c763-0d11-9e09-ff02-87e94b410da6@arm.com>
Date: Tue, 6 Mar 2018 16:45:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-4-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684145443447566?=
X-GMAIL-MSGID: =?utf-8?q?1594207460209501534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> Rename and change the type of of_node to indicate
> it is a generic pointer which is generally only used
> for comparison purposes. In a later patch we will put
> an ACPI/PPTT token pointer in fw_token so that
> the code which builds the shared cpu masks can be reused.
> 
Thanks for renaming :)

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

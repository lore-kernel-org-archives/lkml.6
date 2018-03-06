Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELsMdsHuS2zJd4c5mr+pKq2qteKsBs3e0ABMuYZq6xAWjjj6Y0WlkBLbsgge7qC7CcwceLck
ARC-Seal: i=1; a=rsa-sha256; t=1520352980; cv=none;
        d=google.com; s=arc-20160816;
        b=TPq+ID9P7Bm67oR+xH3sktMEgpqXryL+5GeDGHcJZQEaH21dxOG2JOabXRbid3d7oQ
         EGWdsVAz087U6h0gcFwPlPaJCs3YfNmIqzsxzt4cGE8FhwfEJF5/dCrwdoAojN04qe1N
         /vWhd+1N7q3rUKzB0pNVvT1zGwgyrujhlWXw+J/E8gta8Tp1ApsClFUIDmuVN5r680bx
         yju4AMfefQpju6RG/ZjCR3x8DdGAn0dFXCsS8GBZbc6aKyPryC0m6rtJ2I5SHJBq2GyN
         cQp076wEnudyjSwTzM+lMMhluThDhTwJ8sBnGpyc0lPiLkrtVz5oPY/X2eB1RtLcXgpf
         a2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=EObmYN2PuVeswjtofQ4cPiLOGhdGULlZ/m6f2On2jQA=;
        b=gPaMYer6MsjS/gscmgVLcwAdel4YxSBD7Av3BpLOCn6MlrvjPYIYlxycMAAVbExRr7
         Pb2Svs9OSEUndC1bUWiTq0L48KuAWaBipzv4xvsam5/hAn71AeT2znbxbrSC6Wezr1nF
         KY5Pk0bcv5eU758WdM3FmrZ17CLWHrZIpQuuFrdjegQU2itNH7khZTwIU4Re+hE5JbAE
         Hd3YhdmXMMcuO0E/tQgs7mlxx7sBTNurpCuISeyf+2uvJzYEiDAbASMpK1G9UhQyl7Zg
         8/RmhUViwjVBQzb89rZiCiPzm2cEGRegtfLotGNtEuZ2Qez4dkmDARWE/mjH/Dr7YL1x
         Y2AA==
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
Subject: Re: [PATCH v7 01/13] drivers: base: cacheinfo: move
 cache_setup_of_node()
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-2-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <f74da924-31ba-22a9-1386-0c9b0cc41e61@arm.com>
Date: Tue, 6 Mar 2018 16:16:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684140441831379?=
X-GMAIL-MSGID: =?utf-8?q?1594205647185904286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> In preparation for the next patch, and to aid in
> review of that patch, lets move cache_setup_of_node
> further down in the module without any changes.
> 
I don't think this is change since v6 so my ack stands.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

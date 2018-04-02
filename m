Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeDBR7t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:59:49 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40615 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDBR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:59:48 -0400
X-Google-Smtp-Source: AIpwx4+P7KqMjlqA1RqwWWUcGkBhThadQV8q9lUWAnGvCcXSUHVX9ZABOcHJtWGF8BwycOlvY+5iRA==
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
To: Hanjun Guo <guohanjun@huawei.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
 <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
From: Neil Leeder <neil.m.leeder@gmail.com>
Message-ID: <0094c5ab-89db-409f-d5fb-c961f9d84740@gmail.com>
Date: Mon, 2 Apr 2018 13:59:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

On 4/2/2018 10:24 AM, Hanjun Guo wrote:
<SNIP>
> 
> I think we need to wait for the new version of IORT spec,
> which includes the fix for the two base address for SMMUv3
> PMCG (now just represent one).
> 
> Thanks
> Hanjun
> 
It's in rev D which is available now:
http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Neil

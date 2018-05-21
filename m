Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeEURlr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:41:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44322 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeEURks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:40:48 -0400
X-Google-Smtp-Source: AB8JxZpaxzu4DHKdxLFV55p43+ZNzhUBXkoe5yeb/tE+y7h+bcU+JW9V8gC475qpPC2mso5FZib2vQ==
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
To: Tyler Baicar <tbaicar@codeaurora.org>, bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
 <737bea6a-2f0e-e573-754e-2e410c34013e@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <a2d37208-a8d1-0995-5915-2eb4a0ab2fa4@gmail.com>
Date: Mon, 21 May 2018 12:40:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <737bea6a-2f0e-e573-754e-2e410c34013e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2018 09:27 AM, Tyler Baicar wrote:
> On 5/21/2018 9:49 AM, Alexandru Gagniuc wrote:
(snip)
> Hello Alex,
> 
> There is a compile warning if CONFIG_HAVE_ACPI_APEI_NMI is not selected.
> 
>   CC      drivers/acpi/apei/ghes.o
> drivers/acpi/apei/ghes.c:483:12: warning: ‘ghes_severity’ defined but
> not used [-Wunused-function]
>  static int ghes_severity(struct ghes *ghes)
>             ^~~~~~~~~~~~~

Thanks for finding that. It's an easy fix. Staged for v7.

> Thanks,
> Tyler
> 

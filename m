Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBWCLB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:11:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:5457 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751357AbeBWCLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:11:00 -0500
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "cdall@linaro.org" <cdall@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "thgarnie@google.com" <thgarnie@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "tixy@linaro.org" <tixy@linaro.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>
CC: "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "opendmb@gmail.com" <opendmb@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 00/11] KASan for arm
Thread-Topic: [PATCH 00/11] KASan for arm
Thread-Index: AQHTQmojvAxAp/R+vEG5U+IONzQlRaOi6VcAgA8iKkA=
Date: Fri, 23 Feb 2018 02:10:52 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0072D47@dggemm510-mbs.china.huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <09f86876-2247-1d2c-b195-76d8b34d0aff@gmail.com>
In-Reply-To: <09f86876-2247-1d2c-b195-76d8b34d0aff@gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N2B51F027700

On 2018/2/14  2:41 AM, Florian Fainelli [f.fainelli@gmail.com] wrote:
>Hi Abbott,
>
>Are you planning on picking up these patches and sending a second
>version? I would be more than happy to provide test results once you
>have something, this is very useful, thank you!
>-- 
>Florian

I'm sorry to reply you so late. I had a holiday on last few days.
Yes, I will send the second version, maybe on next two weeks.

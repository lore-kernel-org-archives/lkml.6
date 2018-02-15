Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163250AbeBOU7g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:59:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162995AbeBOU7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:59:34 -0500
Subject: Re: [PATCH v4 00/17] arm64: Add SMCCC v1.1 support and CVE-2017-5715
 (Spectre variant 2) mitigation
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20180206175621.929-1-marc.zyngier@arm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <e9df17e7-86ee-2f7a-b8e2-d78ac0358fc3@redhat.com>
Date: Thu, 15 Feb 2018 15:59:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206175621.929-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, all,

On 02/06/2018 12:56 PM, Marc Zyngier wrote:
> ARM has recently published a SMC Calling Convention (SMCCC)
> specification update[1] that provides an optimised calling convention
> and optional, discoverable support for mitigating CVE-2017-5715. ARM
> Trusted Firmware (ATF) has already gained such an implementation[2].

I'm probably just missing something, but does this end up reported
somewhere conveniently user visible? In particular, if the new SMC is
*not* provided, does the user end up easily seeing this?

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

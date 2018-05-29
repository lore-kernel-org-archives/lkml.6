Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeE2NjK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:39:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933548AbeE2NjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:39:09 -0400
Subject: Re: [PATCH v2 04/17] arm64: Add ARCH_WORKAROUND_2 probing
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
 <20180529121121.24927-5-marc.zyngier@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <4461a4e7-e620-aec6-0f58-674080418e80@arm.com>
Date: Tue, 29 May 2018 14:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529121121.24927-5-marc.zyngier@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 13:11, Marc Zyngier wrote:
> As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
> discovery mechanism for detecting the SSBD mitigation.
> 
> A new capability is also allocated for that purpose, and a
> config option.
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeDPVqb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:46:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34808 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeDPVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:46:28 -0400
X-Google-Smtp-Source: AIpwx497iBfAXZIxXjq41aU7THd9yXv2Ky1Hd3S1nuQ10yHJYbU7wP6MV3lW2adD4K5kx2hm8inCJA==
Subject: Re: [RFC 3/3] arm: shmobile: Add the RZ/N1D SMP enabler driver.
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Andy Gross <andy.gross@linaro.org>, Carlo Caione <carlo@endlessm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Frank Rowand <frank.rowand@sony.com>, Juri Lelli <juri.lelli@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523871304-48517-5-git-send-email-michel.pollet@bp.renesas.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <9f33a1d2-3c55-2485-a1f2-909def69e5b0@gmail.com>
Date: Mon, 16 Apr 2018 14:46:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523871304-48517-5-git-send-email-michel.pollet@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On 04/16/2018 02:34 AM, Michel Pollet wrote:
> The Renesas RZ/N1D second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started at boot time.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Some few comments below. This patch should probably be re-ordered in
your patch series, I would expect you to have this become patch 2 and
have patch 2 be patch 3 (first you add infrastructure for using
something, then you make use of it).

> +static int rzn1_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	if (!cpu_bootaddr)
> +		return -ENODEV;
> +
> +	spin_lock(&cpu_lock);
> +
> +	writel(virt_to_phys(secondary_startup), cpu_bootaddr);

Consider using __pa_symbol() instead of virt_to_phys() since
secondary_startup is part of the kernel's linear memory map.

> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +	spin_unlock(&cpu_lock);
> +
> +	return 0;
> +}
> +
> +static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *dn;
> +	int ret;
> +	u32 bootaddr;
> +
> +	dn = of_get_cpu_node(1, NULL);
> +	if (!dn) {
> +		pr_err("CPU#1: missing device tree node\n");
> +		return;
> +	}
> +	/*
> +	 * Determine the address from which the CPU is polling.
> +	 */
> +	ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
> +	if (ret)
> +		pr_err("CPU#1: invalid cpu-release-addr property\n");
> +
> +	of_node_put(dn);
> +	/* The bootloader *does* change this property */

This comment should probably be moved above the function that fetches
"cpu-release-addr"

> +	pr_info("CPU#1: cpu-release-addr %08x\n", (u32)bootaddr);
> +
> +	if (!bootaddr)
> +		return;

Would not you want to show a message here to help catch such conditions

> +
> +	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));

Relying on ioremap() to reject values that might be outside of the
allowed range may be a little fragile, but I can't suggest any better
alternative.

> +	if (!cpu_bootaddr)
> +		pr_err("CPU#1: cpu-release-addr map failed\n");
> +}
> +
> +static const struct smp_operations rzn1_smp_ops __initconst = {
> +	.smp_prepare_cpus = rzn1_smp_prepare_cpus,
> +	.smp_boot_secondary = rzn1_smp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032-smp", &rzn1_smp_ops);
> 


-- 
Florian

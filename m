Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A55BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074F2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F074F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKCH2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:28:22 -0400
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:12829 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:28:22 -0400
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA2MIYnb072516;
        Sat, 3 Nov 2018 00:18:36 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-ae-5bdccd3984e5
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 27.46.03682.93DCCDB5; Sat,  3 Nov 2018 00:18:33 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA2MIVSD005173;
        Sat, 3 Nov 2018 00:18:31 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 03 Nov 2018 00:18:31 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        alankao@andestech.com, hch@infradead.org, anup@brainfault.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        zong@andestech.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <9385b2eb-4729-8247-b0ae-1540793d078b@wdc.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <9385b2eb-4729-8247-b0ae-1540793d078b@wdc.com>
Message-ID: <ffc68a79af6e981654bef5bcdb283161@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXSHc2orGt59k60wZwOPYttS1azWrR8eMdq
        sWjFdxaL1vZvTBbzj5xjtTg9YRGTxeVdc9gstn1uYbNYev0ik0Xzu3PsFpsnLGC1aN17BMja
        NJXZ4vnKXjYHPo89p2cxe6yZt4bRY+rvMyweDzddYvLYvELLY9OqTjaPd+fOsXtsXlLvcan5
        OrvH501yHu0HupkCuKO4bFJSczLLUov07RK4MlbtPMBa0KFZMW/RSqYGxq/yXYycHBICJhLr
        D99i7WLk4hASOMIo8WzzRjaQhJDAQUaJtTvcIYpMJWbv7WQEsXkFBCVOznzCAmIzC1hITL2y
        nxHClpdo3jqbGcRmEVCVuHikC6yGTUBTYv6lg0A2B4cIUHzWIn6QXcwCv5kkTmy4DFYvLKAn
        0bThJiuIzS8gLPHp7kUwm1PAWmLFoUksEMetZ5S4vHgZC8QRLhInnh5igzhOReLD7wfsILao
        gLLEixPTWScwCs1CcussJLfOQnLrAkbmVYwCiWXGepnJxXpp+UUlGXrpRZsYwbE413cH47kF
        9ocYBTgYlXh4DSrvRAuxJpYVV+YeYpTgYFYS4f3SChTiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e/hFeJCQQHpiSWp2ampBahFMlomDU6qBMfnG4kVTq5/Kutvrhi6e8F9Yap0c37LuM5bBSwTa
        ZLLOVi/bs/Dt5bdRbTOLby1PscgTNr25N3pqSuzmSnHrk4/9va33d58O8DS4I3W6UrvTOuHv
        pQunHLbeXfvokeLuHeFTln7d/7FqWn1OwXQXu6KSO3+anHNcXvzuK5+5TorF7fg92Rdck5RY
        ijMSDbWYi4oTAeXAX0zBAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2018-11-02 23:14, Atish Patra έγραψε:
> On 11/2/18 11:59 AM, Nick Kossifidis wrote:
>> Hello All,
>> 
>> Στις 2018-11-02 01:04, Atish Patra έγραψε:
>>> This patch series adds the cpu topology for RISC-V. It contains
>>> both the DT binding and actual source code. It has been tested on
>>> QEMU & Unleashed board.
>>> 
>>> The idea is based on cpu-map in ARM with changes related to how
>>> we define SMT systems. The reason for adopting a similar approach
>>> to ARM as I feel it provides a very clear way of defining the
>>> topology compared to parsing cache nodes to figure out which cpus
>>> share the same package or core.  I am open to any other idea to
>>> implement cpu-topology as well.
>>> 
>> 
>> I was also about to start a discussion about CPU topology on RISC-V
>> after the last swtools group meeting. The goal is to provide the
>> scheduler with hints on how to distribute tasks more efficiently
>> between harts, by populating the scheduling domain topology levels
>> (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
>> What we want to do is define cpu groups and assign them to
>> scheduling domains with the appropriate SD_ flags
>> (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
>> 
> 
> Scheduler domain topology is already getting all the hints in the 
> following way.
> 
> static struct sched_domain_topology_level default_topology[] = {
> #ifdef CONFIG_SCHED_SMT
>         { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
> #endif
> #ifdef CONFIG_SCHED_MC
>         { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
> #endif
>         { cpu_cpu_mask, SD_INIT_NAME(DIE) },
>         { NULL, },
> };
> 
> #ifdef CONFIG_SCHED_SMT
> static inline const struct cpumask *cpu_smt_mask(int cpu)
> {
>         return topology_sibling_cpumask(cpu);
> }
> #endif
> 
> const struct cpumask *cpu_coregroup_mask(int cpu)
> {
>         return &cpu_topology[cpu].core_sibling;
> }
> 
> 

That's a static definition of two scheduling domains that only deal
with SMT and MC, the only difference between them is the
SD_SHARE_PKG_RESOURCES flag. You can't even have multiple levels
of shared resources this way, whatever you have larger than a core
is ignored (it just goes to the MC domain). There is also no handling
of SD_SHARE_POWERDOMAIN or SD_SHARE_CPUCAPACITY.

>> So the cores that belong to a scheduling domain may share:
>> CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
>> Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
>> Power domain (SD_SHARE_POWERDOMAIN)
>> 
>> In this context I believe using words like "core", "package",
>> "socket" etc can be misleading. For example the sample topology you
>> use on the documentation says that there are 4 cores that are part
>> of a package, however "package" has a different meaning to the
>> scheduler. Also we don't say anything in case they share a power
>> domain or if they have the same capacity or not. This mapping deals
>> only with cache hierarchy or other shared resources.
>> 
>> How about defining a dt scheme to describe the scheduler domain
>> topology levels instead ? e.g:
>> 
>> 2 sets (or clusters if you prefer) of 2 SMT cores, each set with
>> a different capacity and power domain:
>> 
>> sched_topology {
>>    level0 { // SMT
>>     shared = "power", "capacity", "resources";
>>     group0 {
>>      members = <&hart0>, <&hart1>;
>>     }
>>     group1 {
>>      members = <&hart2>, <&hart3>;
>>     }
>>     group2 {
>>      members = <&hart4>, <&hart5>;
>>     }
>>     group3 {
>>      members = <&hart6>, <&hart7>;
>>     }
>>    }
>>    level1 { // MC
>>     shared = "power", "capacity"
>>     group0 {
>>      members = <&hart0>, <&hart1>, <&hart2>, <&hart3>;
>>     }
>>     group1 {
>>      members = <&hart4>, <&hart5>, <&hart6>, <&hart7>;
>>     }
>>    }
>>    top_level { // A group with all harts in it
>>     shared = "" // There is nothing common for ALL harts, we could 
>> have
>> capacity here
>>    }
>> }
>> 
> 
> I agree that naming could have been better in the past. But it is what
> it is now. I don't see any big advantages in this approach compared to
> the existing approach where DT specifies what hardware looks like and
> scheduler sets up it's domain based on different cpumasks.
> 

It is what it is on ARM, it doesn't have to be the same on RISC-V, 
anyway
the name is a minor issue. The advantage of this approach is that you 
define the
scheduling domains on the device tree without needing a "translation" of 
a
topology map to scheduling domains. It can handle any scenario the 
scheduler
can handle, using all the available flags. In your approach no matter 
what
gets put to the device tree, the only hint the scheduler will get is one
level of SMT, one level of MC and the rest of the system. No power 
domain
sharing, no asymmetric scheduling, no multiple levels possible. Many 
features
of the scheduler remain unused. This approach can also get extended more 
easily
to e.g. support NUMA nodes and associate memory regions with groups.

Regards,
Nick


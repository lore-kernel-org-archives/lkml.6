Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202B20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeKCEPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:15:51 -0400
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:30610 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeKCEPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:15:50 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Nov 2018 00:15:49 EDT
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA2IwfNC069634;
        Fri, 2 Nov 2018 20:58:43 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-4c-5bdc9e60aae2
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id EA.36.03682.06E9CDB5; Fri,  2 Nov 2018 20:58:40 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA2Iwd6q019465;
        Fri, 2 Nov 2018 20:58:39 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 02 Nov 2018 20:58:39 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Damien.LeMoal@wdc.com,
        alankao@andestech.com, zong@andestech.com, anup@brainfault.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Organization: FORTH
In-Reply-To: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
Message-ID: <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXSHc2orJsw7060wb0+S4ttS1azWrR8eMdq
        sWjFdxaL1vZvTBbzj5xjtTg9YRGTxeVdc9gstn1uYbNYev0ik8XmCQtYLVr3HmG32LxpKrPF
        85W9bA68HntOz2L2WDNvDaPH1N9nWDw2r9Dy2LSqk83j3blz7B6bl9R7XGq+zu7xeZOcR/uB
        bqYArigum5TUnMyy1CJ9uwSujKXvGlkL5ohWbJ6wmr2B8ZJAFyMnh4SAicSlRQeZuxi5OIQE
        jjBKdExZzArhHGSUaHs3mR2iylRi9t5ORhCbV0BQ4uTMJywgNrOAhcTUK/sZIWx5ieats5lB
        bBYBVYknmyeCxdkENCXmXzoIVM/BIQIUn7WIH2Q+s8AeJoldM5aD1QgL6Ek0bbjJCmLzCwhL
        fLp7EczmFHCRWHf8AliNkICzxLUnMDe4SHQvPs0IcZuKxIffD8DuFBVQlnhxYjrrBEahWUhO
        nYXk1FlITl3AyLyKUSCxzFgvM7lYLy2/qCRDL71oEyM47ub67mA8t8D+EKMAB6MSD69B5Z1o
        IdbEsuLK3EOMEhzMSiK8X1qBQrwpiZVVqUX58UWlOanFhxilOViUxHkPvwgPEhJITyxJzU5N
        LUgtgskycXBKNTAGZKhfbHuUk+v0OKB7Q/bPkvtfRI/Pn17A67NTJiNETP7fa2YLhfWzpEzF
        ZxTI+EWwcn9kbGhY3/5pZ27ShYxkw9gJM+88Wbkl0fb5X0OVmJkaOv9e7VvmV8GaE/2XKSLk
        SczHqstv9jg43V153u1Mm6RuyOXdV2tv3ly5JW5v1JW1Maty6jYpsRRnJBpqMRcVJwIA/dqV
        q7cCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Στις 2018-11-02 01:04, Atish Patra έγραψε:
> This patch series adds the cpu topology for RISC-V. It contains
> both the DT binding and actual source code. It has been tested on
> QEMU & Unleashed board.
> 
> The idea is based on cpu-map in ARM with changes related to how
> we define SMT systems. The reason for adopting a similar approach
> to ARM as I feel it provides a very clear way of defining the
> topology compared to parsing cache nodes to figure out which cpus
> share the same package or core.  I am open to any other idea to
> implement cpu-topology as well.
> 

I was also about to start a discussion about CPU topology on RISC-V
after the last swtools group meeting. The goal is to provide the
scheduler with hints on how to distribute tasks more efficiently
between harts, by populating the scheduling domain topology levels
(https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
What we want to do is define cpu groups and assign them to
scheduling domains with the appropriate SD_ flags
(https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).

So the cores that belong to a scheduling domain may share:
CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
Power domain (SD_SHARE_POWERDOMAIN)

In this context I believe using words like "core", "package",
"socket" etc can be misleading. For example the sample topology you
use on the documentation says that there are 4 cores that are part
of a package, however "package" has a different meaning to the
scheduler. Also we don't say anything in case they share a power
domain or if they have the same capacity or not. This mapping deals
only with cache hierarchy or other shared resources.

How about defining a dt scheme to describe the scheduler domain
topology levels instead ? e.g:

2 sets (or clusters if you prefer) of 2 SMT cores, each set with
a different capacity and power domain:

sched_topology {
  level0 { // SMT
   shared = "power", "capacity", "resources";
   group0 {
    members = <&hart0>, <&hart1>;
   }
   group1 {
    members = <&hart2>, <&hart3>;
   }
   group2 {
    members = <&hart4>, <&hart5>;
   }
   group3 {
    members = <&hart6>, <&hart7>;
   }
  }
  level1 { // MC
   shared = "power", "capacity"
   group0 {
    members = <&hart0>, <&hart1>, <&hart2>, <&hart3>;
   }
   group1 {
    members = <&hart4>, <&hart5>, <&hart6>, <&hart7>;
   }
  }
  top_level { // A group with all harts in it
   shared = "" // There is nothing common for ALL harts, we could have 
capacity here
  }
}

Regards,
Nick

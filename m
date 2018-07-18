Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BF3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2776B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2776B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGRUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:45:17 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37511 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbeGRUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:45:16 -0400
Received: from [192.168.0.5] (ip5f5bd2a0.dynamic.kabel-deutschland.de [95.91.210.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id ABE012012BA068;
        Wed, 18 Jul 2018 22:05:45 +0200 (CEST)
Subject: Re: NULL pointer dereference in msi_set_mask_bit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de>
 <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de>
 <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de>
 <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
 <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de>
From:   Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <7660f2f2-0c37-a617-ecdc-949cd4ecc060@molgen.mpg.de>
Date:   Wed, 18 Jul 2018 22:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,


Am 18.07.2018 um 21:00 schrieb Thomas Gleixner:

> On Wed, 18 Jul 2018, Paul Menzel wrote:
>> On 07/18/18 17:39, Thomas Gleixner wrote:
>>> Bah. Could you please enable GENERIC_IRQ_DEBUGFS and after a successful
>>> boot up provide me the content of all files in /sys/kernel/debug/irq/ and
>>> its subfolders?
>>
>> Sure, please find them attached. `7zr x sys-kernel-debug-irq.7z` should
>> extract it.
> 
> It generates the files, but they are all size '1' and contain nothing.

Sorry, I do not know what I did wrong. I’ll try it again tomorrow.


Kind regards,

Paul

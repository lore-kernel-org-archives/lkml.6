Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A1C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4632A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4632A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ3R26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:28:58 -0400
Received: from mail.monom.org ([188.138.9.77]:54456 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeJ3R26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:28:58 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 87212500A1F;
        Tue, 30 Oct 2018 09:36:27 +0100 (CET)
Received: from [127.0.0.1] (mail.monom.org [188.138.9.77])
        by mail.monom.org (Postfix) with ESMTPSA id 72CB150051A;
        Tue, 30 Oct 2018 09:36:24 +0100 (CET)
Subject: Re: [PATCH RT 1/2] x86/kconfig: Fall back to ticket spinlocks
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20181029201617.24733-1-wagi@monom.org>
 <20181029201617.24733-2-wagi@monom.org>
 <20181029231244.xfj42ucddp7xnoae@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <3f4d0e85-c48a-17bf-c180-00ddf5584484@monom.org>
Date:   Tue, 30 Oct 2018 09:37:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181029231244.xfj42ucddp7xnoae@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 00:12, Sebastian Andrzej Siewior wrote:
> On 2018-10-29 21:16:16 [+0100], Daniel Wagner wrote:
>> From: Daniel Wagner <daniel.wagner@siemens.com>
>>
>> v4.4.162-rt176-rc1 stable review patch.
>> If anyone has any objections, please let me know.
> 
> I though that we are going to route this via Greg/stable for v4.4?

ah yes... I should not send out patches after a long day of work...

next try

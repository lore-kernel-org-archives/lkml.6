Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B406BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAF220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAF220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeG3MqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:46:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55807 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeG3MqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:46:02 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk65H-0007F2-Ef; Mon, 30 Jul 2018 13:11:27 +0200
Date:   Mon, 30 Jul 2018 13:11:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@free.fr>
cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [GIT PULL] timers for 4.19
In-Reply-To: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
Message-ID: <alpine.DEB.2.21.1807301310470.2518@nanos.tec.linutronix.de>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Daniel Lezcano wrote:
> 
> Hi Thomas, Ingo,
> 
> here are the changes for the timers for 4.19:
> 
>  - Add a less accurate but always-on clocksource for the sprd platform
> (Baoling Wang)
> 
>  - Add the system timer for the new mediatek platforms (Stanley Chu)
> 
>  - Change the cpumask to cpu_possible_mask (Sudeep Holla)
> 
> Thanks !
> 
>   -- Daniel
> 
> 
> The following changes since commit e5af5ff34cf037ac7bb70976161427dc40bf4a96:
> 
>   Merge tag 'fortglx/4.19/time-part2' of
> https://git.linaro.org/people/john.stultz/linux into timers/core
> (2018-07-20 06:43:05 +0200)
> 
> are available in the git repository at:
> 
>   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.19

 git://git.linaro.....

worked slightly better than the ssh URL.....

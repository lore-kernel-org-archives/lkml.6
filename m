Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE453C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654C020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756021AbeFOI1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:27:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755847AbeFOI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:27:32 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTk4q-0004dN-G5; Fri, 15 Jun 2018 10:27:24 +0200
Date:   Fri, 15 Jun 2018 10:27:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Daniel_D=EDaz?= <daniel.diaz@linaro.org>
cc:     x86@kernel.org, anders.roxell@linaro.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86: x86_64_defconfig: Enable KSM.
In-Reply-To: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
Message-ID: <alpine.DEB.2.21.1806151026330.2079@nanos.tec.linutronix.de>
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1187883524-1529051244=:2079"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1187883524-1529051244=:2079
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Jun 2018, Daniel Díaz wrote:

> As per the documentation, Kernel Samepage Merging (available
> since 2.6.32) is a memory-saving de-duplication feature,
> enabled by CONFIG_KSM=y and activated via sysfs. More
> information can be found here:
>   https://www.kernel.org/doc/Documentation/vm/ksm.txt
> 
> When enabled in the kernel, the default is to not do anything
> at all, until it is activated at run-time with:
>   echo 1 > /sys/kernel/mm/ksm/run

We all know that, but the above does not make an argument WHY this needs to
be enabled in defconfig.

Thanks,

	tglx
--8323329-1187883524-1529051244=:2079--

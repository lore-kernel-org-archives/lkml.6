Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F23C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF72082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBF72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeKXPCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 10:02:15 -0500
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:38424 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731111AbeKXPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 10:02:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 88CAB837F242;
        Sat, 24 Nov 2018 04:15:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jump19_8546e09f4072c
X-Filterd-Recvd-Size: 1494
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 24 Nov 2018 04:15:15 +0000 (UTC)
Message-ID: <b5dca55ca331311264b22ec7b1be6a4a52c77cc2.camel@perches.com>
Subject: Re: [tip:timers/core] time: Add SPDX license identifiers
From:   Joe Perches <joe@perches.com>
To:     broonie@kernel.org, nicolas.pitre@linaro.org,
        davidriley@chromium.org, kstewart@linuxfoundation.org,
        cminyard@mvista.com, john.stultz@linaro.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        pombredanne@nexb.com, ccross@android.com, richardcochran@gmail.com,
        mingo@kernel.org, rmk+kernel@armlinux.org.uk,
        linux-tip-commits@vger.kernel.org
Date:   Fri, 23 Nov 2018 20:15:14 -0800
In-Reply-To: <tip-35728b8209ee7d25b6241a56304ee926469bd154@git.kernel.org>
References: <20181031182252.879109557@linutronix.de>
         <tip-35728b8209ee7d25b6241a56304ee926469bd154@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 03:19 -0800, tip-bot for Thomas Gleixner wrote:
> The SPDX
> identifier is a legally binding shorthand, which can be used instead of the
> full boiler plate text.

Is the "legally binding shorthand" actually proven anywhere?
I am not aware of any case law for this.



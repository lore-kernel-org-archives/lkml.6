Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4948C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CA4218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548351757;
	bh=Ny57Pd+6hDS11hFAY+DHm8+kgWx38C3y5WyiA8xVhh4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=v5vbXWCOdYdUagHb6oWeCKnQMWYAFJpKPjUP9FmIV6BYVnn7HyPvpvpAZux/IfnJF
	 8v3V/IhtbgJ+zFi9MXG2FMPknQP6e70HS0aonNiCYmqxYlo8ymUhq9CWAQtGvC8VUg
	 2cJ92Hwusaf2ZesJnN8c5D7scALCP5UU4mNmbpeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfAXRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfAXRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:42:35 -0500
Received: from [10.84.151.11] (unknown [167.220.149.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468D821855;
        Thu, 24 Jan 2019 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548351755;
        bh=Ny57Pd+6hDS11hFAY+DHm8+kgWx38C3y5WyiA8xVhh4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kFPDH/W96Z3PIob5J/eCb/tF2izeAZAHaJDjhK5S7+Bd13bsMcFnJ+luoQdFFlrGx
         H0woERZA8tjsN9HJAYtTMwFHeHQcAKudzY0gWh6K3q1tmUI5NM/O9mYg4UCU/d5uui
         YhMFJg6nwJqNt0uotqGF2qRK3Y7tlaFDkdAibB2U=
Subject: Re: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if
 PCI is enabled
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20190121231958.28255-1-okaya@kernel.org>
 <20190121231958.28255-2-okaya@kernel.org>
 <37767989.Gns3VtERSa@aspire.rjw.lan>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <cd9774f9-ba35-23ae-7083-6645c7a526c7@kernel.org>
Date:   Thu, 24 Jan 2019 12:42:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <37767989.Gns3VtERSa@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 5:51 AM, Rafael J. Wysocki wrote:
>>
> Is anyone taking this or should I?
> 
> 
> 

This got applied:

https://git.kernel.org/tip/625210cfa6c0c26ea422f655bf68288176f174e6

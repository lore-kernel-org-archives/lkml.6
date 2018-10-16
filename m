Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB55720645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB55720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJQCZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:25:29 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:33966 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:25:28 -0400
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 1E50C416532B;
        Tue, 16 Oct 2018 20:33:43 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 605A9824041;
        Tue, 16 Oct 2018 20:33:42 +0200 (CEST)
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181016170515.447235311@linuxfoundation.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <e76f0204-fb8e-137f-200b-770972fd1553@applied-asynchrony.com>
Date:   Tue, 16 Oct 2018 20:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 19:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.15 release.

Gave this a try since I have r8169 NICs. Applied over .14 and now running
on three different machines. No observed regressions in dmesg or behaviour;
all smooth sailing.

cheers!
Holger

Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D621C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A220818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363A220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeKJU0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 15:26:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58413 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728876AbeKJU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 15:26:50 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47779668"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Nov 2018 18:42:17 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 643A24B714A9;
        Sat, 10 Nov 2018 18:42:17 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 10 Nov 2018 18:42:18 +0800
Subject: Re: [PATCH] x86/mkpiggy: Drop endianness transforming
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>
References: <20181109121929.11448-1-caoj.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1811091359310.1519@nanos.tec.linutronix.de>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <08b2f77c-c323-7f69-ccb0-f24c32dc0f88@cn.fujitsu.com>
Date:   Sat, 10 Nov 2018 18:39:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811091359310.1519@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 643A24B714A9.A6C02
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 9:00 PM, Thomas Gleixner wrote:
> Cao,
> 
> On Fri, 9 Nov 2018, Cao jin wrote:
> 
>> gzip file has 4-byte little-endian file size encoded at the end of file,
>> while all the other compressed kernel file has size_append operation in
>> the Makefile which also append the 4-byte little-endian file size. There
>> is no need to do endianness transforming by mkpiggy.
> 
> Did you test that on a BE host cross-compiling the kernel for x86?
> 

Oh, I don't know and never think of there is this kind of condition,
thanks for your info and sorry for the noise.

Sincerely,
Cao jin



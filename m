Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A26218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548351858;
	bh=nzcovYb6PHP11D0ouhUDzolyXsvJnwkorsRoNNivRuo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z2SUg8ZJVohZ3TSnON2fmh1PxDEWTSTpAkIpJbHYM+GCh1xPdsqVsiQNIc9NHRSWD
	 /cqPaKfSBmdiFEtp0SwoafIvy1TQEZsUjhwE7KiA/WdGVNVdKiQ/wGvHzlraubntgJ
	 gvNOlPFu8s1Amp+SGRD8OgR/q68aMbTrc6mb7Q14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfAXRoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfAXRoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:44:16 -0500
Received: from [10.84.151.11] (unknown [167.220.149.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64508218A6;
        Thu, 24 Jan 2019 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548351856;
        bh=nzcovYb6PHP11D0ouhUDzolyXsvJnwkorsRoNNivRuo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J/6HDS04QPUj29EwPA6vK7quboykiL7grfmTkjVriQwM6sbl7xyJVzdWv2u2uSKJp
         JfI6Zv9xSNg6vtgDzH3IdJTeipYgk2C9PCF1WuBPbnnWIE0Gl929Fo8hxqVSKMqwoo
         3LDEBIUf69DNy0q/9iab/8lnj1ojbFBocdAV+Hh4=
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning
 for ACPI_CMPC
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190121224644.26903-1-okaya@kernel.org>
 <3681650.SPxszaOeRQ@aspire.rjw.lan>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2157aaa0-cf23-cd4c-7ea2-ec03e86cbdc2@kernel.org>
Date:   Thu, 24 Jan 2019 12:44:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3681650.SPxszaOeRQ@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 5:52 AM, Rafael J. Wysocki wrote:
> Andy/Darren, these two seem to be for you, but I can take them too as
> related to ACPI tagentially, so please let me know.

I'll post V2 to fix a "fat-finger" in summary. I was hoping to receive a
feedback until now.

I'll get the V2 out.


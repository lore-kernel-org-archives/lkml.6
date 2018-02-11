Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeBKVfj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:35:39 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40136 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeBKVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:35:37 -0500
X-Google-Smtp-Source: AH8x225WSR8WB2cFkFCi/wxwQquSOrgZT3LxaCyF8Bw0uY/l/aQ7ANXx3pL/zbpMkM2OkoIRyTDdVA==
Date: Sun, 11 Feb 2018 22:35:34 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] platform/x86: fujitsu-laptop: Clean up constants
Message-ID: <20180211213534.GD1124@kmp-mobile.hq.kempniu.pl>
References: <20180211210727.12130-1-kernel@kempniu.pl>
 <20180211210727.12130-8-kernel@kempniu.pl>
 <628c2c03-c855-ed2a-b175-5238c561548e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <628c2c03-c855-ed2a-b175-5238c561548e@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> It looks like this driver needs to #include <linux/bitops.h>
> for use of BIT() macros.
> 
> See Documentation/process/submit-checklist.rst:
> 1) If you use a facility then #include the file that defines/declares
>    that facility.  Don't depend on other header files pulling in ones
>    that you use.
> 
> Some $ARCH may work without it while another one may not.

Noted, thanks!

-- 
Best regards,
Michał Kępień

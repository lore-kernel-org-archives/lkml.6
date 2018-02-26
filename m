Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeBZXIo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:08:44 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:47411 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeBZXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:08:40 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <f71f052e-fe62-aff9-35a8-dac1cb333575@robertabel.eu>
Date: Tue, 27 Feb 2018 00:08:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-1-rabel@robertabel.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20180226230839.12420.29205@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2018 00:54, Robert Abel wrote:> Robert Abel (4):
>   auxdisplay: charlcd: fix two-line command ^[[LN not marked as
>     processed
>   auxdisplay: charlcd: name x/y address struct
>   auxdisplay: charlcd: fix x/y address commands
>   auxdisplay: charlcd: make home command unshift display

So I think as it stands, only the first patch is being picked up, while
the other three will need rework, which is fine.

I think I'm going to wait a little while with the x/y fix until the
simple_strto* situation has settled.

For the home command basically only more comments in code should be
necessary.
More comments will also be good for the x/y issue once I change the
implementation.

Regards,

Robert

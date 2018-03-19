Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeCSJmq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:42:46 -0400
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:34732 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932351AbeCSJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:42:45 -0400
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
To: Martin Steigerwald <martin@lichtvoll.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <27165802.vQ9JbjrmvU@merkaba>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <a3af4fed-a728-5be2-2224-6a0573406c5b@leemhuis.info>
Date: Mon, 19 Mar 2018 10:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <27165802.vQ9JbjrmvU@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1521452565;1c873da3;
X-HE-SMSGID: 1exrJS-0001WP-47
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! On 11.03.2018 09:20, Martin Steigerwald wrote:
>
> Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
> with SMART checks occassionally failing like this:

Martin (or someone else): Could you gibe a status update? I have this
issue on my list or regressions, but it's hard to follow as two
different issues seem to be discussed. Or is it just one issue? Did the
patch/discussion that Bart pointed to help? Is the issue still showing
up in rc6?

Ciao, Thorsten

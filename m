Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDZDsm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:48:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54891 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751895AbeDZDsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:48:39 -0400
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org> <20180424154904.GC30619@thunk.org>
 <d251173a-d7c0-3f55-7c22-a100f6093176@molgen.mpg.de>
 <20180425074144.GA18803@thunk.org>
Cc: linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>
Message-ID: <4d707453-0771-2d1f-3ebb-0d19b85177a2@molgen.mpg.de>
Date: Thu, 26 Apr 2018 05:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425074144.GA18803@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Theodore,


Am 25.04.2018 um 09:41 schrieb Theodore Y. Ts'o:
> Does this help on your system?

Thank you, after figuring out how to apply the paste, yes it helped on 
my Lenovo X60.

> commit 4e00b339e264802851aff8e73cde7d24b57b18ce
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Wed Apr 25 01:12:32 2018 -0400
> 
>      random: rate limit unseeded randomness warnings
>      
>      On systems without sufficient boot randomness, no point spamming dmesg.

I guess this is a problem with old hardware?

[…]


Kind regards,

Pul

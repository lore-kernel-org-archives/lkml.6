Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756685AbeDZPRj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:17:39 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:40918 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeDZPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:17:38 -0400
X-Google-Smtp-Source: AB8JxZoesuK1eHVAL43I+fdf+tJUCLBsXLlriVbiMUvNLdd2iplFOdMDXVkyb9ditd4QGwUnCulQZg==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
From: Sultan Alsawaf <sultanxda@gmail.com>
Message-ID: <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
Date: Thu, 26 Apr 2018 08:17:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426073255.GH18803@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, can you let the boot hang for a while?  It should continue after
> a few minutes if you wait long enough, but wait a minute or two, then
> give it entropy so the boot can continue.  Then can you use
> "systemd-analyze blame" or "systemd-analyize critical-chain" and we
> can see what process was trying to get randomness during the boot
> startup and blocking waiting for the CRNG to be fully initialized.
>
> 	    	     	     	     - Ted

systemd-analyze blame: https://hastebin.com/ikipavevew.css
systemd-analyze critical-chain: https://hastebin.com/odoyuqeges.pl
dmesg: https://hastebin.com/waracebeja.vbs

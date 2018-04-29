Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeD2SbD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 14:31:03 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:38333 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeD2SbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 14:31:02 -0400
X-Google-Smtp-Source: AB8JxZrfT3wVSq2ojQoZPvNKiEN3MVf2qtyq7MsgP1RCku04i8gv1arFk5B8EvvSqcP5Esde0cWdGg==
Date: Sun, 29 Apr 2018 11:30:57 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429183057.kk666r4z5biamzvs@sultan-box>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427201036.GL5965@thunk.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd also like to add that my high-spec x86 laptop exhibits the same issue as
my Edgar Chromebook.

Here's my dmesg: https://hastebin.com/dofejolobi.go

The most interesting line:
[   90.811633] random: crng init done

I waited 90 seconds after boot to provide entropy myself, at which point crng
init completed. In other words, crng init only completed because I provided
the entropy by smashing the keyboard. I could've waited longer and crng init
wouldn't have completed without my input.

Mind you, this laptop has a 45W CPU, so power savings were definitely not
considered in its design. Do you have any machines that can provide enough
boot entropy to satisfy crng init without requiring user-provided entropy?

Sultan

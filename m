Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFCSuD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:50:03 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45441 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:50:02 -0400
X-Google-Smtp-Source: ADUXVKLDjDypngsLZVk3XO2IlXxfbTnxAdjhCTJUZDNF5G3Dh4CwRBLqjEf1Pyh3AkTH6yohZjXwAA==
Date: Sun, 3 Jun 2018 15:49:56 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180603184955.zrowxp4y3ij66y5n@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for your report.

On Sun, Jun 03, 2018 at 06:52:19PM +0300, Anatoly Trosinenko wrote:
> How to reproduce:
> 1. Take kernel source v4.17-rc7
> 2. Compile it with the config attached
> 3. Unpack and mount the attached FS image as hfsplus.

We are aware of this issue and I've sent some patches [1][2]. It's hard
to get reviewers interested in hfsplus, so I don't know when it will be
fixed.

[1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
[2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html

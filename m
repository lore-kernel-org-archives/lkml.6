Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeFCTG1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 15:06:27 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44871 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFCTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 15:06:26 -0400
X-Google-Smtp-Source: ADUXVKIaA0huotosVwGqfv6IPPuvYrNIr5rW3KgsW/ClMhnawqPR+s0cj/hiJCNyrNZJIoOyN09qpiKX5yiiAWhicWo=
MIME-Version: 1.0
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
In-Reply-To: <20180603184955.zrowxp4y3ij66y5n@eaf>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sun, 3 Jun 2018 22:06:14 +0300
Message-ID: <CAE5jQCfWXw5Ls48hS9a6jQ-oSza-2htfxWqLKCbQ3OpP0oLWOw@mail.gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
To: "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w53J6Wsg011627

Hi, thank you! Excuse me for disturbance.
вс, 3 июн. 2018 г. в 21:50, Ernesto A. Fernández
<ernesto.mnd.fernandez@gmail.com>:
>
> Hi, thank you for your report.
>
> On Sun, Jun 03, 2018 at 06:52:19PM +0300, Anatoly Trosinenko wrote:
> > How to reproduce:
> > 1. Take kernel source v4.17-rc7
> > 2. Compile it with the config attached
> > 3. Unpack and mount the attached FS image as hfsplus.
>
> We are aware of this issue and I've sent some patches [1][2]. It's hard
> to get reviewers interested in hfsplus, so I don't know when it will be
> fixed.
>
> [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html



-- 
С уважением,
Анатолий Тросиненко
e-mail: anatoly.trosinenko@gmail.com

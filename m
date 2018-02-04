Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeBDOZ4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 09:25:56 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39989 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 09:25:48 -0500
X-Google-Smtp-Source: AH8x225aLhAsa2xcIrYSgKDgmjd2BxXagaSjwl2nuHcPW+d9u6RvAX3JPMMNXy6pnVLvpYfBoBKUYObj96Hi75hb1pQ=
MIME-Version: 1.0
In-Reply-To: <20180204121530.sl3h77mxbwusp2ul@pali>
References: <20180203162021.GA4571@localhost.localdomain> <e489f5ee-34e5-4777-afe7-38d31d2ad3fd@Dell.com>
 <20180204092333.GA2010@localhost.localdomain> <20180204121530.sl3h77mxbwusp2ul@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 4 Feb 2018 16:25:47 +0200
Message-ID: <CAHp75VeBoqp2ohQ7+o9oD1Wv5p6qFjFMwJCF_oiOMx5wpQ2Bjg@mail.gmail.com>
Subject: Re: PROBLEM: NULL pointer dereference in dell_set_arguments() in 4.15
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Alexander Sergeyev <sergeev917@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w14EQ2jC017597

On Sun, Feb 4, 2018 at 2:15 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Sunday 04 February 2018 12:23:33 Alexander Sergeyev wrote:

>> Is there any estimates on when the patch will be merged into mainline? I
>> want to put something into my distribution bug tracker, but it's unlikely
>> they will use this patch before its stabilization.
>
> It should go in next round of merging into linus tree and after that
> with proper commit message tags it should included in next stable
> versions.

Next week in Linus' tree, after that through couple more weeks in
stable releases.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeB0QEU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:04:20 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39356 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeB0QEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:04:14 -0500
X-Google-Smtp-Source: AG47ELuvbRwp0ntLZr6ECiIlpov2S2NTnkGwbBeNjZrw1KNHxNur7x5lVZwp/ahsDEvTkh9ejwVMee/2NGnP75DB0lw=
MIME-Version: 1.0
In-Reply-To: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 18:04:12 +0200
Message-ID: <CAHp75VfS4vif1_S1Z=z2jAZfERmsiqG0h0j5k6zrmjiQwPGekA@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/x86: dell-smbios: Correct some style warnings
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: Darren Hart <dvhart@infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 5:56 PM, Mario Limonciello
<mario.limonciello@dell.com> wrote:

>         /* 4 bytes of table header, plus 7 bytes of Dell header, plus at least
> -          6 bytes of entry */
> +        * 6 bytes of entry
> +        */

I would prefer not to mix with net style, since you are fixing this, perhaps

/*
 * 4 ...
 * 6 ...
 */

?

-- 
With Best Regards,
Andy Shevchenko

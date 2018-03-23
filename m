Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCWRLP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:11:15 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46472 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeCWRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:11:12 -0400
X-Google-Smtp-Source: AG47ELtsj/bMquBcyVBEcf7ZiSXT2lI18ORD6ZH3SCfmZc/NYTpqY7TqIhfk55F7M1H6oI+5Spv88As9K3IaL6mndo8=
MIME-Version: 1.0
In-Reply-To: <20180319144101.GH2943022@devbig577.frc2.facebook.com>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058> <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
 <20180319144101.GH2943022@devbig577.frc2.facebook.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 23 Mar 2018 10:10:30 -0700
Message-ID: <CAOFm3uE1UxeW-dPyFEzr5BiaWp6wLiJ4Z8X3qcH8Crr=b4nLWA@mail.gmail.com>
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun,

On Mon, Mar 19, 2018 at 7:41 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Sat, Mar 17, 2018 at 10:24:18PM -0700, Philippe Ombredanne wrote:
>> > v2:
>> > - clarify license version (it should be GPL 2.0)
>> > - use SPDX header
>>
>> For the use of SPDX ids, you have my ack: (I am not qualified for the rest)
>>
>> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
>
> I don't think it's a good idea to add this acked-by when it's purely
> based on a single liner license tag.  I understand that you want to
> encourage use of the new tags but this can be misleading and it'd be
> great if you reconsider sending out acks like this.
>
> Thanks.


You have a good point. I find it confusing myself.
Please, remove this ack!

-- 
Cordially
Philippe Ombredanne

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031620AbeBNVjS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:39:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54289 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031404AbeBNVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:39:17 -0500
X-Google-Smtp-Source: AH8x225KC7OIjbw0IJYK+2RTcUSUgY2yKWEO1FF/3ijN0ktpY+Qnjzk+ykRMH5CT46esX65TO/ml+AknGMY79hiRSnY=
MIME-Version: 1.0
In-Reply-To: <20180214165135.GC3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-5-alexandre.belloni@free-electrons.com> <20180214165135.GC3986@saruman>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 14 Feb 2018 22:38:35 +0100
Message-ID: <CAOFm3uHTMbr=uTHr73JMFkscb86NMgucuopeQt_5AiOUiQZu=g@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] MIPS: mscc: Add initial support for Microsemi MIPS SoCs
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre,

On Wed, Feb 14, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
> On Tue, Jan 16, 2018 at 11:12:36AM +0100, Alexandre Belloni wrote:

...

>> diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
>> new file mode 100644
>> index 000000000000..9ae874c8f136
>> --- /dev/null
>> +++ b/arch/mips/mscc/Platform
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +#
>> +# Microsemi MIPS SoC support
>> +#
>> +# License: Dual MIT/GPL

IMHO you should remove this line as it exactly repeats the
SPDX-License-Identifier: (GPL-2.0 OR MIT) line in a less clear and
precise way.
The whole purpose of the SPDX things is to make licensing eventually
as clear ass possible
Thanks!
-- 
Cordially
Philippe Ombredanne

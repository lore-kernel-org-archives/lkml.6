Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCNXee (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:34:34 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:42308 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCNXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:34:32 -0400
X-Google-Smtp-Source: AG47ELu3bUMvcIEKbz+WzeyYauQ33CcMPOtcqBrDwD9YCO3zeb2MYpx8weKdeU3Sf51XJ+Gox8ZOPGadmVyqiYh3N1E=
MIME-Version: 1.0
In-Reply-To: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 16:34:31 -0700
X-Google-Sender-Auth: JQvghqpjOkHU7yMkR09a63Daf14
Message-ID: <CA+55aFzgOZdW0c=L9MWGqUt1htiXZ2E2UVmc8HOrvGr3kqr4OQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, Daniel Vacek <neelx@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:29 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.

Applied directly, since we already had two confirmations of it fixing
things for people.

Thanks,

                Linus

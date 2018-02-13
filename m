Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeBMIIV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:08:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39491 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933539AbeBMIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:08:19 -0500
X-Google-Smtp-Source: AH8x224o74uE8XTRPgfIxatYhdBgKjNiPBQsrzUZygRIyWOJUww/CkM9cUmCxGKxScNL4+M59wxWAA==
Date: Tue, 13 Feb 2018 11:08:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrei Vagin <avagin@virtuozzo.com>
Cc: tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com, linux-tip-commits@vger.kernel.org,
        tglx@linutronix.de, willy@infradead.org, gorcunov@openvz.org,
        bp@suse.de, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213065155.GA14087@outlook.office365.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
> Hi Kirill,
> 
> Something is wrong in this patch.

Was it bisected to exactly this patch? Is the previous one fine?

> We regularly run CRIU tests on linux-next, and yesterday I found that a
> kernel didn't boot. We run this tests in Travis-CI, and we don't have
> access to kernel logs. I tried to reproduce the problem localy, but I
> failed.

Do you know anything about host kernel which handles kexec?

-- 
 Kirill A. Shutemov

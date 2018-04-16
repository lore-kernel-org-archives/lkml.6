Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeDQDBA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:01:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43007 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDQDA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:00:59 -0400
X-Google-Smtp-Source: AIpwx49SMw4Fh7JYWpNhNh4GLxiIX6Puy0xiIRovdFzB2mm4yyzDkeSgCOGzcNgLvOAwfE7gsUaIHQ==
Date: Mon, 16 Apr 2018 21:16:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Greg Thelen <gthelen@google.com>
Subject: Re: instant reboot caused by 194a9749c73d650c0
Message-ID: <20180416181642.vuicay5ng2ieuf7h@node.shutemov.name>
References: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
 <20180416060709.mnzk7fb5y45dnpmg@gmail.com>
 <20180416091514.wqig3l4lrc72tyrs@node.shutemov.name>
 <4df21e12-709b-891f-13a8-cd19e92d44f5@gmail.com>
 <20180416173752.jah2mritvhket7ji@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416173752.jah2mritvhket7ji@node.shutemov.name>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 08:37:52PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 16, 2018 at 08:36:57AM -0700, Eric Dumazet wrote:
> > 
> > 
> > On 04/16/2018 02:15 AM, Kirill A. Shutemov wrote:
> > In the mean time, Greg told me that using gcc-4.9 instead of our old
> > gcc-4.7 based toolchain was working better.
> 
> Hm. Are you saing that switching from gcc-4.7 to gcc-4.9 fixed the issue
> for you? That's worth investigating.

Checked kernel build with gcc-4.6 and it boots fine...

-- 
 Kirill A. Shutemov

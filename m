Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeAaSbH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:31:07 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40567 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeAaSbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:31:05 -0500
X-Google-Smtp-Source: AH8x225CDcYjomx5OHwEOrSPUcDMijkTpNvHtIqogAXI7kCLL67qf0syZUvXkukGnKg6ltaMBtxqhbEyx8DIpWIqTbo=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1801311844121.9911@nanos.tec.linutronix.de>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
 <1516352307-20123-7-git-send-email-rajneesh.bhardwaj@intel.com>
 <CAHp75VcsMzTtn-TD32Jyh6pennLWLjEuiAi_-LJMowENv=P2-Q@mail.gmail.com>
 <20180131172747.GA9877@raj-desk2.iind.intel.com> <alpine.DEB.2.21.1801311844121.9911@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 20:31:04 +0200
Message-ID: <CAHp75VdEeKgkWU8XHBoNeORu6EBrWyOEBzqA6=oR0DtP14BD6Q@mail.gmail.com>
Subject: Re: [Patch v1 6/8] x86/cpu: Add Cannonlake to Intel family
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 7:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:

> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you, Thomas!

Rajneesh, please, rebase the not-yet-applied patches on top of my
testing branch, add tags (Rafael's and Thomas') and resend.

-- 
With Best Regards,
Andy Shevchenko

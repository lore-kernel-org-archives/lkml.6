Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeDWVRq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:17:46 -0400
Received: from mx.exactcode.de ([144.76.154.42]:59116 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbeDWVRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:17:45 -0400
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
In-Reply-To: <20180322123557.4eu4huhldqn6bid6@angband.pl>
Date: Mon, 23 Apr 2018 23:17:13 +0200
Cc: Nick Terrell <terrelln@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Message-Id: <B871331D-D4B9-4D65-9E47-F27366E9258F@exactcode.com>
References: <20180322012943.4145794-1-terrelln@fb.com> <C0384AAE-FF89-4BAA-8EFC-FB3B0A8F02AB@exactcode.com> <20180322123557.4eu4huhldqn6bid6@angband.pl>
To: Adam Borowski <kilobyte@angband.pl>
X-Mailer: Apple Mail (2.1878.6)
X-Spam-Score: -0.5 (/)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NLHrQK008852

Hi,

On 22 Mar 2018, at 13:35, Adam Borowski <kilobyte@angband.pl> wrote:

> On Thu, Mar 22, 2018 at 12:09:45PM +0100, René Rebe wrote:
>> Should this currently just work without any arch change on e.g.
>> ppc64, sparc64 et al.? I could do a test build and boot if that is
>> of any value, ...
> 
> Initrd: no reason it wouldn't work, although for anything related to the
> boot process testing is a very good idea.  If you test, you'd really want to
> apply that printk patch I posted, it's too easy to accidentally get a silent
> fallback to gzip or uncompressed.  I wonder, perhaps such a printk could be
> permanently added, at a low message priority?

zstd initrd worked on sparc64/sun4u - Ultra 30:

	https://www.youtube.com/watch?v=10q2OxHAzQ4

Any chance we could get this initrd zstd support upstream?

> Kernel itself: needs per-arch porting, but it's not advertised in kconfig
> outside x86 so that's not a problem.  
> 
> If you are knowledgeful about bootloaders on ppc64, sparc64, etc, such
> information would be great.


-- 
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de

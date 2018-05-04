Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEDK0L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:26:11 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54307 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:26:09 -0400
X-Google-Smtp-Source: AB8JxZq4DXWDCmu9PMzTA+5fKTihwLLVJh1gGkbIoz93Uv3kHqbr8Y/kqI/mhcyeEbBl9zv/L6AWIA==
Date: Fri, 4 May 2018 12:26:01 +0200
From: Robert Richter <rric@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504102600.GD4493@rric.localdomain>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.18 10:54:32, Matt Redfearn wrote:
> perf is available for MIPS and supports many more CPU types than oprofile.
> oprofile userspace seemingly has been broken since 1.0.0 - removing oprofile
> support from the MIPS kernel would not break it more thatn it already is,

What do you mean with "oprofile is broken"? It looks like you modified
Kconfig to enable oprofile and perf in parallel, which is not intended
to work. Have you tried a kernel with oprofile disabled and perf
enabled?

As said, oprofile version 0.9.x is still available for cpus that do
not support perf. What is the breakage?

Thanks,

-Robert

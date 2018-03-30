Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeC3KlI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:41:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40728 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC3KlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:41:06 -0400
X-Google-Smtp-Source: AIpwx48PT1V6z1K7wm4ol32cYp5St91sr9AygGrr7nKwIFfYxEdmSDZqH8rT7MUFPxbCq2qag/TwGg==
Date: Fri, 30 Mar 2018 12:41:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com
Subject: Re: [PATCH 0/2] MCA support on Centaur CPU
Message-ID: <20180330104102.df7o4xedgswxy5gk@gmail.com>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Wang <davidwang@zhaoxin.com> wrote:

> This patch set is to provide MCA support on new Centaur CPU. 
> 
> The first patch is used to tell the kernel that newer Centaur CPU support 
> MCE broadcasting.
> 
> The second patch is used to tell the kernel that newer Centaur CPU support 
> CMCI. 
> 
> David Wang (2):
>   x86/mce: new centaur CPUs support MCE broadcasting
>   x86/mce: add CMCI support for centaur CPUs
> 
>  arch/x86/kernel/cpu/mcheck/mce.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Please capitalize 'Centaur' properly in the changelogs and in comments.

Thanks,

	Ingo

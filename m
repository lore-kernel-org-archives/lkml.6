Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDQSkr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:40:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37908 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:40:46 -0400
X-Google-Smtp-Source: AIpwx486BMPjkBvHfbHQw3n+BNy+3REewyE/pyxqt6GOUFBYno8QJSuQlpioPf2VmuU2Eawmnlismw==
Date: Tue, 17 Apr 2018 21:40:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [proc]  89d98ff979:
 kernel_selftests.proc.proc-loadavg-001.fail
Message-ID: <20180417184042.GA20340@avx2>
References: <20180417025426.GB17434@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417025426.GB17434@yexl-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:54:26AM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 89d98ff9795717225187dd20c5c557ef16c37372 ("proc: add selftest for last field of /proc/loadavg")

Fixed by https://marc.info/?l=linux-kernel&m=152364205819862&w=4
[PATCH] proc: fix /proc/loadavg regression

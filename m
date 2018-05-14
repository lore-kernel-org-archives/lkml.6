Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeENIM6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:12:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43768 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeENIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:12:54 -0400
X-Google-Smtp-Source: AB8JxZqQFqP7nozFGu8SnBuX8uhS7/N8Bv8yI5bLZ0fDabkcnz+4uCIMl7J/gjga5y+ZGkph/MJTWA==
Date: Mon, 14 May 2018 01:02:24 -0700
From: Olof Johansson <olof@lixom.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee driver fixes for v4.17
Message-ID: <20180514080224.zy7s4f5d2uiibwce@localhost>
References: <20180507124731.GA21011@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507124731.GA21011@jax.urgonet>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:47:31PM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these tee driver fixes. Of particular interest is a fix for a
> use-after-free issue. There's also a fix making sure that memory references
> are kept within the used shm object.
> 
> Thanks,
> Jens
> 
> The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:
> 
>   Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-drv-fixes-for-4.17
> 
> for you to fetch changes up to ab9d3db5b320a052452b9cd035599ee3c84bbee9:
> 
>   tee: check shm references are consistent in offset/size (2018-05-07 11:51:03 +0200)
> 
> ----------------------------------------------------------------
> Small fixes for tee subsystem
> 
> * Fixes for use-after-free via temporarily dropped reference
> * Checks that passed shm references are consistent in offset/size
>   with regards to the shm object

Merged, thanks!


-Olof

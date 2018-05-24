Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034579AbeEXTey (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:34:54 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:33633 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034514AbeEXTex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:34:53 -0400
Date: Thu, 24 May 2018 22:34:49 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Ramon Fried <ramon.fried@gmail.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: uImage target support on arm64
Message-ID: <20180524193449.jql27apudwaevwpf@tarshish>
References: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ramon,

On Thu, May 24, 2018 at 10:05:15PM +0300, Ramon Fried wrote:
> I've noticed that it's not supported.
> Is it on purpose ?

Yes. The 32bit load address in the uImage header in pretty limited when 
applied to 64bit ARM64. Even for ARM zImage is the preferred kernel format for 
quite some time now, since it allows flexible load address, as well as 
multi-platform kernels.

> If not I'll be happy to add support for: make uImage
> for arm64 targets.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xr9NkUOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 097CC60763
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933029AbeFFQcj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:32:39 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46841 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeFFQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:32:37 -0400
X-Google-Smtp-Source: ADUXVKKS1jwJs4QF5/yJ+ToINPO1mk+p8tLb81HZqOuujWN0LZG9qFyFlceRI4vFuoEJXHQaqeDp8DsPXlzk6aoYRIU=
MIME-Version: 1.0
In-Reply-To: <20180606125938.12986-1-abrodkin@synopsys.com>
References: <20180606125938.12986-1-abrodkin@synopsys.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 6 Jun 2018 09:32:35 -0700
Message-ID: <CAOi56cVxHKh4V1i8W8wS+n3E88UbzBiCo0PozhCeoN3YEnVmBw@mail.gmail.com>
Subject: Re: [PATCH] ARC: Remove CONFIG_INITRAMFS_SOURCE from defconfigs
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 5:59 AM, Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> We used to have pre-set CONFIG_INITRAMFS_SOURCE with local path
> to intramfs in ARC defconfigs. This was quite convenient for
> in-house development but not that convenient for newcomers
> who obviusly don't have folders like "arc_initramfs" next to
> the Linux source tree. Which leads to quite surprising failure
> of defconfig building:
> ------------------------------->8-----------------------------
>   ../scripts/gen_initramfs_list.sh: Cannot open '../../arc_initramfs_hs/'
> ../usr/Makefile:57: recipe for target 'usr/initramfs_data.cpio.gz' failed
> make[2]: *** [usr/initramfs_data.cpio.gz] Error 1
> ------------------------------->8-----------------------------
>
> So now when more and more people start to deal with our defconfigs
> let's make their life easier with removal of CONFIG_INITRAMFS_SOURCE.
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

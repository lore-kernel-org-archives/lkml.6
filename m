Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C552214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C552214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeHVMXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:23:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeHVMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:23:21 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 46008C93;
        Wed, 22 Aug 2018 08:59:22 +0000 (UTC)
Date:   Wed, 22 Aug 2018 10:59:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Meng Xu <mengxu.gatech@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Mike Frysinger <vapier@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] vt: Remove vc_panic_force_write
Message-ID: <20180822085919.GA32014@kroah.com>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180822085405.10787-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822085405.10787-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:54:03AM +0200, Daniel Vetter wrote:
> It was only used by the panic support in fbcon, which is now gone.
> Remove this now dead code too.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Meng Xu <mengxu.gatech@gmail.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Thomas Meyer <thomas@m3y3r.de>
> Cc: Mike Frysinger <vapier@chromium.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

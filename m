Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CE4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EAA20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EAA20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeFRLVk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:21:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934634AbeFRLVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:21:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB937CD3;
        Mon, 18 Jun 2018 11:21:36 +0000 (UTC)
Date:   Mon, 18 Jun 2018 13:21:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roman Sommer <roman.sommer@fau.de>
Cc:     linux-kernel@i4.cs.fau.de, Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Hans =?iso-8859-1?B?UC4gTfZsbGVy?= Ebner <hmoller@uc.cl>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Fabi=E1n?= Inostroza <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sound/line6: checkpatch: fix block comment style
Message-ID: <20180618112134.GA4289@kroah.com>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:29:37PM +0200, Roman Sommer wrote:
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
> CC: Kees Cook <keescook@chromium.org>
> CC: Kate Stewart <kstewart@linuxfoundation.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
> CC: Bhumika Goyal <bhumirks@gmail.com>
> CC: Philippe Ombredanne <pombredanne@nexb.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: alsa-devel@alsa-project.org
> CC: linux-kernel@vger.kernel.org
> 
> This patch fixed the style of multiline comments in sound/usb/line6.

Why is all of those cc: lines in the changelog body?

Very odd...

greg k-h

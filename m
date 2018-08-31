Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE826C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C4F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeHaTCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:02:35 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:28694 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHaTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:02:35 -0400
Received: from belgarion ([90.89.234.36])
        by mwinf5d40 with ME
        id Vqud1y00q0nnJME03que5a; Fri, 31 Aug 2018 16:54:41 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 31 Aug 2018 16:54:41 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Rob Herring <robh+dt@kernel.org>, kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: pxa: add mioa701 board description
References: <20180830195941.6118-1-robert.jarzmik@free.fr>
        <201808311515.Fq0HyEql%fengguang.wu@intel.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 31 Aug 2018 16:54:37 +0200
In-Reply-To: <201808311515.Fq0HyEql%fengguang.wu@intel.com> (kbuild test
        robot's message of "Fri, 31 Aug 2018 15:45:18 +0800")
Message-ID: <878t4m7fiq.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Hi Robert,
>
> I love your patch! Yet something to improve:
This is because you are missing at least this patch submitted earlier :
 - [PATCH] ARM: dts: pxa: add pincontrol helpers

You're also missing the previous patches in the pxa/dt tree, which are already
on the trampoline for linux-next :
 - git fetch github.com:rjarzmik/linux.git pxa/dt

Cheers.

--
Robert

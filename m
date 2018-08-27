Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36C0208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="cAIXhwli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36C0208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeH0Pgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:36:51 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.237]:38276 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0Pgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:36:51 -0400
X-Interia-R: Interia
X-Interia-R-IP: 103.217.167.198
X-Interia-R-Helo: <[192.168.1.197]>
Received: from [192.168.1.197] (unknown [103.217.167.198])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by int.pl (INTERIA.PL) with ESMTPSA;
        Mon, 27 Aug 2018 13:50:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] perf/x86/intel: Add support for MISPREDICT bit on Knights Landing cpus
From:   Jacek Tomaka <jacek.tomaka@poczta.fm>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <alpine.DEB.2.21.1808021206090.2037@nanos.tec.linutronix.de>
Date:   Mon, 27 Aug 2018 19:50:08 +0800
Cc:     Jacek Tomaka <jacekt@dugeo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E2734EED-2D55-473D-BE9C-BBF9D1C7D1F5@poczta.fm>
References: <20180802013830.10600-1-jacekt@dugeo.com> <alpine.DEB.2.21.1808021206090.2037@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1535370628;
        bh=tO6UV9RfbtvT0dbiKbMkDQXjYmzlGpNLDdtuF09rb+E=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Content-Type:
         Mime-Version:Subject:From:X-Mailer:In-Reply-To:Date:Cc:
         Content-Transfer-Encoding:Message-Id:References:To:
         X-Interia-Antivirus;
        b=cAIXhwliephnfVG0GtDYufX9+hZBdMxJJk1rIB5ck3kQ23+JLXBNPPITOLYnI16VF
         HwWp+BupOLMea8u/8z0NyqY6Knpd7imfxkJLllkYrNYcbZs2p8gWzt/Eey96T4VFvM
         mFJsfCX7FcP8jtrMa9QNVVSscWmXBWD9FurVYV6Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 2 Aug 2018, at 6:07 pm, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> The actiual purpose of sending V4 which is identical to V3 is?
> 
>> 
>> Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
>> ---

Yes, thanks. I missed it initially, sorry.

> It's good practice to add a
> 
> V3 -> V4: changed foo
> V2 -> V3: fixed bla
> ...
> 
> section to patches which have more than one version.

Sure. Would you like me to send it for this patch as well? 

Regards.
Jacek Tomaka

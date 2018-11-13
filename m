Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A543FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A4C223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A4C223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeKNFO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:14:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNFO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:14:57 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H5LXv0PUk08z; Tue, 13 Nov 2018 20:15:28 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 093831EC02D1;
        Tue, 13 Nov 2018 20:15:27 +0100 (CET)
Date:   Tue, 13 Nov 2018 20:15:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ernst, Justin" <justin.ernst@hpe.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Message-ID: <20181113191522.GN10502@zn.tnic>
References: <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic>
 <20180927221054.580220e5@coco.lan>
 <20181001124754.GD7269@zn.tnic>
 <20181001224313.GA9487@agluck-desk>
 <20181001222257.45e4fd59@coco.lan>
 <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
 <20181002162608.GC29601@zn.tnic>
 <20181106144535.GI13712@zn.tnic>
 <AT5PR8401MB0371BD98A030E08B1A1833A787C20@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB0371BD98A030E08B1A1833A787C20@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 07:09:24PM +0000, Ernst, Justin wrote:
> Looks good on a 32 socket system. All 64 memory controllers show up
> and I'm able to see the same sysfs diff. Thanks

Thanks for testing, much appreciated!

I'm queuing the stuff for 4.21.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

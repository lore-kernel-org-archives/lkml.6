Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535C82086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJKOQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:16:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43699 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeJKOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:16:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id w85so7495985vsa.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNVDOR2WMDgzy5v3owX2nJuKKP+2Skm+h+VMzTQ8xHg=;
        b=G9JkWtnzVfwaqq+7eCzHyjMnV4tbFt3m3xSo3XyjixVMEL2ButMq0Eaf3J3ghqSepY
         q9ddgR2tHKI75xxxdvh6wHBOUrAlPM0IehcMuMxLLQI2WoAZ487oPOu+ZXk8rdcG7Z16
         lTd+H7kHlmwymV1OP6bO1AJaEWaKjlwcDSjyTLeYOBRmRY/o7M0io+NYIrqLKkTmwlhu
         etdwZnsY+/Y3T18EtHpjj9AQ0xVxhaHj+mNd5uFtkKVNFI9YoSl2OfLJm57oJBSGU+nA
         R9GKdcvbEHr/AGB86de57jrAgyvzCeTLWelurBsowAjGu8lDKc5fK8dg3tFM0ayWLpD/
         PLKg==
X-Gm-Message-State: ABuFfoggFeCeAR4DGowjkDvkC+QbMcqfSfSbuWk1k8wxGQTIHdzCvl5C
        0MtqI6xgnksTpQGE0t1XeV/GFB2dETUzRF/oymIg2ayk
X-Google-Smtp-Source: ACcGV62opUb1SaLn3iHCfyVj6dFO27lx5d7Xb0txLe6JWP/njIPzW/gC/lITc2350k0vVpPFtNHs5SHmjrMjn1ERZ54=
X-Received: by 2002:a67:843:: with SMTP id 64mr139505vsi.166.1539240633399;
 Wed, 10 Oct 2018 23:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <1539202053.12644.8.camel@HansenPartnership.com>
 <1539202230.12644.12.camel@HansenPartnership.com> <20181010211313.5a63ce6f@alans-desktop>
In-Reply-To: <20181010211313.5a63ce6f@alans-desktop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 08:50:20 +0200
Message-ID: <CAMuHMdVFpaJf-omEXUGjBv6E_4aXoXWT0QRQ138A+9Zcjv97kQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] code-of-conduct: Add back the TAB as the central
 reporting point
To:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:14 PM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 10 Oct 2018 13:10:30 -0700
> > +appropriate to the circumstances. The TAB is obligated to maintain
> > +confidentiality with regard to the reporter of an incident.
>
> I would add (except where required by law.)

With the above change:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

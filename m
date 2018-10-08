Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94453C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C75620C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C75620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJHW4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:56:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38591 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJHW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:56:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id a202so8479694vsd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGNJIyThTLNCK6nIqJYwzOR6aOw50l02eskV1BNpvu4=;
        b=mkXNW6H+9E0joaxT3LybB/JBwf1zQLVUIy7pmzaIsrr/gp/3WVvlDcxSWRgOv+tQn6
         q7mGkQDJKSXkyqRhDV+dhdWt81uCJeDXzEguLXEWGG8xhZPKI67x3plIAKt+bKXLNY/r
         b/YmMspV8Atq7smj0EPXXB/QdfOgDsZKuSoW50HA3HIewDyo/5MCRrVeEpJlplmzvZTK
         g7ynmv/OpQB/dtuxt5FWk0522rYgQ2GHS/BRoKEG/B/MUZwIAA5lHoabwNNlucJgQxGa
         +KwgCiMoxUGLXeCr4oTgJJlvziaDuZM2UwBJN10uAvCVRTy0d5SKW789tRYIHPHA6aub
         X6Gw==
X-Gm-Message-State: ABuFfogrFqB3jceuPi1kL8+hW06tdW4IpU6PCSZ/DOIg1cIaglQ9XtDa
        ZLPZis1R1Vxid2xM+ru8RtI/91l8h+HZpOlN3QiCY0CY
X-Google-Smtp-Source: ACcGV60R5Qb14YfXWhq8cfVxahH+m+lu4xzEkxNl/RiT/1MxSNIF4MTgHsn5akSHotGvRpVm6dZRSGlwkZEvwUguo0I=
X-Received: by 2002:a67:e015:: with SMTP id c21mr8162338vsl.63.1539013431899;
 Mon, 08 Oct 2018 08:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181007085102.17795-1-geert@linux-m68k.org> <20181007113514.GA21217@localhost>
 <1814283.64diKEr4zR@avalon> <20181008022931.GB30346@localhost>
 <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com> <CAMuHMdVmz-ZF+ypp4WEkW6txxjw66DTb5PRsSGPsUfBqT+NbMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVmz-ZF+ypp4WEkW6txxjw66DTb5PRsSGPsUfBqT+NbMQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 17:43:39 +0200
Message-ID: <CAMuHMdUckOoFTMN9jH1NPWNcNm0o62w7PtJGF7sa37_1_kceKg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> FTR, I've submitted my patch earlier today, too:
> https://github.com/ContributorCovenant/contributor_covenant/issues/610

Will be clarified in the (external-to-Linux) FAQ.

Quoting Coraline: "However, any adopting project is free to modify the document
according to the license."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

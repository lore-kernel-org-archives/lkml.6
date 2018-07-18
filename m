Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E114ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F9F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F9F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGRWRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:17:11 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35382 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeGRWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:17:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id u21-v6so3228759qku.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7v4bgK8BckOJjU8PQx8kGdd6qOsRjoEbBC55T6JZl+I=;
        b=bGPEyGQNzF/lfma0TXDyh4ZFlb7UomO09UnWPNtIM8m7pIIPZbRaG0oynWeUktufYR
         CxNZC48ca1R0u//0KTW05dal/BzUXUTlY/38aN6eCjYkEleHjUfv212bLa0PU+dmlOx8
         gfZQeQicTYepggaSxlwjPi1P+5Kkrz8RaxPFPkyEezJTlC2mtqljZ79WJKgRXsxcmuDF
         uSVJdofNMR3UnzivOdeXykXGp0h0DE9h6InNIbAjg2LVzQizG0MINwxxlu/d5dxLyrNE
         wAiGfa14P6/aGXUmztw+wcBeYBciEfIILjhVQfViy2R5oXAJeQ2plmSO+fIaX2z0OsP3
         YuVQ==
X-Gm-Message-State: AOUpUlEwid1VIM9XElxUzLi/71eY1AayUFIty03wIBIGvP4zo+Ne9TOf
        nxvbEhM4nFPrees4GCMfCW5Psw==
X-Google-Smtp-Source: AAOMgpf3ZzfKRXOXhycGLcMwWZ6ajxNuJfB/FfNAJwHPqMIyheK/s7lSwyf+RJLlUbsEJSXe9K08bg==
X-Received: by 2002:a37:ab14:: with SMTP id u20-v6mr6828756qke.120.1531949841943;
        Wed, 18 Jul 2018 14:37:21 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 25-v6sm4376520qtx.91.2018.07.18.14.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:37:21 -0700 (PDT)
Message-ID: <da9a928ea3bd4ff2134bfc28447ef757232eabaa.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Fix bogus indenting in
 nouveau_hwmon.c
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Jul 2018 17:37:20 -0400
In-Reply-To: <CACO55tt5e6PrvbfZUzQNb0T1o8twRfaFewt6tnjUW0DQYYXK-Q@mail.gmail.com>
References: <20180717000758.8770-1-lyude@redhat.com>
         <CACO55tt5e6PrvbfZUzQNb0T1o8twRfaFewt6tnjUW0DQYYXK-Q@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that is an issue with your client? It seems to come up fine if I apply
it locally and look at it with gvim

On Tue, 2018-07-17 at 12:25 +0200, Karol Herbst wrote:
> isn't there like 1 space missing for each change? Or maybe my client
> is messed up, but please align it with the first letter of the
> parameters not the "(".
> 
> With that fixed: Reviewed-by: Karol Herbst <karolherbst@gmail.com>
> 
> On Tue, Jul 17, 2018 at 2:07 AM, Lyude Paul <lyude@redhat.com> wrote:
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > index 44178b4c3599..d556f24c6c48 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > @@ -655,7 +655,7 @@ nouveau_read_string(struct device *dev, enum
> > hwmon_sensor_types type, u32 attr,
> > 
> >  static int
> >  nouveau_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> > -                                                       int channel, long
> > *val)
> > +            int channel, long *val)
> >  {
> >         switch (type) {
> >         case hwmon_chip:
> > @@ -677,7 +677,7 @@ nouveau_read(struct device *dev, enum
> > hwmon_sensor_types type, u32 attr,
> > 
> >  static int
> >  nouveau_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> > -                                                       int channel, long
> > val)
> > +             int channel, long val)
> >  {
> >         switch (type) {
> >         case hwmon_temp:
> > --
> > 2.17.1
> > 
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
-- 
Cheers,
	Lyude Paul

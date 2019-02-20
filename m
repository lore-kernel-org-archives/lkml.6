Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B83C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C188D2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBTNSv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:18:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35931 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:18:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so26807672qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jM9Jw3aefaKq+H2j+be/k/Ar6QLO2mjo2F1yZuiawdI=;
        b=TttPKO6y3ad80ALpCtbCpOAaHjYTQMPXRwi0L7XaDGVRUWEbKRBPDbDuGRRVRgcPC2
         a6JtyHNs9aUZAG2X1oIJB4PUozRm2FMgOcjigs1qkpaIOx8uphdZg9IPYim3dAaM4oBU
         nUCYIJrlkaqru6DzZXFGfdLjGT7SPSkRzFhaRhrS29U+O3bSUH80AmDr4FhRsaE3fQjC
         P+d86Z9isGAm2Jzado3TSDuHeWuDp144LhmMwyoPWAcictZotWjMZOj56I+W9le7fkQu
         HgnUoAkTj+x4rBR8LdtqN769Wt6KMEbu/XPHFKY6wXtAP11z5buII83nfHbhKpAV0+nC
         UFfQ==
X-Gm-Message-State: AHQUAuYHTo7HKUv23Y0Km3wd+EmE/rnD1Iw/E/tMJUXJ7P0biXS1e6RK
        Z9iX4rNvmMuOfEACrgTEMv6K1bWzZYGbKbpmcXE=
X-Google-Smtp-Source: AHgI3IZeqeQugYiEdR6EYrPjJWVBGALk5nTuDudEdlIatk05LGXbg83xZwYiXEtk6t0fLob1vUE/JpR1WUyDSdNevMQ=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr12817677qtb.343.1550668729035;
 Wed, 20 Feb 2019 05:18:49 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
 <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com> <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
 <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
In-Reply-To: <CAA93ih2t34qwVB==LoF2odOCEOd9EE06i3hz0eTuonnXjJCyDw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 14:18:31 +0100
Message-ID: <CAK8P3a3DmKjTNXo8ufExaQxEsQX=MAYymeARbEzu8QXsCJFfiA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 2:16 PM Masami Hiramatsu
<masami.hiramatsu@linaro.org> wrote:
> 2019年2月20日(水) 21:28 Arnd Bergmann <arnd@arndb.de>:
> > On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
> > <sugaya.taichi@socionext.com> wrote:
> > > On 2019/02/20 18:28, Arnd Bergmann wrote:
> > > > On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> > > > <sugaya.taichi@socionext.com> wrote:
> > > >
> > > >> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> > > >> new file mode 100644
> > > >> index 0000000..a263211
> > > >> --- /dev/null
> > > >> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> > > >> @@ -0,0 +1,175 @@
> > > >
> > > > I no longer see anything here that should be turned off, but you
> > > > might want to run 'make savedefconfig' and use the output of that,
> > > > to make it easier to keep it up to date.
> > > >
> > >
> > > I got it, I use the output of 'make savedefconfig'.
> > > One question, is that OK to add some options on it?
> > >   -Because "CONFIG_ARCH_MILBEAUT" was not listed.
> >
> > What I'd do here is to apply all the patches you want to get merged in
> > the next few releases before running 'savedefconfig' and use the output
> > of that.
>
> Let me check. Would you mean that the defconfig will include all those
> drivers configs, which will not appear at this moment?

Correct.

> > If you already know that you will need the options, including
> > them now means you don't have to update the defconfig file
> > as much in the future.
>
> I just concern that if other subsystem maintainer comments
> on the config name. Even in that case, can we just update the
> defconfig with new name?

Yes, that's easy enough.

      Arnd

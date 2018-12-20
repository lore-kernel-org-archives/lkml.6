Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9FF217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BJGVpu1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbeLTNNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:13:50 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33360 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeLTNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:13:49 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wBKDDMEQ027669;
        Thu, 20 Dec 2018 22:13:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBKDDMEQ027669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545311602;
        bh=vBsqhUnkcX+Cw8tH/LhB5lUjlmPdpWIo2EEGfiaInzw=;
        h=From:Date:Subject:To:Cc:From;
        b=BJGVpu1n/sROqVd5jakJdkXZGArSMHStt/TvYHNvvRldfaB6IK8naTqfObaLXiEwd
         U1MgGKcu/e9ER6LJ6VCmsuqUWM8kUwFLbgPNeQrNIVNynJXJJ9EtBe8/JZntJtNtnv
         /roCDdF0euaWqKIrOGJxuGnQ0syKAyBqU1lUSQrdwsxbA4OeO1QNvr+e8sWL2wgx5B
         NT1EvFymz+/mQSgjUblTCb0gBioyxbO3kTfC7dsi2PqqiIn3YfaDDIun+CoFvW3L8f
         bEQUrQpfZoVovuDGzP5eFT3mAfEISYmG9LzqmMjsxwKMYQIrIVJVrAsr+VvG7M0HWX
         bRKIFGZzDHNGA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id h78so1029352vsi.6;
        Thu, 20 Dec 2018 05:13:22 -0800 (PST)
X-Gm-Message-State: AA+aEWZwb5tmo8sWTd+8+TvoXKO6fPvh0W5wt/M9ph5bTE+SVN6KXnDM
        gBCavyegooeT5RW4BlXcts3X9GLayGQznLTIo5A=
X-Google-Smtp-Source: AFSGD/UVGywGyHyPQJNYpBVhWjHgWMida9/LqboIM6kmlhUf4YgPLLwBiR109Xx/qlM3N9I26AGIesPTkOqTkPBkqaY=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr5361457vsm.181.1545311601124;
 Thu, 20 Dec 2018 05:13:21 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 20 Dec 2018 22:12:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHKJzY9giP-A5Q5+tp_JuH_bnDTzgbGnBCiAMbCVVevw@mail.gmail.com>
Message-ID: <CAK7LNAQHKJzY9giP-A5Q5+tp_JuH_bnDTzgbGnBCiAMbCVVevw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull one fix for v4.20 release.

Thanks!



The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.20-2

for you to fetch changes up to ef7cfd00b2caf6edeb7f169682b64be2d0a798cf:

  kbuild: fix false positive warning/error about missing libelf
(2018-12-20 00:04:15 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.20 (2nd)

 - fix false positive warning/error about missing library for objtool

----------------------------------------------------------------
Masahiro Yamada (1):
      kbuild: fix false positive warning/error about missing libelf

 Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)


-- 
Best Regards
Masahiro Yamada

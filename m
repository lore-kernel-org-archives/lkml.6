Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeCPALz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:11:55 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41837 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCPALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:11:53 -0400
X-Google-Smtp-Source: AG47ELvMx/HZyHVlLt7wVfMEENuPIQZdjJMcWPuqINNd4Km3l2m1Hk3Tbzy+PF5SZEbSkXG38kVWzV55dHF16IbaJbE=
MIME-Version: 1.0
In-Reply-To: <20180315183700.3843-3-jglisse@redhat.com>
References: <20180315183700.3843-1-jglisse@redhat.com> <20180315183700.3843-3-jglisse@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 16 Mar 2018 11:11:52 +1100
Message-ID: <CAKTCnz=dGz-yoONiG+0Ajf-S6EePyMvHmNvndHA-QtfkqjXWZw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/hmm: fix header file if/else/endif maze
To: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2G0BxWD003650

On Fri, Mar 16, 2018 at 5:36 AM,  <jglisse@redhat.com> wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
>
> The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.
>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>

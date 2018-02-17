Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeBQAJE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:09:04 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:54979 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeBQAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:09:03 -0500
X-Google-Smtp-Source: AH8x225mPhpks1qMuDSiYRKpOez7ZjtA9Y0fkxMLnRAGUFuqHlEmuVK7bUkIZ/dzgVZfZHpwLzGk3MYcsRvqu1jqTA4=
MIME-Version: 1.0
References: <20170807195027.13192-1-mjg59@google.com> <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
 <20180215152514.rxmh7webdg2i2fct@redbean> <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
 <ff79053c-4a4c-714e-4098-bf973eaefd63@pmhahn.de>
In-Reply-To: <ff79053c-4a4c-714e-4098-bf973eaefd63@pmhahn.de>
From: Matthew Garrett <mjg59@google.com>
Date: Sat, 17 Feb 2018 00:08:51 +0000
Message-ID: <CACdnJuv4nKbrzzyJ9dAEgUqNSuZpCF6ARRK91f0fa6639G217g@mail.gmail.com>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures configurable
To: pmhahn@pmhahn.de
Cc: Jessica Yu <jeyu@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:25 AM Philipp Hahn <pmhahn@pmhahn.de> wrote:
> Sadly didn't work for me :-(
> If my understanding is correct and iff that would work, Debian (and
> others) could load their public key into Shim and then use the
> associated private key for singing their modules.

This works for UEFI systems, but distributions have to support non-UEFI as
well.

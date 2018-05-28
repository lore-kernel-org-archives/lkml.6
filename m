Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbeE1VlN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:41:13 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42391 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934294AbeE1VlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:41:10 -0400
X-Google-Smtp-Source: ADUXVKLDphph2upkbHwqvyaoO9o91/bTnu5Nl/DQTDG5To3Xcone0fgfsVhwLM5lgiPWBNETPljyfvOWjrAUFYJBuxc=
MIME-Version: 1.0
In-Reply-To: <1527540057.30075.21.camel@gnu.org>
References: <1527540057.30075.21.camel@gnu.org>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 28 May 2018 23:40:39 +0200
Message-ID: <CAEJqkggH=_eKUJgigxYqfxGuJhQZ4bCaX5n-jqQ2kBAXtHuDuA@mail.gmail.com>
Subject: Re: Linux and autoconfig of kernel on iso-image boot.
To: egnuph@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-28 22:40 GMT+02:00 Phillip Hugo <egnuph@googlemail.com>:
> Hi all, thanks for your work.
>
> Linux should have "make grab_config" that sets loaded modules to be
> built in the kernel build and make modules.
>

make localmodconfig ?

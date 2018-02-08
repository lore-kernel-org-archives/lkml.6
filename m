Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHTil (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:38:41 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43967 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBHTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:38:40 -0500
X-Google-Smtp-Source: AH8x226JH3IIksyrtdwnR0O9vbsrGVQP1oLH9TLX85Bj+VWUOA5HRqK3oGbZ2fsIMtCMhguTrYUpUtv8EnOZx10hG04=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802072149330.7021@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1802072149330.7021@knanqh.ubzr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 11:38:38 -0800
X-Google-Sender-Auth: WmYWmGLhYhl1_GE8XiWxIFGZlpE
Message-ID: <CA+55aFzHtRbis95-D-nLB6v_FM8ZVPU6Wt=A04bG2zH+RukhaA@mail.gmail.com>
Subject: Re: [PATCH] cramfs: better MTD dependency expression
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 7:08 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> Viro once told me that my cramfs pull requests could go either to him or
> to you. I have only this one patch at the moment, and since it depends
> on a commit that recently appeared in your tree I'm therefore sending it
> directly to you.

Applied.

Although I'm not entirely convinced that the simpler dependency is
easier to _read_ and understand.

It is clearly simpler, though.

            Linus

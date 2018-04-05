Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeDEL6S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:58:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45573 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeDEL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:58:14 -0400
X-Google-Smtp-Source: AIpwx4+vFAJiSqb8G+6+DqZxSv7+y7W+n8kwD+4H7+tgDkVsiwWwCnRm6Sk4U3X4y0ZGEdrk0wUkh7dujul4+yNV/yk=
MIME-Version: 1.0
In-Reply-To: <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
 <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com> <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 13:58:12 +0200
X-Google-Sender-Auth: TuKZ0ZAUJNNrPy37g-qxA1DSvwI
Message-ID: <CAK8P3a2ovkToy5Yv=15_tyM8GUoZfSJ2QdhGev=fNSRCAj9bCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 1:48 PM,  <okaya@codeaurora.org> wrote:
> On 2018-04-05 03:00, Arnd Bergmann wrote:

>> The other four patches look perfect already.  What's the timing we need
>> for
>> these patches? Are they 4.18 material, or do we need them in 4.17 and
>> stable kernels to work around known bugs?
>
>
> I was hoping to get all arch stuff in for 4.17.
>
> Driver developers started removing redundant wmb().

Ok, so 4.17 but no stable backports then.

     Arnd

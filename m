Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDQAzU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 20:55:20 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37832 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeDQAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 20:55:18 -0400
X-Google-Smtp-Source: AIpwx482JkOto7mzNpp3jHnoB9fhRyNGHtR1GuENoebl/X1CtjflOZ1Quj2jxZjYIchlB0nYXIwsV2DafHdrLfGmDC4=
MIME-Version: 1.0
In-Reply-To: <e7b554d738de83268f4fc06dd6f12ada@lycos.com>
References: <e7b554d738de83268f4fc06dd6f12ada@lycos.com>
From: "\\0xDynamite" <dreamingforward@gmail.com>
Date: Mon, 16 Apr 2018 19:55:16 -0500
Message-ID: <CAMjeLr-A7z=A3E3yqnZ_PZhekZPxhCDP=Cb0aWhemmv3MNAoPA@mail.gmail.com>
Subject: Re: On the kernel numbering scheme
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > The current kernel numbering scheme makes no sense at all because the
> first two numbers don't represent anything at all. They had some meaning
> back in the 1.x 2.x 3.x days but then with the introduction of the new
> rolling development model, they became worthless.
>
> I'd love to change the kernel numbering scheme to this:
>
> YYYY.RELEASE.PATCH_LEVEL
>
> So that the first kernel to be released in 2019 will be numbered
> 2019.0(.0),

If you're going to suggest changes, then you should do it like this:
Change major numbers ONLY when you've introduced a new incompatibility
with your API and increment minor numbers for everything else.  THEN,
the first number WILL mean something.  If your software changes
something outside the way users communicate with the kernel (major
changes) and just changes something that COULD affect other software,
then have multiple partitions in your release number, like 3.5.41.

Marxos

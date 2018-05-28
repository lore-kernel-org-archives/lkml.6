Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeE1Fb7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:31:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42827 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeE1Fb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:31:57 -0400
X-Google-Smtp-Source: ADUXVKLsc6+13Q5kBzOSSAub/+eNfB3VfIlMlT28dVBQWnibrfSQVv1sciFKYMOmt5N+W4c2wOg7WIetOJxM+V8/o3A=
MIME-Version: 1.0
From: xin tan <tanxin0725@gmail.com>
Date: Mon, 28 May 2018 13:31:56 +0800
Message-ID: <CAPt3h3X0MKiNotU7=bQWzd=sxwu4pkuw3YOvFU9qw23xu8v6oA@mail.gmail.com>
Subject: Can I use 'signed -off-by' to define maintainers' workload?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am a student from Peking University. I'm not sure if it's
appropriate to ask questions here. I have already tried other mailing
lists, but I got no reply. I am very sorry to bother all of you.

I am doing a research about the maintainers' workload in the Linux
kernel community. We all know that the commits submitted by the
developer will be reviewed layer by layer and eventually merged into
the main repository. Most commits have one or several signed-off-by
tags. The documentation from community about signed-off-by is
described as follows: The sign-off is a simple line at the end of the
explanation for the patch, which certifies that you wrote it or
otherwise have the right to pass it on as an open-source patch.
The documentation is very clear, which  means that only two types of
people can sign their name: 1. The author 2. The related maintainer. I
want to define the maintainer's workload by this tag. There are
several questions that I would like to consult you:

1) Do all the maintainers in the path from the author of the commits
to the mainline repository sign their name?

2) If the answer is yes, do the workload of subsystem maintainer and
the upper maintainer are the same in the code review? In other words,
whether is it possible that the first maintainer who merge the commits
submitted by the developer to its own repository spend a lot effort on
review? The upper maintainer is based on the trust of the lower layer
maintainer, and simply merges it into his/her own repository as long
as there is no compiling problem and also sign their name.

3) If the answer is no, why do some maintainers sign their names, and
some do not? Is it because these maintainers trust the lower layer
very much and feel that it is not necessary to review it?

4) Is there any special situation that leads to signing-off-by not
identifying all the maintainers in the path of the commits develiry?
For example, the upper maintainer does not trust the lower layer
maintainers, and he/she will contribute a new commits by himself
instead of passing by, so it will not record the maintainer of the
lower layer.
Or because this commit contains modification to several files and each
file has a specific maintainer, only one maintainer merged it to his
repository and signed his name.

In short, I would like to know how signed-off-by is used in the actual process.

I would be grateful if you could reply to me. Thank you again!

Best regards,
Xin Tan

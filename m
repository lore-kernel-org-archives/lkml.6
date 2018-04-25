Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755842AbeDYRbb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:31:31 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35228 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbeDYRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:31:26 -0400
X-Google-Smtp-Source: AIpwx480uHO7kkLGKy7tTawyVkGkF/8R4SjWPXtPxa1xc1MYnzH63Rghv1qYNxrMnEAN/LK+lwrPMEUSCL1sJLuu54A=
MIME-Version: 1.0
From: Sam Hansen <hansens@google.com>
Date: Wed, 25 Apr 2018 10:31:04 -0700
Message-ID: <CAP9bUy7Csp976xYOqmdk-8TM8v2YO6zurLqR3YxS_PByRj0eSA@mail.gmail.com>
Subject: git send-email duplicating messages?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have been sending patches out like:

$ git send-email --to=foo-list@vger.kernel.org \
  --cc-cmd='scripts/get_maintainer.pl -non -norolestats' \
  *.patch

For some reason, when git sends the emails, it sends each patch both
directly to, and also cc's, everyone mentioned by get_maintainer.pl.
So, everyone gets duplicate messages.  The get_maintainer.pl script,
when run manually, does not produce duplicate entries.

Has anyone run across this before?  I'd like to do the right thing,
but don't exactly know what I'm doing wrong.  Thanks.
